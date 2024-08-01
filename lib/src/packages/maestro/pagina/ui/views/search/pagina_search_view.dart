import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/data/models/request/pagina_request_model.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/domain/entities/pagina.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/domain/entities/request/pagina_request.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/ui/blocs/pagina_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/ui/views/field_modulo.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/inputs_with_titles/segmented_input_title.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class PaginaSearchView extends StatelessWidget {
  const PaginaSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaginaBloc, PaginaState>(
      listener: (BuildContext context, PaginaState state) {
        if (state.status == PaginaStatus.exception) {
          CustomToast.showError(context, state.exception!);
        }
      },
      builder: (BuildContext context, PaginaState state) {
        return Stack(
          children: <Widget>[
            ListView(
              padding: const EdgeInsets.only(right: 32, top: 8),
              physics: const ClampingScrollPhysics(),
              children: <Widget>[
                const BuildViewDetail(),
                CardExpansionPanel(title: "Buscar Registros.", icon: Icons.search, child: _BuildFieldsForm(state)),
                const _BuildDataTable(),
              ],
            ),
            if (state.status == PaginaStatus.loading) const LoadingModal(),
          ],
        );
      },
    );
  }
}

class _BuildFieldsForm extends StatelessWidget {
  final PaginaState state;
  const _BuildFieldsForm(this.state);
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final PaginaBloc paginaBloc = context.read<PaginaBloc>();
    final PaginaRequest request = paginaBloc.request;

    void onPressed() {
      if (request.hasNonNullField()) {
        paginaBloc.add(const GetPaginaEvent());
      } else {
        paginaBloc.add(const ErrorFormPaginaEvent("Por favor diligenciar por lo menos un campo del formulario"));
      }
    }

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BuildFormFields(
            children: <Widget>[
              NumberInputTitle(
                title: "Codigo",
                autofocus: true,
                initialValue: request.codigo != null ? "${request.codigo}" : "",
                onChanged: (String result) {
                  request.codigo = result.isNotEmpty ? int.parse(result) : null;
                },
              ),
              TextInputTitle(
                title: "Nombre",
                typeInput: TypeInput.lettersAndNumbers,
                initialValue: request.nombre != null ? request.nombre! : "",
                onChanged: (String result) {
                  request.nombre = result.isNotEmpty ? result : null;
                },
              ),
              FieldModulo(request.modulo),
              SegmentedInputTitle(
                title: "Visible",
                optionSelected: request.isVisible,
                onChanged: (bool? newValue) => request.isVisible = newValue,
              ),
              SegmentedInputTitle(
                title: "Activo",
                optionSelected: request.isActivo,
                onChanged: (bool? newValue) => request.isActivo = newValue,
              ),
            ],
          ),
          FormButton(label: "Buscar", icon: Icons.search, onPressed: onPressed),
        ],
      ),
    );
  }
}

class _BuildDataTable extends StatefulWidget {
  const _BuildDataTable();
  @override
  State<_BuildDataTable> createState() => _BuildDataTableState();
}

class _BuildDataTableState extends State<_BuildDataTable> {
  List<Map<String, dynamic>> listUpdate = <Map<String, dynamic>>[];

  @override
  Widget build(BuildContext context) {
    void onRowChecked(List<Map<String, dynamic>> event) {
      listUpdate.clear();
      setState(() => listUpdate.addAll(event));
    }

    void onPressedSave() {
      final List<PaginaRequest> requestList = <PaginaRequest>[];
      for (final Map<String, dynamic> map in listUpdate) {
        final PaginaRequest request = PaginaRequestModel.fromTable(map);
        requestList.add(request);
      }
      context.read<PaginaBloc>().add(UpdatePaginaEvent(requestList));
    }

    Map<String, DataItemGrid> buildPlutoRowData(Pagina pagina, AutocompleteSelect autocompleteSelect) {
      return <String, DataItemGrid>{
        'codigo': DataItemGrid(type: Tipo.item, value: pagina.paginaCodigo, edit: false),
        'nombre': DataItemGrid(type: Tipo.text, value: pagina.paginaTexto, edit: true),
        'path': DataItemGrid(type: Tipo.text, value: pagina.paginaPath, edit: false),
        'modulo': DataItemGrid(type: Tipo.select, value: pagina.modulo, edit: true, autocompleteSelect: autocompleteSelect),
        'fecha_creacion': DataItemGrid(type: Tipo.date, value: pagina.fechaCreacion, edit: false),
        'visible': DataItemGrid(type: Tipo.boolean, value: pagina.paginaVisible, edit: true),
        'activo': DataItemGrid(type: Tipo.boolean, value: pagina.paginaActivo, edit: true),
      };
    }

    return BlocBuilder<PaginaBloc, PaginaState>(
      builder: (BuildContext context, PaginaState state) {
        if (state.status == PaginaStatus.consulted) {
          final List<Map<String, DataItemGrid>> plutoRes = <Map<String, DataItemGrid>>[];
          for (final Pagina pagina in state.paginas) {
            final AutocompleteSelect autocompleteSelect = AutocompleteSelect(
              entryMenus: state.entriesModulos,
              entryCodigoSelected: pagina.modulo,
            );
            final Map<String, DataItemGrid> rowData = buildPlutoRowData(pagina, autocompleteSelect);
            plutoRes.add(rowData);
          }
          if (plutoRes.isEmpty) {
            return const Text("No se encontraron resultados...");
          }
          return PlutoGridDataBuilder(plutoData: plutoRes, onRowChecked: onRowChecked, onPressedSave: onPressedSave);
        }
        return const SizedBox();
      },
    );
  }
}

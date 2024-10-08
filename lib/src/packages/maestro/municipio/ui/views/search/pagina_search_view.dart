import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/config/share_preferences/preferences.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/data/models/request/pagina_request_model.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/domain/entities/pagina.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/domain/entities/request/pagina_request.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/ui/blocs/pagina_bloc.dart';
import 'package:switrans_2_0/src/util/shared/models/entry_autocomplete.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class PaginaSearchView extends StatelessWidget {
  const PaginaSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaginaBloc, PaginaState>(
      listener: (BuildContext context, PaginaState state) {
        Preferences.usuarioNombre;
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
              NumberInputForm(
                title: "Codigo",
                value: request.codigo,
                autofocus: true,
                onChanged: (String result) => request.codigo = result.isNotEmpty ? int.parse(result) : null,
              ),
              TextInputForm(
                title: "Nombre",
                value: request.nombre,
                typeInput: TypeInput.lettersAndNumbers,
                onChanged: (String result) => request.nombre = result.isNotEmpty ? result : null,
              ),
              AutocompleteInputForm(
                title: "Modulos",
                entries: state.entriesModulos,
                value: request.modulo,
                onChanged: (EntryAutocomplete result) => request.modulo = result.codigo,
              ),
              SegmentedInputForm(
                title: "Visible",
                value: request.isVisible,
                onChanged: (bool? newValue) => request.isVisible = newValue,
              ),
              SegmentedInputForm(
                title: "Activo",
                value: request.isActivo,
                onChanged: (bool? newValue) => request.isActivo = newValue,
              ),
            ],
          ),
          FormButton(label: "Buscar", icon: Icons.search, onPressed: onPressed),
          if (state.status == PaginaStatus.error) ErrorModal(title: state.error),
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
    return BlocBuilder<PaginaBloc, PaginaState>(
      builder: (BuildContext context, PaginaState state) {
        if (state.status == PaginaStatus.consulted) {
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

          Map<String, DataItemGrid> buildPlutoRowData(Pagina pagina) {
            return <String, DataItemGrid>{
              'codigo': DataItemGrid(type: Tipo.item, value: pagina.codigo, edit: false),
              'nombre': DataItemGrid(type: Tipo.text, value: pagina.texto, edit: true),
              'path': DataItemGrid(type: Tipo.text, value: pagina.path, edit: false),
              'modulo': DataItemGrid(type: Tipo.select, value: pagina.modulo, edit: true, entryMenus: state.entriesModulos),
              'fecha_creacion': DataItemGrid(type: Tipo.date, value: pagina.fechaCreacion, edit: false),
              'visible': DataItemGrid(type: Tipo.boolean, value: pagina.isVisible, edit: true),
              'activo': DataItemGrid(type: Tipo.boolean, value: pagina.isActivo, edit: true),
            };
          }

          final List<Map<String, DataItemGrid>> plutoRes = <Map<String, DataItemGrid>>[];
          for (final Pagina pagina in state.paginas) {
            final Map<String, DataItemGrid> rowData = buildPlutoRowData(pagina);
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

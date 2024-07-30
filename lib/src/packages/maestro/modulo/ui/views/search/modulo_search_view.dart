import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/data/models/request/modulo_request_model.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/modulo.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/request/modulo_request.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/ui/blocs/modulo_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/ui/views/field_paquete.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
import 'package:switrans_2_0/src/util/shared/views/loading_view.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/toasts/custom_toasts.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class ModuloSearchView extends StatelessWidget {
  const ModuloSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ModuloBloc, ModuloState>(
      listener: (BuildContext context, ModuloState state) {
        if (state.status == ModuloStatus.exception) {
          CustomToast.showError(context, state.exception!);
        }
      },
      builder: (BuildContext context, ModuloState state) {
        if (state.status == ModuloStatus.loading) {
          return const LoadingView();
        }
        return ListView(
          padding: const EdgeInsets.only(right: 32, top: 8),
          children: <Widget>[
            const BuildViewDetail(),
            CardExpansionPanel(title: "Buscar Registros", icon: Icons.search, child: _BuildFieldsForm(state)),
            const _BluildDataTable(),
          ],
        );
      },
    );
  }
}

class _BuildFieldsForm extends StatelessWidget {
  final ModuloState state;
  const _BuildFieldsForm(this.state);
  @override
  Widget build(BuildContext context) {
    bool isActivo = true;

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final ModuloBloc moduloBloc = context.read<ModuloBloc>();
    final ModuloRequest request = moduloBloc.request;

    void onPressed() {
      if (request.hasNonNullField()) {
        context.read<ModuloBloc>().add(const GetModuloEvent());
      } else {
        moduloBloc.add(const ErrorFormModuloEvent("Por favor diligenciar por lo menos un campo del formulario"));
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
              FieldPaquete(request.paquete),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Activo", style: AppTheme.titleStyle),
                  const SizedBox(height: 8),
                  SwitchBoxInput(value: isActivo, onChanged: (bool newValue) => isActivo = newValue),
                ],
              ),
            ],
          ),
          FormButton(label: "Buscar", icon: Icons.search, onPressed: onPressed),
          state.status == ModuloStatus.error ? ErrorModal(title: state.error!) : const SizedBox(),
        ],
      ),
    );
  }
}

class _BluildDataTable extends StatefulWidget {
  const _BluildDataTable();

  @override
  State<_BluildDataTable> createState() => _BluildDataTableState();
}

class _BluildDataTableState extends State<_BluildDataTable> {
  List<Map<String, dynamic>> listUpdate = <Map<String, dynamic>>[];

  @override
  Widget build(BuildContext context) {
    void onRowChecked(List<Map<String, dynamic>> event) {
      listUpdate.clear();
      setState(() => listUpdate.addAll(event));
    }

    void onPressedSave() {
      final List<ModuloRequest> requestList = <ModuloRequest>[];
      for (final Map<String, dynamic> map in listUpdate) {
        final ModuloRequest request = ModuloRequestModel.fromMap(map);
        requestList.add(request);
      }
      context.read<ModuloBloc>().add(UpdateModuloEvent(requestList));
    }

    Map<String, DataItemGrid> buildPlutoRowData(Modulo modulo, AutocompleteSelect autocompleteSelect) {
      return <String, DataItemGrid>{
        'codigo': DataItemGrid(type: Tipo.item, value: modulo.codigo, edit: false),
        'nombre': DataItemGrid(type: Tipo.text, value: modulo.nombre, edit: true),
        'detalles': DataItemGrid(type: Tipo.text, value: modulo.detalles, edit: true),
        'path': DataItemGrid(type: Tipo.text, value: modulo.path, edit: false),
        'icono': DataItemGrid(type: Tipo.text, value: modulo.icono, edit: false),
        'paquete': DataItemGrid(type: Tipo.select, value: modulo.paquete, edit: false, autocompleteSelect: autocompleteSelect),
        'fecha_creacion': DataItemGrid(type: Tipo.date, value: modulo.fechaCreacion, edit: false),
        'activo': DataItemGrid(type: Tipo.boolean, value: modulo.isActivo, edit: false),
        'visible': DataItemGrid(type: Tipo.boolean, value: modulo.isVisible, edit: true),
      };
    }

    return BlocBuilder<ModuloBloc, ModuloState>(
      builder: (BuildContext context, ModuloState state) {
        if (state.status == ModuloStatus.consulted) {
          final List<Map<String, DataItemGrid>> plutoRes = <Map<String, DataItemGrid>>[];
          for (final Modulo modulo in state.modulos) {
            final AutocompleteSelect autocompleteSelect = AutocompleteSelect(
              entryMenus: state.entriesPaquete,
              entryCodigoSelected: modulo.paquete,
            );
            final Map<String, DataItemGrid> rowData = buildPlutoRowData(modulo, autocompleteSelect);
            plutoRes.add(rowData);
          }
          if (plutoRes.isEmpty) {
            return const Text("No se encontraron resultados");
          }
          return PlutoGridDataBuilder(plutoData: plutoRes, onRowChecked: onRowChecked, onPressedSave: onPressedSave);
        }
        return const SizedBox();
      },
    );
  }
}

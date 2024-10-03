import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/data/models/request/modulo_request_model.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/modulo.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/request/modulo_request.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/ui/blocs/modulo_bloc.dart';
import 'package:switrans_2_0/src/util/shared/models/entry_autocomplete.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';
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
        return Stack(
          children: <Widget>[
            ListView(
              padding: const EdgeInsets.only(right: 32, top: 8),
              children: <Widget>[
                const BuildViewDetail(),
                CardExpansionPanel(title: "Buscar Registros", icon: Icons.search, child: _BuildFieldsForm(state)),
                const _BluildDataTable(),
              ],
            ),
            if (state.status == ModuloStatus.loading) const LoadingModal(),
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
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final ModuloBloc moduloBloc = context.read<ModuloBloc>();
    final ModuloRequest request = moduloBloc.request;

    void onPressed() {
      if (request.hasNonNullField()) {
        moduloBloc.add(GetModuloEvent(request));
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
              NumberInputForm(
                title: "Codigo",
                value: request.codigo,
                autofocus: true,
                onChanged: (String result) => request.codigo = result.isNotEmpty ? int.parse(result) : null,
              ),
              TextInputForm(
                title: "Nombre",
                value: request.nombre != null ? request.nombre! : "",
                typeInput: TypeInput.lettersAndNumbers,
                onChanged: (String result) => request.nombre = result.isNotEmpty ? result : null,
              ),
              AutocompleteInputForm(
                entries: state.entriesPaquete,
                title: "Paquete",
                value: request.paquete,
                onChanged: (EntryAutocomplete result) => request.paquete = result.codigo,
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
          if (state.status == ModuloStatus.error) ErrorModal(title: state.error!),
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
    return BlocBuilder<ModuloBloc, ModuloState>(
      builder: (BuildContext context, ModuloState state) {
        if (state.status == ModuloStatus.consulted) {
          void onRowChecked(List<Map<String, dynamic>> event) {
            listUpdate.clear();
            setState(() => listUpdate.addAll(event));
          }

          void onPressedSave() {
            final List<ModuloRequest> requestList = <ModuloRequest>[];
            for (final Map<String, dynamic> map in listUpdate) {
              final ModuloRequest request = ModuloRequestModel.fromTable(map);
              requestList.add(request);
            }
            context.read<ModuloBloc>().add(UpdateModuloEvent(requestList));
          }

          Map<String, DataItemGrid> buildPlutoRowData(Modulo modulo) {
            return <String, DataItemGrid>{
              'codigo': DataItemGrid(type: Tipo.item, value: modulo.codigo, edit: false),
              'nombre': DataItemGrid(type: Tipo.text, value: modulo.nombre, edit: true),
              'detalles': DataItemGrid(type: Tipo.text, value: modulo.detalles, edit: true),
              'path': DataItemGrid(type: Tipo.text, value: modulo.path, edit: false),
              'icono': DataItemGrid(type: Tipo.text, value: modulo.icono, edit: false),
              'paquete': DataItemGrid(type: Tipo.select, value: modulo.paquete, edit: false, entryMenus: state.entriesPaquete),
              'fecha_creacion': DataItemGrid(type: Tipo.date, value: modulo.fechaCreacion, edit: false),
              'activo': DataItemGrid(type: Tipo.boolean, value: modulo.isActivo, edit: false),
              'visible': DataItemGrid(type: Tipo.boolean, value: modulo.isVisible, edit: true),
            };
          }

          final List<Map<String, DataItemGrid>> plutoRes = <Map<String, DataItemGrid>>[];
          for (final Modulo modulo in state.modulos) {
            final Map<String, DataItemGrid> rowData = buildPlutoRowData(modulo);
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

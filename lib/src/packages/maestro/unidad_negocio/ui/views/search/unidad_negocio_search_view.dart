import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/data/models/request/unidad_negocio_request_model.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/domain/entities/request/unidad_negocio_request.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/domain/entities/unidad_negocio.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/ui/blocs/unidad_negocio/unidad_negocio_bloc.dart';
import 'package:switrans_2_0/src/util/resources/entity_update.dart';
import 'package:switrans_2_0/src/util/shared/models/entry_autocomplete.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class UnidadNegocioSearchView extends StatelessWidget {
  const UnidadNegocioSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UnidadNegocioBloc, UnidadNegocioState>(
      listener: (BuildContext context, UnidadNegocioState state) {
        if (state.status == UnidadNegocioStatus.exception) {
          CustomToast.showError(context, state.exception!);
        }
      },
      builder: (BuildContext context, UnidadNegocioState state) {
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
            if (state.status == UnidadNegocioStatus.loading) const LoadingModal(),
          ],
        );
      },
    );
  }
}

class _BuildFieldsForm extends StatelessWidget {
  final UnidadNegocioState state;
  const _BuildFieldsForm(this.state);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final UnidadNegocioBloc unidadNegocioBloc = context.watch<UnidadNegocioBloc>();
    final UnidadNegocioRequest request = unidadNegocioBloc.request;

    void onPressed() {
      if (request.hasNonNullField()) {
        unidadNegocioBloc.add(GetUnidadNegocioEvent(request));
      } else {
        unidadNegocioBloc.add(const ErrorFormUnidadNegocioEvent("Por favor diligenciar por lo menos un campo del formulario"));
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
              AutocompleteInputForm(
                entries: state.entriesEmpresa,
                title: "Empresa",
                value: request.empresa,
                onChanged: (EntryAutocomplete result) => request.empresa = result.codigo,
              ),
              TextInputForm(
                title: "Nombre",
                value: request.nombre != null ? request.nombre! : "",
                typeInput: TypeInput.lettersAndNumbers,
                onChanged: (String result) => request.nombre = result.isNotEmpty ? result : null,
              ),
              SegmentedInputForm(
                title: "Activo",
                value: request.isActivo,
                onChanged: (bool? newValue) => request.isActivo = newValue,
              ),
            ],
          ),
          FormButton(label: "Buscar", icon: Icons.search, onPressed: onPressed),
          if (state.status == UnidadNegocioStatus.error) ErrorModal(title: state.error!),
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
    return BlocBuilder<UnidadNegocioBloc, UnidadNegocioState>(
      builder: (BuildContext context, UnidadNegocioState state) {
        if (state.status == UnidadNegocioStatus.consulted) {
          void onRowChecked(List<Map<String, dynamic>> event) {
            listUpdate.clear();
            setState(() => listUpdate.addAll(event));
          }

          void onPressedSave() {
            final List<EntityUpdate<UnidadNegocioRequest>> requestList = <EntityUpdate<UnidadNegocioRequest>>[];
            for (final Map<String, dynamic> map in listUpdate) {
              final UnidadNegocioRequest request = UnidadNegocioRequestModel.fromMapTable(map);
              requestList.add(EntityUpdate<UnidadNegocioRequest>(id: map["id"], entity: request));
            }
            context.read<UnidadNegocioBloc>().add(UpdateUnidadNegocioEvent(requestList));
          }

          Map<String, DataItemGrid> buildPlutoRowData(UnidadNegocio unidadNegocio) {
            return <String, DataItemGrid>{
              'codigo': DataItemGrid(type: Tipo.item, value: unidadNegocio.codigo, edit: false),
              'nombre': DataItemGrid(type: Tipo.text, value: unidadNegocio.nombre, edit: true),
              'isActivo': DataItemGrid(type: Tipo.boolean, value: unidadNegocio.isActivo, edit: true),
              'fechaCreacion': DataItemGrid(type: Tipo.date, value: unidadNegocio.fechaCreacion, edit: false),
              'usuario': DataItemGrid(type: Tipo.text, value: unidadNegocio.usuario, edit: false),
              'empresa': DataItemGrid(type: Tipo.select, value: unidadNegocio.empresa, edit: false, entryMenus: state.entriesEmpresa),
            };
          }

          final List<Map<String, DataItemGrid>> plutoRes = <Map<String, DataItemGrid>>[];
          for (final UnidadNegocio unidadNegocio in state.unidadNegocios) {
            final Map<String, DataItemGrid> rowData = buildPlutoRowData(unidadNegocio);
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

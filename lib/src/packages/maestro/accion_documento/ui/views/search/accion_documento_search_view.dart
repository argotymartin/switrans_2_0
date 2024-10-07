import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/data/models/request/accion_documento_request_model.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/accion_documento_domain.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/ui/blocs/accion_documentos/accion_documento_bloc.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';
import 'package:switrans_2_0/src/util/shared/views/views_shared.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class AccionDocumentoSearchView extends StatelessWidget {
  const AccionDocumentoSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccionDocumentoBloc, AccionDocumentoState>(
      listener: (BuildContext context, AccionDocumentoState state) {
        if (state.status == AccionDocumentoStatus.exception) {
          CustomToast.showError(context, state.exception!);
        }
      },
      builder: (BuildContext context, AccionDocumentoState state) {
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
            if (state.status == AccionDocumentoStatus.loading) const LoadingModal(),
          ],
        );
      },
    );
  }
}

class _BuildFieldsForm extends StatelessWidget {
  final AccionDocumentoState state;
  const _BuildFieldsForm(this.state);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final AccionDocumentoBloc accionDocumentoBloc = context.watch<AccionDocumentoBloc>();
    final AccionDocumentoRequest request = accionDocumentoBloc.request;

    void onPressed() {
      if (request.hasNonNullField()) {
        accionDocumentoBloc.add(GetAccionDocumentoEvent(request));
      } else {
        accionDocumentoBloc.add(const ErrorFormAccionDocumentoEvent("Por favor diligenciar por lo menos un campo del formulario"));
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
                entries: state.entriesTiposDocumento,
                title: "Tipo Documento",
                value: request.tipoDocumento,
                onChanged: (EntryAutocomplete result) => request.tipoDocumento = result.codigo,
              ),
            ],
          ),
          FormButton(label: "Buscar", icon: Icons.search, onPressed: onPressed),
          state.status == AccionDocumentoStatus.error ? ErrorModal(title: state.error!) : const SizedBox(),
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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccionDocumentoBloc, AccionDocumentoState>(
      builder: (BuildContext context, AccionDocumentoState state) {
        if (state.status == AccionDocumentoStatus.consulted) {
          final List<Map<String, dynamic>> listUpdate = <Map<String, dynamic>>[];
          void onRowChecked(List<Map<String, dynamic>> event) {
            listUpdate.clear();
            setState(() => listUpdate.addAll(event));
          }

          void onPressedSave() {
            final List<AccionDocumentoRequest> requestList = <AccionDocumentoRequest>[];
            for (final Map<String, dynamic> map in listUpdate) {
              final AccionDocumentoRequest request = AccionDocumentoRequestModel.fromTable(map);
              requestList.add(request);
            }
            context.read<AccionDocumentoBloc>().add(UpdateAccionDocumentoEvent(requestList));
          }

          Map<String, DataItemGrid> buildPlutoRowData(AccionDocumento accionDocumento) {
            final List<EntryAutocomplete> entryMenus = state.entriesTiposDocumento;
            return <String, DataItemGrid>{
              'codigo': DataItemGrid(type: Tipo.item, value: accionDocumento.codigo, edit: false),
              'nombre': DataItemGrid(type: Tipo.text, value: accionDocumento.nombre, edit: true),
              'tipo_documento': DataItemGrid(type: Tipo.select, value: accionDocumento.tipoCodigo, edit: true, entryMenus: entryMenus),
              'naturaleza_inversa': DataItemGrid(type: Tipo.boolean, value: accionDocumento.esInverso, edit: true),
              'activo': DataItemGrid(type: Tipo.boolean, value: accionDocumento.esActivo, edit: true),
              'fecha_creacion': DataItemGrid(type: Tipo.date, value: accionDocumento.fechaCreacion, edit: false),
              'fecha_actualizacion': DataItemGrid(type: Tipo.date, value: accionDocumento.fechaActualizacion, edit: false),
              'usuario': DataItemGrid(type: Tipo.text, value: accionDocumento.usuario, edit: false),
            };
          }

          final List<Map<String, DataItemGrid>> plutoRes = <Map<String, DataItemGrid>>[];

          for (final AccionDocumento accionDocumento in state.accionDocumentos) {
            final Map<String, DataItemGrid> rowData = buildPlutoRowData(accionDocumento);
            plutoRes.add(rowData);
          }
          if (plutoRes.isEmpty) {
            return const Text("No se encontraon resultados");
          }
          return PlutoGridDataBuilder(plutoData: plutoRes, onRowChecked: onRowChecked, onPressedSave: onPressedSave);
        }
        return const SizedBox();
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/globals/login/ui/login_ui.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/data/data.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/domain.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/ui/blocs/accion_documento_bloc.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';
import 'package:switrans_2_0/src/util/shared/models/entry_autocomplete.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
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
        accionDocumentoBloc.add(GetAccionDocumentosEvent(request));
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
              SegmentedInputForm(
                title: "Activo",
                value: request.isActivo,
                onChanged: (bool? newValue) => request.isActivo = newValue,
              ),
              SegmentedInputForm(
                title: "Naturaleza",
                value: request.isInversa,
                onChanged: (bool? newValue) => request.isInversa = newValue,
              ),
              SegmentedInputForm(
                title: "Reversible",
                value: request.isReversible,
                onChanged: (bool? newValue) => request.isReversible = newValue,
              ),
              AutocompleteInputForm(
                entries: state.entriesDocumentos,
                title: "Documento",
                value: request.codigoDocumento,
                onChanged: (EntryAutocomplete result) => request.codigoDocumento = result.codigo,
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
  List<Map<String, dynamic>> listUpdate = <Map<String, dynamic>>[];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccionDocumentoBloc, AccionDocumentoState>(
      builder: (BuildContext context, AccionDocumentoState state) {
        if (state.status == AccionDocumentoStatus.consulted) {
          void onRowChecked(List<Map<String, dynamic>> event) {
            listUpdate.clear();
            setState(() => listUpdate.addAll(event));
          }

          void onPressedSave() {
            final List<EntityUpdate<AccionDocumentoRequest>> requestList = <EntityUpdate<AccionDocumentoRequest>>[];
            for (final Map<String, dynamic> map in listUpdate) {
              final AccionDocumentoRequest request = AccionDocumentoRequestModel.fromMap(map["data"]);
              request.codigoUsuario = context.read<AuthBloc>().state.auth?.usuario.codigo;
              requestList.add(EntityUpdate<AccionDocumentoRequest>(id: map["id"], entity: request));
            }
            context.read<AccionDocumentoBloc>().add(UpdateAccionDocumentosEvent(requestList));
          }

          Map<String, DataItemGrid> buildPlutoRowData(AccionDocumento accionDocumento) {
            return <String, DataItemGrid>{
              'codigo': DataItemGrid(
                title: "Codigo",
                type: Tipo.item,
                value: accionDocumento.codigo,
                edit: false,
              ),
              'nombre': DataItemGrid(
                title: "Nombre",
                type: Tipo.text,
                value: accionDocumento.nombre,
                edit: false,
              ),
              'codigoDocumento': DataItemGrid(
                title: "Documento",
                type: Tipo.text,
                value: accionDocumento.nombreDocumento,
                edit: false,
              ),
              'isActivo': DataItemGrid(
                title: "Activo",
                type: Tipo.boolean,
                value: accionDocumento.isActivo,
                edit: true,
              ),
              'isInverso': DataItemGrid(
                title: "Naturaza es Inversa?",
                type: Tipo.boolean,
                value: accionDocumento.isInverso,
                edit: true,
              ),
              'isRevesible': DataItemGrid(
                title: "Es Reversible?",
                type: Tipo.boolean,
                value: accionDocumento.isReversible,
                edit: true,
              ),
              'fechaCreacion': DataItemGrid(
                title: "Fecha Creacion",
                type: Tipo.date,
                value: accionDocumento.fechaCreacion,
                edit: false,
              ),
              'usuario': DataItemGrid(
                title: "Usuario",
                type: Tipo.text,
                value: accionDocumento.nombreUsuario,
                edit: false,
              ),
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

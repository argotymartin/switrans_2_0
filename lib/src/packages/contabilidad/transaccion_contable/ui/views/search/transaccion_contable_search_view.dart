import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/packages/contabilidad/transaccion_contable/data/data.dart';
import 'package:switrans_2_0/src/packages/contabilidad/transaccion_contable/domain/domain.dart';
import 'package:switrans_2_0/src/packages/contabilidad/transaccion_contable/ui/blocs/transaccion_contable/transaccion_contable_bloc.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';
import 'package:switrans_2_0/src/util/shared/models/entry_autocomplete.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class TransaccionContableSearchView extends StatelessWidget {
  const TransaccionContableSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TransaccionContableBloc, TransaccionContableState>(
      listener: (BuildContext context, TransaccionContableState state) {
        if (state.status == TransaccionContableStatus.exception) {
          CustomToast.showError(context, state.exception!);
        }
      },
      builder: (BuildContext context, TransaccionContableState state) {
        return Stack(
          children: <Widget>[
            ListView(
              padding: const EdgeInsets.only(right: 32, top: 8),
              physics: const ClampingScrollPhysics(),
              children: <Widget>[
                const BuildViewDetail(),
                CardExpansionPanel(title: "Buscar Registros**", icon: Icons.search, child: _BuildFieldsForm(state)),
                const _BluildDataTable(),
              ],
            ),
            if (state.status == TransaccionContableStatus.loading) const LoadingModal(),
          ],
        );
      },
    );
  }
}

class _BuildFieldsForm extends StatelessWidget {
  final TransaccionContableState state;
  const _BuildFieldsForm(
    this.state,
  );

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TransaccionContableBloc transaccionContableBloc = context.watch<TransaccionContableBloc>();
    final TransaccionContableRequest request = transaccionContableBloc.request;

    void onPressed() {
      if (request.hasNonNullField()) {
        transaccionContableBloc.add(GetTransaccionContablesEvent(request));
      } else {
        transaccionContableBloc.add(const ErrorFormTransaccionContableEvent("Por favor diligenciar por lo menos un campo del formulario"));
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
                entries: state.entriesTipoImpuestos,
                title: "Tipo Impuesto",
                value: request.tipoImpuesto,
                onChanged: (EntryAutocomplete result) => request.tipoImpuesto = result.codigo,
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
          if (state.status == TransaccionContableStatus.error) ErrorModal(title: state.error!),
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
    return BlocBuilder<TransaccionContableBloc, TransaccionContableState>(
      builder: (BuildContext context, TransaccionContableState state) {
        if (state.status == TransaccionContableStatus.consulted) {
          void onRowChecked(List<Map<String, dynamic>> event) {
            listUpdate.clear();
            setState(() => listUpdate.addAll(event));
          }

          void onPressedSave() {
            final List<EntityUpdate<TransaccionContableRequest>> requestList = <EntityUpdate<TransaccionContableRequest>>[];
            for (final Map<String, dynamic> map in listUpdate) {
              final TransaccionContableRequestModel request = TransaccionContableRequestModel.fromMap(map["data"]);
              requestList.add(EntityUpdate<TransaccionContableRequest>(id: map["id"], entity: request));
            }
            context.read<TransaccionContableBloc>().add(UpdateTransaccionContablesEvent(requestList));
          }

          Map<String, DataItemGrid> buildPlutoRowData(TransaccionContable transaccionContable) {
            return <String, DataItemGrid>{
              'codigo': DataItemGrid(
                title: "Codigo",
                type: Tipo.item,
                value: transaccionContable.codigo,
                edit: false,
              ),
              'nombre': DataItemGrid(
                title: "Nombre",
                type: Tipo.text,
                value: transaccionContable.nombre,
                edit: true,
              ),
              'sigla': DataItemGrid(
                title: "Sigla",
                type: Tipo.text,
                value: transaccionContable.sigla,
                edit: true,
              ),
              'isActivo': DataItemGrid(
                title: "Activo",
                type: Tipo.boolean,
                value: transaccionContable.isActivo,
                edit: true,
              ),
              'tipoimpuesto': DataItemGrid(
                title: "Tipo Impuesto",
                type: Tipo.select,
                value: transaccionContable.tipoimpuesto,
                edit: false,
                entryMenus: state.entriesTipoImpuestos,
              ),
              'secuencia': DataItemGrid(
                title: "Secuencia",
                type: Tipo.text,
                value: transaccionContable.orden,
                edit: false,
              ),
              'nombreUsuario': DataItemGrid(
                title: "Usuario",
                type: Tipo.text,
                value: transaccionContable.nombreUsuario,
                edit: false,
              ),
              'fechaCreacion': DataItemGrid(
                title: "Fecha Creacion",
                type: Tipo.date,
                value: transaccionContable.fechaCreacion,
                edit: false,
              ),
            };
          }

          final List<Map<String, DataItemGrid>> plutoRes = <Map<String, DataItemGrid>>[];
          for (final TransaccionContable transaccionContable in state.transaccionContables) {
            final Map<String, DataItemGrid> rowData = buildPlutoRowData(transaccionContable);
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

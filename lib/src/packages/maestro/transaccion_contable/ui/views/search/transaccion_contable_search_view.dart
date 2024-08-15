import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/data/models/request/transaccion_contable_request_model.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/domain/entities/request/transaccion_contable_request.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/domain/entities/transaccion_contable.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/ui/blocs/transaccion_contable/transaccion_contable_bloc.dart';
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
        if (state.status == TransaccionContableStatus.succes) {
          context.read<TransaccionContableBloc>().add(const GetTransaccionContableEvent());
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
    final TransaccionContableBloc transaccionContableBloc = context.read<TransaccionContableBloc>();
    final TransaccionContableRequest request = transaccionContableBloc.request;

    void onPressed() {
      if (request.hasNonNullField()) {
        transaccionContableBloc.add(const GetTransaccionContableEvent());
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
                entries: transaccionContableBloc.state.entriesTipoImpuesto,
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
            final List<TransaccionContableRequest> requestList = <TransaccionContableRequest>[];
            for (final Map<String, dynamic> map in listUpdate) {
              final TransaccionContableRequestModel request = TransaccionContableRequestModel.fromMapTable(map);
              requestList.add(request);
            }
            context.read<TransaccionContableBloc>().add(UpdateTransaccionContableEvent(requestList));
          }

          Map<String, DataItemGrid> buildPlutoRowData(TransaccionContable transaccionContable) {
            return <String, DataItemGrid>{
              'codigo': DataItemGrid(type: Tipo.item, value: transaccionContable.codigo, edit: false),
              'nombre': DataItemGrid(type: Tipo.text, value: transaccionContable.nombre, edit: true),
              'sigla': DataItemGrid(type: Tipo.text, value: transaccionContable.sigla, edit: true),
              'activo': DataItemGrid(type: Tipo.boolean, value: transaccionContable.isActivo, edit: true),
              'fecha_creacion': DataItemGrid(type: Tipo.date, value: transaccionContable.fechaCreacion, edit: false),
              'usuario': DataItemGrid(type: Tipo.text, value: transaccionContable.usuario, edit: false),
              'tipo_impuesto': DataItemGrid(
                type: Tipo.select,
                value: transaccionContable.tipoimpuesto,
                edit: false,
                entryMenus: state.entriesTipoImpuesto,
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

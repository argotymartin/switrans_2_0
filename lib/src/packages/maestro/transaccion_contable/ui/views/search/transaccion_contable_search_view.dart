import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/data/models/request/transaccion_contable_request_model.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/domain/entities/request/transaccion_contable_request.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/domain/entities/transaccion_contable.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/ui/blocs/transaccion_contable/transaccion_contable_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/ui/views/field_transaccion_contable_impuesto.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/toasts/custom_toasts.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class TransaccionContableSearchView extends StatelessWidget {
  const TransaccionContableSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransaccionContableBloc, TransaccionContableState>(
      listener: (BuildContext context, TransaccionContableState state) {
        if (state is TransaccionContableFailedState) {
          CustomToast.showError(context, state.exception!);
        }
      },
      child: ListView(
        padding: const EdgeInsets.only(right: 32, top: 8),
        physics: const ClampingScrollPhysics(),
        children: const <Widget>[
          BuildViewDetail(),
          CardExpansionPanel(title: "Buscar Registros", icon: Icons.search, child: _BuildFieldsForm()),
          _BluildDataTable(),
        ],
      ),
    );
  }
}

class _BuildFieldsForm extends StatelessWidget {
  const _BuildFieldsForm();

  @override
  Widget build(BuildContext context) {
    final TextEditingController nombreController = TextEditingController();
    final TextEditingController codigoController = TextEditingController();
    final TextEditingController impuestoController = TextEditingController();
    bool? isActivo = true;

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final TransaccionContableBloc transaccionContableBloc = context.read<TransaccionContableBloc>();

    void onPressed() {
      bool isValid = formKey.currentState!.validate();
      final bool isCampoVacio =
          nombreController.text.isEmpty && codigoController.text.isEmpty && impuestoController.text.isEmpty && isActivo == null;

      if (isCampoVacio) {
        isValid = false;
        transaccionContableBloc.add(const ErrorFormTransaccionContableEvent("Por favor diligenciar por lo menos un campo del formulario"));
      }
      if (isValid) {
        final TransaccionContableRequest request = TransaccionContableRequest(
          nombre: nombreController.text,
          codigo: int.tryParse(codigoController.text),
          tipoImpuesto: impuestoController.text,
          isActivo: isActivo,
        );
        transaccionContableBloc.add(GetTransaccionContableEvent(request));
      }
    }

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BuildFormFields(
            children: <Widget>[
              NumberInputTitle(title: "Codigo", controller: codigoController),
              TextInputTitle(
                title: "Nombre",
                controller: nombreController,
                typeInput: TypeInput.lettersAndNumbers,
              ),
              FieldTransaccionContableImpuesto(impuestoController),
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
      for (final Map<String, dynamic> map in listUpdate) {
        final TransaccionContableRequestModel request = TransaccionContableRequestModel.fromTable(map);
        context.read<TransaccionContableBloc>().add(UpdateTransaccionContableEvent(request));
      }
    }

    Map<String, DataItemGrid> buildPlutoRowData(TransaccionContable transaccionContable) {
      return <String, DataItemGrid>{
        'codigo': DataItemGrid(type: Tipo.item, value: transaccionContable.codigo, edit: false),
        'nombre': DataItemGrid(type: Tipo.text, value: transaccionContable.nombre, edit: true),
        'activo': DataItemGrid(type: Tipo.boolean, value: transaccionContable.isActivo, edit: true),
        'fecha_creacion': DataItemGrid(type: Tipo.date, value: transaccionContable.fechaCreacion, edit: false),
        'usuario': DataItemGrid(type: Tipo.text, value: transaccionContable.usuario, edit: false),
        'tipo_impuesto': DataItemGrid(type: Tipo.text, value: transaccionContable.tipoimpuesto, edit: true),
        'secuencia': DataItemGrid(type: Tipo.text, value: transaccionContable.secuencia, edit: true),
      };
    }

    return BlocBuilder<TransaccionContableBloc, TransaccionContableState>(
      builder: (BuildContext context, TransaccionContableState state) {
        if (state is TransaccionContableConsultedState) {
          final List<Map<String, DataItemGrid>> plutoRes = <Map<String, DataItemGrid>>[];
          for (final TransaccionContable transaccionContable in state.transaccionesContables) {
            final Map<String, DataItemGrid> rowData = buildPlutoRowData(transaccionContable);
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

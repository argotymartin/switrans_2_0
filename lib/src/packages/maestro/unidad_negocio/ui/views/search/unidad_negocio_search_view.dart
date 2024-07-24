import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/data/models/request/unidad_negocio_request_model.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/domain/entities/request/unidad_negocio_request.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/domain/entities/unidad_negocio.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/ui/blocs/unidad_negocio/unidad_negocio_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/ui/views/field_unidad_negocio_empresa.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/toasts/custom_toasts.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class UnidadNegocioSearchView extends StatelessWidget {
  const UnidadNegocioSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UnidadNegocioBloc, UnidadNegocioState>(
      listener: (BuildContext context, UnidadNegocioState state) {
        if (state is UnidadNegocioFailedState) {
          CustomToast.showError(context, state.exception!);
        }
      },
      child: ListView(
        padding: const EdgeInsets.only(right: 32, top: 8),
        physics: const ClampingScrollPhysics(),
        children: const <Widget>[
          BuildViewDetail(),
          WhiteCard(title: "Buscar Registros", icon: Icons.search, child: _BuildFieldsForm()),
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
    final TextEditingController empresaController = TextEditingController();
    bool? isActivo = true;

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final UnidadNegocioBloc unidadNegocioBloc = context.read<UnidadNegocioBloc>();

    void onPressed() {
      bool isValid = formKey.currentState!.validate();
      final bool isCampoVacio =
          nombreController.text.isEmpty && codigoController.text.isEmpty && empresaController.text.isEmpty && isActivo == null;

      if (isCampoVacio) {
        isValid = false;
        unidadNegocioBloc.add(const ErrorFormUnidadNegocioEvent("Por favor diligenciar por lo menos un campo del formulario"));
      }
      if (isValid) {
        final UnidadNegocioRequest request = UnidadNegocioRequest(
          nombre: nombreController.text,
          codigo: int.tryParse(codigoController.text),
          empresa: empresaController.text,
          isActivo: isActivo,
        );
        unidadNegocioBloc.add(GetUnidadNegocioEvent(request));
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
              TextInputTitle(title: "Nombre", controller: nombreController, typeInput: TypeInput.lettersAndNumbers),
              FieldUnidadNegocioEmpresa(empresaController),
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
        final UnidadNegocioRequestModel request = UnidadNegocioRequestModel.fromMapTable(map);
        context.read<UnidadNegocioBloc>().add(UpdateUnidadNegocioEvent(request));
      }
    }

    Map<String, DataItemGrid> buildPlutoRowData(UnidadNegocio unidadNegocio) {
      return <String, DataItemGrid>{
        'codigo': DataItemGrid(type: Tipo.item, value: unidadNegocio.codigo, edit: false),
        'nombre': DataItemGrid(type: Tipo.text, value: unidadNegocio.nombre, edit: true),
        'activo': DataItemGrid(type: Tipo.boolean, value: unidadNegocio.isActivo, edit: true),
        'fecha_creacion': DataItemGrid(type: Tipo.date, value: unidadNegocio.fechaCreacion, edit: false),
        'usuario': DataItemGrid(type: Tipo.text, value: unidadNegocio.usuario, edit: false),
        'empresa': DataItemGrid(type: Tipo.text, value: unidadNegocio.empresa, edit: true),
      };
    }

    return BlocBuilder<UnidadNegocioBloc, UnidadNegocioState>(
      builder: (BuildContext context, UnidadNegocioState state) {
        if (state is UnidadNegocioConsultedState) {
          final List<Map<String, DataItemGrid>> plutoRes = <Map<String, DataItemGrid>>[];
          for (final UnidadNegocio unidadNegocio in state.unidadNegocioList) {
            final Map<String, DataItemGrid> rowData = buildPlutoRowData(unidadNegocio);
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

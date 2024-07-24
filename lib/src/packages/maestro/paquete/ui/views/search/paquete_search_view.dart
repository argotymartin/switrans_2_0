import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/data/models/paquete_request_model.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/domain/entities/paquete.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/domain/entities/request/paquete_request.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/ui/blocs/paquete_bloc.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/inputs_with_titles/segmented_input_title.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/toasts/custom_toasts.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class PaqueteSearchView extends StatelessWidget {
  const PaqueteSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaqueteBloc, PaqueteState>(
      listener: (BuildContext context, PaqueteState state) {
        if (state is PaqueteExceptionState) {
          CustomToast.showError(context, state.exception!);
        }
      },
      child: Stack(
        children: <Widget>[
          ListView(
            padding: const EdgeInsets.only(right: 32, top: 8),
            physics: const ClampingScrollPhysics(),
            children: const <Widget>[
              BuildViewDetail(),
              WhiteCard(title: "Buscar Registros", icon: Icons.search, child: _BuildFieldsForm()),
              _BluildDataTable(),
            ],
          ),
        ],
      ),
    );
  }
}

class _BuildFieldsForm extends StatelessWidget {
  const _BuildFieldsForm();
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController nombreController = TextEditingController();
    final TextEditingController codigoController = TextEditingController();
    final PaqueteBloc paqueteBloc = context.read<PaqueteBloc>();
    bool? isVisible;
    bool? isActivo;

    void onPressed() {
      bool isValid = formKey.currentState!.validate();
      final bool isCampoVacio = nombreController.text.isEmpty && codigoController.text.isEmpty && isVisible == null && isActivo == null;

      if (isCampoVacio) {
        isValid = false;
        paqueteBloc.add(const ErrorFormPaqueteEvent("Por favor diligenciar por lo menos un campo del formulario"));
      }

      if (isValid) {
        final PaqueteRequest request = PaqueteRequest(
          paqueteNombre: nombreController.text,
          paqueteCodigo: int.tryParse(codigoController.text),
          paqueteVisible: isVisible,
          paqueteActivo: isActivo,
        );
        context.read<PaqueteBloc>().add(GetPaqueteEvent(request));
      }
    }

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BuildFormFields(
            children: <Widget>[
              TextInputTitle(title: "Nombre", controller: nombreController, typeInput: TypeInput.lettersAndNumbers),
              NumberInputTitle(title: "Codigo", controller: codigoController),
              SegmentedInputTitle(title: "Visible", onChanged: (bool? newValue) => isVisible = newValue),
              SegmentedInputTitle(title: "Activo", onChanged: (bool? newValue) => isActivo = newValue),
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
        final PaqueteRequest request = PaqueteRequestModel.fromMap(map);
        context.read<PaqueteBloc>().add(UpdatePaqueteEvent(request));
      }
    }

    Map<String, DataItemGrid> buildPlutoRowData(Paquete paquete) {
      return <String, DataItemGrid>{
        'codigo': DataItemGrid(type: Tipo.item, value: paquete.paqueteCodigo, edit: false),
        'nombre': DataItemGrid(type: Tipo.text, value: paquete.paqueteNombre, edit: true),
        'path': DataItemGrid(type: Tipo.text, value: paquete.paquetePath, edit: false),
        'icono': DataItemGrid(type: Tipo.text, value: paquete.paqueteIcono, edit: true),
        'fecha_creacion': DataItemGrid(type: Tipo.date, value: paquete.fechaCreacion, edit: false),
        'visible': DataItemGrid(type: Tipo.boolean, value: paquete.paqueteVisible, edit: true),
        'activo': DataItemGrid(type: Tipo.boolean, value: paquete.paqueteActivo, edit: true),
      };
    }

    return BlocBuilder<PaqueteBloc, PaqueteState>(
      builder: (BuildContext context, PaqueteState state) {
        if (state is PaqueteConsultedState) {
          final List<Map<String, DataItemGrid>> plutoRes = <Map<String, DataItemGrid>>[];
          for (final Paquete paquete in state.paquetes) {
            final Map<String, DataItemGrid> rowData = buildPlutoRowData(paquete);
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

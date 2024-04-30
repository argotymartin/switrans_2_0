import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/request/modulo_request.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/ui/views/field_paquete.dart';
import 'package:switrans_2_0/src/util/shared/widgets/dialog/error_dialog.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
import 'package:switrans_2_0/src/util/shared/widgets/cards/white_card.dart';
import 'package:switrans_2_0/src/util/shared/widgets/forms/build_rows_form.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/inputs_with_titles/switch_box_input_title.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/ui/blocs/modulo_bloc.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/inputs_with_titles/text_input_title.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';


class ModuloCreateView extends StatelessWidget {
  const ModuloCreateView({super.key});
  @override
  Widget build(BuildContext context) {
    final fullPath =
        GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
    return BlocListener<ModuloBloc, ModuloState>(
      listener: (context, state) {
        if (state is ModuloExceptionState) ErrorDialog.showDioException(context, state.exception!);

        if (state is ModuloSuccessState) {
          context.go('/maestros/modulo/buscar');
        }
      },
      child: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.only(right: 32, top: 8),
            physics: const ClampingScrollPhysics(),
            children: [
              BuildViewDetail(path: fullPath),
              const WhiteCard(
                  title: "Registrar Nuevo",
                  icon: Icons.storage_outlined,
                  child: _BuildFieldsForm()),
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
    final TextEditingController nombreController = TextEditingController();
    final TextEditingController iconoController = TextEditingController();
    final TextEditingController detalleController = TextEditingController();
    final TextEditingController paqueteController = TextEditingController();
    bool isVisible = true;
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Your other form fields...
          BuildRowsForm(
            children: [
              TextInputTitle(title: "Nombre", controller: nombreController),
              TextInputTitle(title: "Icono", controller: iconoController),
              TextInputTitle(title: "Detalle Modulo", controller: detalleController,),
            ],
          ),
          BuildRowsForm(
            children: [
              FieldPaquete(paqueteController),
              SwitchBoxInputTitle(value: isVisible, title: "Visible"),
            ],
          ),
          FilledButton.icon(
            onPressed: () async {
              final isValid = formKey.currentState!.validate();
              if (isValid) {
                final request = ModuloRequest(
                  moduloDetalles: detalleController.text,
                  moduloIcono: iconoController.text,
                  moduloNombre: nombreController.text,
                  paquete: paqueteController.text,
                  moduloPath: "/${nombreController.text.toLowerCase()}",
                  moduloVisible: isVisible,
                );
                context.read<ModuloBloc>().add(SetModuloEvent(request));
              }
            },
            icon: const Icon(Icons.save),
            label: const Text("Crear", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
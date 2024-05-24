import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/domain/entities/request/paquete_request.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/ui/blocs/paquete_bloc.dart';
import 'package:switrans_2_0/src/util/resources/custom_functions.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class PaqueteCreateView extends StatelessWidget {
  const PaqueteCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    final String fullPath = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;

    return BlocListener<PaqueteBloc, PaqueteState>(
      listener: (BuildContext context, PaqueteState state) {
        if (state is PaqueteExceptionState) {
          ErrorDialog.showDioException(context, state.exception!);
        }

        if (state is PaqueteSuccessState) {
          final PaqueteRequest request = PaqueteRequest(paqueteNombre: state.paquete!.paqueteNombre);
          context.read<PaqueteBloc>().add(GetPaqueteEvent(request));
          context.go('/maestros/paquete/buscar');
        }
      },
      child: ListView(
        padding: const EdgeInsets.only(right: 32, top: 8),
        physics: const ClampingScrollPhysics(),
        children: <Widget>[
          BuildViewDetail(path: fullPath),
          const WhiteCard(
            title: "Registrar Nuevo",
            icon: Icons.storage_outlined,
            child: _BuildFieldsForm(),
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
    const bool isVisible = true;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BuildFormFields(
            children: <Widget>[
              TextInputTitle(title: "Nombre", controller: nombreController, typeInput: TypeInput.lettersAndNumbers, minLength: 5),
              TextInputTitle(title: "Icono", controller: iconoController, typeInput: TypeInput.lettersAndNumbers),
            ],
          ),
          FilledButton.icon(
            onPressed: () async {
              final bool isValid = formKey.currentState!.validate();
              if (isValid) {
                final PaqueteRequest request = PaqueteRequest(
                  paqueteIcono: iconoController.text,
                  paqueteNombre: nombreController.text,
                  paquetePath: CustomFunctions.formatPath(nombreController.text.toLowerCase()),
                  paqueteVisible: isVisible,
                );
                context.read<PaqueteBloc>().add(SetPaqueteEvent(request));
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

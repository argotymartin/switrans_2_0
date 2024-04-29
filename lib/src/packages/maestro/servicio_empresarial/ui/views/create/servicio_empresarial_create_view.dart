import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/packages/maestro/servicio_empresarial/domain/entities/request/servicio_empresarial_request.dart';
import 'package:switrans_2_0/src/packages/maestro/servicio_empresarial/ui/blocs/servicio_empresarial/servicio_empresarial_bloc.dart';
import 'package:switrans_2_0/src/util/shared/views/views_shared.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class ServicioEmpresarialCreateView extends StatelessWidget {
  const ServicioEmpresarialCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    final fullPath = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;

    return BlocListener<ServicioEmpresarialBloc, ServicioEmpresarialState>(
      listener: (context, state) {
        if (state is ServicioEmpresarialExceptionState) ErrorDialog.showDioException(context, state.exception);

        if (state is ServicioEmpresarialSuccesState) {
          final request = ServicioEmpresarialRequest(nombre: state.servicioEmpresarial!.nombre);
          context.read<ServicioEmpresarialBloc>().add(GetServicioEmpresarialEvent(request));
          context.go('/maestros/servicio_empresarial/buscar');
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
                icon: Icons.add_circle_outline_outlined,
                child: _BuildFieldsForm(),
              ),
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
    final TextEditingController nameController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BuildRowsForm(
            children: [
              TextInputTitle(title: "Nombre", controller: nameController),
            ],
          ),
          FilledButton.icon(
            onPressed: () {
              final isValid = formKey.currentState!.validate();
              if (isValid) {
                final request = ServicioEmpresarialRequest(
                  nombre: nameController.text.toUpperCase(),
                  usuario: 1,
                );
                context.read<ServicioEmpresarialBloc>().add(SetServicioEmpresarialEvent(request));
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

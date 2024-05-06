import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/globals/login/ui/blocs/auth/auth_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/domain/entities/request/unidad_negocio_request.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/ui/blocs/unidad_negocio/unidad_negocio_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/ui/views/field_unidad_negocio_empresa.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class UnidadNegocioCreateView extends StatelessWidget {
  const UnidadNegocioCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    final fullPath = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;

    return BlocListener<UnidadNegocioBloc, UnidadNegocioState>(
      listener: (context, state) {
        if (state is UnidadNegocioFailedState) {
          ErrorDialog.showDioException(context, state.exception!);
        }

        if (state is UnidadNegocioSuccessState) {
          final request = UnidadNegocioRequest(nombre: state.unidadNegocio!.nombre);
          context.read<UnidadNegocioBloc>().add(GetUnidadNegocioEvent(request));
          context.go('/maestros/unidad_negocio/buscar');
        }
      },
      child: ListView(
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
    );
  }
}

class _BuildFieldsForm extends StatelessWidget {
  const _BuildFieldsForm();

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController empresaController = TextEditingController();
    const isActivo = true;
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BuildRowsForm(
            children: [
              TextInputTitle(title: "Nombre", controller: nameController),
              FieldUnidadNegocioEmpresa(empresaController),
              const SwitchBoxInputTitle(title: "Activo", value: isActivo),
            ],
          ),
          FilledButton.icon(
            onPressed: () {
              final isValid = formKey.currentState!.validate();
              if (isValid) {
                final request = UnidadNegocioRequest(
                  nombre: nameController.text.toUpperCase(),
                  usuario: context.read<AuthBloc>().state.auth?.usuario.codigo,
                  empresa: empresaController.text,
                  isActivo: isActivo,
                );
                context.read<UnidadNegocioBloc>().add(SetUnidadNegocioEvent(request));
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

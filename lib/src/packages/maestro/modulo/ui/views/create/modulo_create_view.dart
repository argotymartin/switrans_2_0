import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/config/share_preferences/preferences.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/request/modulo_request.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/ui/blocs/modulo_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/ui/views/field_paquete.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class ModuloCreateView extends StatelessWidget {
  const ModuloCreateView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ModuloBloc, ModuloState>(
      listener: (BuildContext context, ModuloState state) {
        if (state.status == ModuloStatus.exception) {
          CustomToast.showError(context, state.exception!);
        }

        if (state.status == ModuloStatus.succes) {
          context.read<ModuloBloc>().request = ModuloRequest(codigo: state.modulo!.codigo);
          context.read<ModuloBloc>().add(const GetModuloEvent());
          context.go('/maestros/modulo/buscar');
          Preferences.isResetForm = false;
        }
      },
      builder: (BuildContext context, ModuloState state) {
        return Stack(
          children: <Widget>[
            ListView(
              padding: const EdgeInsets.only(right: 32, top: 8),
              physics: const ClampingScrollPhysics(),
              children: const <Widget>[
                BuildViewDetail(),
                CardExpansionPanel(
                  title: "Registrar Nuevo",
                  icon: Icons.storage_outlined,
                  child: _BuildFieldsForm(),
                ),
              ],
            ),
            if (state.status == ModuloStatus.loading) const LoadingModal(),
          ],
        );
      },
    );
  }
}

class _BuildFieldsForm extends StatelessWidget {
  const _BuildFieldsForm();

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final ModuloBloc moduloBloc = context.read<ModuloBloc>();
    final ModuloRequest request = moduloBloc.request;

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BuildFormFields(
            children: <Widget>[
              TextInputTitle(
                title: "Nombre",
                typeInput: TypeInput.lettersAndNumbers,
                minLength: 3,
                initialValue: request.nombre != null ? request.nombre! : "",
                onChanged: (String result) => request.nombre = result.isNotEmpty ? result : null,
              ),
              TextInputTitle(
                title: "Icono",
                typeInput: TypeInput.lettersAndNumbers,
                minLength: 5,
                initialValue: request.icono != null ? request.icono! : "",
                onChanged: (String result) => request.icono = result.isNotEmpty ? result : null,
              ),
              FieldPaquete(request.paquete),
              TextInputTitle(
                title: "Detalle Modulo",
                typeInput: TypeInput.lettersAndNumbers,
                minLength: 20,
                initialValue: request.detalle != null ? request.detalle! : "",
                onChanged: (String result) => request.detalle = result.isNotEmpty ? result : null,
              ),
            ],
          ),
          FormButton(
            onPressed: () async {
              final bool isValid = formKey.currentState!.validate();
              if (isValid) {
                request.path = "/${moduloBloc.request.nombre!.toUpperCase().replaceAll(' ', '-')}";
                context.read<ModuloBloc>().add(SetModuloEvent(moduloBloc.request));
              }
            },
            icon: Icons.save,
            label: "Crear",
          ),
        ],
      ),
    );
  }
}

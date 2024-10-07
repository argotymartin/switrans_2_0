import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/packages/maestro/servicio_empresarial/domain/entities/request/servicio_empresarial_request.dart';
import 'package:switrans_2_0/src/packages/maestro/servicio_empresarial/ui/blocs/servicio_empresarial/servicio_empresarial_bloc.dart';
import 'package:switrans_2_0/src/util/shared/views/views_shared.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class ServicioEmpresarialCreateView extends StatelessWidget {
  const ServicioEmpresarialCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServicioEmpresarialBloc, ServicioEmpresarialState>(
      listener: (BuildContext context, ServicioEmpresarialState state) {
        if (state.status == ServicioEmpresarialStatus.exception) {
          CustomToast.showError(context, state.exception!);
        }

        if (state.status == ServicioEmpresarialStatus.succes) {
          final ServicioEmpresarialRequest request = ServicioEmpresarialRequest(nombre: state.servicioEmpresarial!.nombre);
          context.read<ServicioEmpresarialBloc>().add(GetServicioEmpresarialEvent(request));
          context.go('/maestros/servicio_empresarial/buscar');
        }
      },
      builder: (BuildContext context, ServicioEmpresarialState state) {
        return Stack(
          children: <Widget>[
            ListView(
              padding: const EdgeInsets.only(right: 32, top: 8),
              physics: const ClampingScrollPhysics(),
              children: const <Widget>[
                BuildViewDetail(),
                CardExpansionPanel(
                  title: "Registrar Nuevo",
                  icon: Icons.add_circle_outline_outlined,
                  child: _BuildFieldsForm(),
                ),
              ],
            ),
            if (state.status == ServicioEmpresarialStatus.loading) const LoadingModal(),
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
    final ServicioEmpresarialBloc servicioEmpresarialBloc = context.watch<ServicioEmpresarialBloc>();
    final ServicioEmpresarialRequest request = servicioEmpresarialBloc.request;

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BuildFormFields(
            children: <Widget>[
              TextInputForm(
                title: "Nombre",
                value: request.nombre,
                typeInput: TypeInput.lettersAndNumbers,
                minLength: 3,
                onChanged: (String result) => request.nombre = result.isNotEmpty ? result : null,
              ),
            ],
          ),
          FormButton(
            onPressed: () {
              final bool isValid = formKey.currentState!.validate();
              if (isValid) {
                context.read<ServicioEmpresarialBloc>().add(SetServicioEmpresarialEvent(request));
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

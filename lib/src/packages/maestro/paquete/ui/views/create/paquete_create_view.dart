import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/config/share_preferences/preferences.dart';
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
    return BlocConsumer<PaqueteBloc, PaqueteState>(
      listener: (BuildContext context, PaqueteState state) {
        if (state.status == PaqueteStatus.exception) {
          CustomToast.showError(context, state.exception!);
        }

        if (state.status == PaqueteStatus.succes) {
          context.read<PaqueteBloc>().request = PaqueteRequest(codigo: state.paquete!.codigo);
          context.read<PaqueteBloc>().add(const GetPaqueteEvent());
          context.go('/maestros/paquete/buscar');
          Preferences.isResetForm = false;
        }
      },
      builder: (BuildContext context, PaqueteState state) {
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
            if (state.status == PaqueteStatus.loading) const LoadingModal(),
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
    final PaqueteBloc paqueteBloc = context.read<PaqueteBloc>();
    final PaqueteRequest request = paqueteBloc.request;
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
                minLength: 5,
                onChanged: (String result) => request.nombre = result.isNotEmpty ? result.toUpperCase() : null,
              ),
              TextInputForm(
                title: "Icono",
                value: request.icono,
                typeInput: TypeInput.lettersAndNumbers,
                minLength: 5,
                onChanged: (String result) => request.icono = result.isNotEmpty ? result.toUpperCase() : null,
              ),
            ],
          ),
          FormButton(
            onPressed: () async {
              final bool isValid = formKey.currentState!.validate();
              if (isValid) {
                request.path = CustomFunctions.formatPath(request.nombre!);

                context.read<PaqueteBloc>().add(SetPaqueteEvent(request));
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

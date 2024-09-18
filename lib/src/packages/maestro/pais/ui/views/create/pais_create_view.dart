import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/config/share_preferences/preferences.dart';
import 'package:switrans_2_0/src/globals/login/ui/blocs/auth/auth_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/pais/domain/entities/request/pais_request.dart';
import 'package:switrans_2_0/src/packages/maestro/pais/ui/blocs/pais_bloc.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class PaisCreateView extends StatelessWidget {
  const PaisCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaisBloc, PaisState>(
      listener: (BuildContext context, PaisState state) {
        if (state.status == PaisStatus.exception) {
          CustomToast.showError(context, state.exception!);
        }

        if (state.status == PaisStatus.succes) {
          context.read<PaisBloc>().request = PaisRequest(codigo: state.pais!.codigo);
          context.read<PaisBloc>().add(const GetPaisEvent());
          context.go('/maestros/pais/buscar');
          Preferences.isResetForm = false;
        }
      },
      builder: (BuildContext context, PaisState state) {
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
            if (state.status == PaisStatus.loading) const LoadingModal(),
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
    final PaisBloc paisBloc = context.read<PaisBloc>();
    final PaisRequest request = paisBloc.request;
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
            ],
          ),
          FormButton(
            onPressed: () async {
              final bool isValid = formKey.currentState!.validate();
              if (isValid) {
                paisBloc.request.codigoUsuario = context.read<AuthBloc>().state.auth?.usuario.codigo;
                context.read<PaisBloc>().add(SetPaisEvent(paisBloc.request));
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/config/share_preferences/preferences.dart';
import 'package:switrans_2_0/src/globals/login/ui/blocs/auth/auth_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/departamento/domain/domain.dart';
import 'package:switrans_2_0/src/packages/maestro/departamento/ui/blocs/departamento_bloc.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class DepartamentoCreateView extends StatelessWidget {
  const DepartamentoCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DepartamentoBloc, DepartamentoState>(
      listener: (BuildContext context, DepartamentoState state) {
        if (state.status == DepartamentoStatus.exception) {
          CustomToast.showError(context, state.exception!);
        }
        if (state.status == DepartamentoStatus.succes) {
          context.read<DepartamentoBloc>().request = DepartamentoRequest(codigo: state.departamento!.codigo);
          context.read<DepartamentoBloc>().add(const GetDepartamentoEvent());
          context.go('/maestros/departamento/buscar');
          Preferences.isResetForm = false;
        }
      },
      builder: (BuildContext context, DepartamentoState state) {
        return Stack(
          children: <Widget>[
            ListView(
              padding: const EdgeInsets.only(right: 32, top: 8),
              physics: const ClampingScrollPhysics(),
              children: <Widget>[
                const BuildViewDetail(),
                CardExpansionPanel(
                  title: "Registrar Nuevo",
                  icon: Icons.storage_outlined,
                  child: _BuildFieldsForm(state),
                ),
              ],
            ),
            if (state.status == DepartamentoStatus.loading) const LoadingModal(),
          ],
        );
      },
    );
  }
}

class _BuildFieldsForm extends StatelessWidget {
  final DepartamentoState state;
  const _BuildFieldsForm(this.state);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final DepartamentoBloc departamentoBloc = context.read<DepartamentoBloc>();
    final DepartamentoRequest request = departamentoBloc.request;
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
              AutocompleteInputForm(
                entries: state.entriesPaises,
                title: "Paises",
                value: request.pais,
                isRequired: true,
                onChanged: (EntryAutocomplete result) => request.pais = result.codigo,
              ),
            ],
          ),
          FormButton(
            onPressed: () async {
              final bool isValid = formKey.currentState!.validate();
              if (isValid) {
                departamentoBloc.request.codigoUsuario = context.read<AuthBloc>().state.auth?.usuario.codigo;
                request.estado = true;
                context.read<DepartamentoBloc>().add(SetDepartamentoEvent(request));
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/config/share_preferences/preferences.dart';
import 'package:switrans_2_0/src/globals/login/ui/blocs/auth/auth_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/domain/entities/request/unidad_negocio_request.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/ui/blocs/unidad_negocio/unidad_negocio_bloc.dart';
import 'package:switrans_2_0/src/util/shared/models/entry_autocomplete.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class UnidadNegocioCreateView extends StatelessWidget {
  const UnidadNegocioCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UnidadNegocioBloc, UnidadNegocioState>(
      listener: (BuildContext context, UnidadNegocioState state) {
        if (state.status == UnidadNegocioStatus.exception) {
          CustomToast.showError(context, state.exception!);
        }
        if (state.status == UnidadNegocioStatus.succes) {
          context.read<UnidadNegocioBloc>().request = UnidadNegocioRequest(codigo: state.unidadNegocio!.codigo);
          context.read<UnidadNegocioBloc>().add(const GetUnidadNegocioEvent());
          context.go('/maestros/unidad_negocio/buscar');
          Preferences.isResetForm = false;
        }
      },
      builder: (BuildContext context, UnidadNegocioState state) {
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
            if (state.status == UnidadNegocioStatus.loading) const LoadingModal(),
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
    final UnidadNegocioBloc unidadNegocioBloc = context.read<UnidadNegocioBloc>();
    final UnidadNegocioRequest request = unidadNegocioBloc.request;

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
              AutocompleteInputForm(
                entries: unidadNegocioBloc.state.entriesEmpresa,
                title: "Empresa",
                value: request.empresa,
                onChanged: (EntryAutocomplete result) => request.empresa = result.codigo,
              ),
            ],
          ),
          FormButton(
            onPressed: () async {
              final bool isValid = formKey.currentState!.validate();
              if (isValid) {
                unidadNegocioBloc.request.usuario = context.read<AuthBloc>().state.auth?.usuario.codigo;
                context.read<UnidadNegocioBloc>().add(SetUnidadNegocioEvent(unidadNegocioBloc.request));
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

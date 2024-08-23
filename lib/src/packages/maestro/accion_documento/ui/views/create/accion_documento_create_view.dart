import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/config/share_preferences/preferences.dart';
import 'package:switrans_2_0/src/globals/login/ui/login_ui.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/entities/request/accion_documento_request.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/ui/blocs/accion_documentos/accion_documento_bloc.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class AccionDocumentoCreateView extends StatelessWidget {
  const AccionDocumentoCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccionDocumentoBloc, AccionDocumentoState>(
      listener: (BuildContext context, AccionDocumentoState state) {
        if (state.status == AccionDocumentoStatus.exception) {
          CustomToast.showError(context, state.exception!);
        }
        if (state.status == AccionDocumentoStatus.succes) {
          context.read<AccionDocumentoBloc>().request = AccionDocumentoRequest(codigo: state.accionDocumento!.codigo);
          context.read<AccionDocumentoBloc>().add(const GetAccionDocumentoEvent());
          context.go('/maestros/accion_documentos/buscar');
          Preferences.isResetForm = false;
        }
      },
      builder: (BuildContext context, AccionDocumentoState state) {
        return Stack(
          children: <Widget>[
            ListView(
              padding: const EdgeInsets.only(right: 32, top: 8),
              children: <Widget>[
                const BuildViewDetail(),
                CardExpansionPanel(
                  title: "Registrar Nuevo",
                  icon: Icons.price_change_outlined,
                  child: _BuildFieldsForm(state),
                ),
              ],
            ),
            if (state.status == AccionDocumentoStatus.loading) const LoadingModal(),
          ],
        );
      },
    );
  }
}

class _BuildFieldsForm extends StatelessWidget {
  final AccionDocumentoState state;
  const _BuildFieldsForm(this.state);

  @override
  Widget build(BuildContext context) {
    final AccionDocumentoBloc accionDocumentoBloc = context.read<AccionDocumentoBloc>();
    final AccionDocumentoRequest request = accionDocumentoBloc.request;
    bool isNaturalezaInversa = false;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
                autofocus: true,
                minLength: 3,
                typeInput: TypeInput.lettersAndNumbers,
                onChanged: (String result) => request.nombre = result.isNotEmpty ? result.toLowerCase() : null,
              ),
              AutocompleteInputForm(
                entries: state.entriesTiposDocumento,
                title: "Tipo Documento",
                value: request.tipoDocumento,
                isRequired: true,
                onChanged: (EntryAutocomplete result) => request.tipoDocumento = result.codigo,
              ),
              SwitchBoxInputForm(
                title: "Es Naturaleza Inversa",
                onChanged: (bool value) => isNaturalezaInversa = value,
              ),
            ],
          ),
          FormButton(
            onPressed: () {
              final bool isValid = formKey.currentState!.validate();
              if (isValid) {
                final AuthBloc authBloc = context.read<AuthBloc>();
                request.isNaturalezaInversa = isNaturalezaInversa;
                request.usuario = authBloc.state.auth!.usuario.codigo;
                accionDocumentoBloc.add(SetAccionDocumentoEvent(request));
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

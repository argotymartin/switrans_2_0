import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/globals/login/ui/login_ui.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/entities/request/accion_documento_request.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/ui/blocs/accion_documentos/accion_documento_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/ui/views/field_tipo_documento.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
import 'package:switrans_2_0/src/util/shared/views/loading_view.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/toasts/custom_toasts.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class AccionDocumentoCreateView extends StatelessWidget {
  const AccionDocumentoCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccionDocumentoBloc, AccionDocumentoState>(
      listener: (BuildContext context, AccionDocumentoState state) {
        if (state is AccionDocumentoExceptionState) {
          CustomToast.showError(context, state.exception!);
        }
        if (state is AccionDocumentoSuccesState) {
          context.go('/maestros/accion_documentos/buscar/123');
        }
      },
      builder: (BuildContext context, AccionDocumentoState state) {
        if (state is AccionDocumentoLoadingState) {
          return const LoadingView();
        }
        return ListView(
          padding: const EdgeInsets.only(right: 32, top: 8),
          children: const <Widget>[
            BuildViewDetail(),
            CardExpansionPanel(
              title: "Registrar Nuevo",
              icon: Icons.price_change_outlined,
              child: _BuildFieldsForm(),
            ),
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
              TextInputTitle(
                title: "Nombre",
                autofocus: true,
                typeInput: TypeInput.lettersAndNumbers,
                onChanged: (String result) {
                  request.nombre = result.isNotEmpty ? result.toLowerCase() : null;
                },
                initialValue: request.nombre != null ? request.nombre! : "",
                minLength: 3,
              ),
              FieldTipoDocumento(entryCodigoSelected: request.tipoDocumento),
              SwitchBoxInputTitle(title: "Es Naturaleza Inversa", onChanged: (bool value) => isNaturalezaInversa = value),
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

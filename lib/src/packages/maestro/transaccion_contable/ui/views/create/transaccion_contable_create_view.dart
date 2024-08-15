import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/config/share_preferences/preferences.dart';
import 'package:switrans_2_0/src/globals/login/ui/blocs/auth/auth_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/domain/entities/request/transaccion_contable_request.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/ui/blocs/transaccion_contable/transaccion_contable_bloc.dart';
import 'package:switrans_2_0/src/util/shared/models/entry_autocomplete.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class TransaccionContableCreateView extends StatelessWidget {
  const TransaccionContableCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TransaccionContableBloc, TransaccionContableState>(
      listener: (BuildContext context, TransaccionContableState state) {
        if (state.status == TransaccionContableStatus.exception) {
          CustomToast.showError(context, state.exception!);
        }
        if (state.status == TransaccionContableStatus.succes) {
          context.read<TransaccionContableBloc>().request = TransaccionContableRequest(codigo: state.transaccionContable!.codigo);
          context.read<TransaccionContableBloc>().add(const GetTransaccionContableEvent());
          context.go('/maestros/transaccion_contable/buscar');
          Preferences.isResetForm = false;
        }
      },
      builder: (BuildContext context, TransaccionContableState state) {
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
            if (state.status == TransaccionContableStatus.loading) const LoadingModal(),
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
    final TransaccionContableBloc transaccionContableBloc = context.read<TransaccionContableBloc>();
    final TransaccionContableRequest request = transaccionContableBloc.request;

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
              TextInputForm(
                title: "Sigla",
                value: request.sigla,
                typeInput: TypeInput.lettersAndNumbers,
                onChanged: (String result) => request.sigla = result.isNotEmpty ? result : null,
              ),
              NumberInputForm(
                title: "Secuencia",
                value: request.secuencia,
                autofocus: true,
                onChanged: (String result) => request.secuencia = result.isNotEmpty ? int.parse(result) : null,
              ),
              AutocompleteInputForm(
                entries: transaccionContableBloc.state.entriesTipoImpuesto,
                title: "Tipo Impuesto",
                value: request.tipoImpuesto,
                onChanged: (EntryAutocomplete result) => request.tipoImpuesto = result.codigo,
              ),
            ],
          ),
          FormButton(
            onPressed: () async {
              final bool isValid = formKey.currentState!.validate();
              if (isValid) {
                transaccionContableBloc.request.usuario = context.read<AuthBloc>().state.auth?.usuario.codigo;
                context.read<TransaccionContableBloc>().add(SetTransaccionContableEvent(transaccionContableBloc.request));
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

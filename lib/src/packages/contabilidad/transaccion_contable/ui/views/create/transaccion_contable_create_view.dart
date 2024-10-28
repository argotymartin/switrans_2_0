import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/globals/login/ui/blocs/auth/auth_bloc.dart';
import 'package:switrans_2_0/src/packages/contabilidad/transaccion_contable/domain/domain.dart';
import 'package:switrans_2_0/src/packages/contabilidad/transaccion_contable/ui/blocs/transaccion_contable/transaccion_contable_bloc.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';
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
          final TransaccionContableRequest request = TransaccionContableRequest(codigo: state.transaccionContable!.codigo);
          context.read<TransaccionContableBloc>().add(GetTransaccionContablesEvent(request));
          context.go('/contabilidad/transaccion_contable/buscar');
        }
      },
      builder: (BuildContext context, TransaccionContableState state) {
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
            if (state.status == TransaccionContableStatus.loading) const LoadingModal(),
          ],
        );
      },
    );
  }
}

class _BuildFieldsForm extends StatelessWidget {
  final TransaccionContableState state;
  const _BuildFieldsForm(this.state);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TransaccionContableBloc transaccionContableBloc = context.watch<TransaccionContableBloc>();
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
                minLength: 3,
                onChanged: (String result) => request.sigla = result.isNotEmpty ? result : null,
              ),
              AutocompleteInputForm(
                entries: state.entriesTipoImpuestos,
                title: "Tipo Impuesto",
                value: request.codigoTipoImpuesto,
                onChanged: (EntryAutocomplete result) => request.codigoTipoImpuesto = result.codigo,
              ),
            ],
          ),
          FormButton(
            onPressed: () async {
              final bool isValid = formKey.currentState!.validate();
              if (isValid) {
                transaccionContableBloc.request.codigoUsuario = context.read<AuthBloc>().state.auth?.usuario.codigo;
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

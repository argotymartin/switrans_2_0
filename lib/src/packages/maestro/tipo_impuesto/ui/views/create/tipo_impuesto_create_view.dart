import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/config/share_preferences/preferences.dart';
import 'package:switrans_2_0/src/packages/maestro/tipo_impuesto/domain/entities/request/tipo_impuesto_request.dart';
import 'package:switrans_2_0/src/packages/maestro/tipo_impuesto/ui/blocs/tipo_impuesto/tipo_impuesto_bloc.dart';
import 'package:switrans_2_0/src/util/shared/views/views_shared.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class TipoImpuestoCreateView extends StatelessWidget {
  const TipoImpuestoCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TipoImpuestoBloc, TipoImpuestoState>(
      listener: (BuildContext context, TipoImpuestoState state) {
        if (state.status == TipoImpuestoStatus.exception) {
          CustomToast.showError(context, state.exception!);
        }

        if (state.status == TipoImpuestoStatus.succes) {
          context.read<TipoImpuestoBloc>().request = TipoImpuestoRequest(codigo: state.tipoImpuesto!.codigo);
          context.read<TipoImpuestoBloc>().add(const GetImpuestoEvent());
          context.go('/maestros/tipo_impuesto/buscar');
          Preferences.isResetForm = false;
        }
      },
      builder: (BuildContext context, TipoImpuestoState state) {
        return Stack(
          children: <Widget>[
            ListView(
              padding: const EdgeInsets.only(right: 32, top: 8),
              physics: const ClampingScrollPhysics(),
              children: const <Widget>[
                BuildViewDetail(),
                CardExpansionPanel(title: "Registrar Nuevo", icon: Icons.price_change_outlined, child: _BuildFieldsForm()),
              ],
            ),
            if (state.status == TipoImpuestoStatus.loading) const LoadingModal(),
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
    final TipoImpuestoBloc tipoImpuestoBloc = context.read<TipoImpuestoBloc>();
    final TipoImpuestoRequest request = tipoImpuestoBloc.request;

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
              const SizedBox(),
            ],
          ),
          FormButton(
            onPressed: () {
              final bool isValid = formKey.currentState!.validate();
              if (isValid) {
                context.read<TipoImpuestoBloc>().add(SetImpuestoEvent(tipoImpuestoBloc.request));
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

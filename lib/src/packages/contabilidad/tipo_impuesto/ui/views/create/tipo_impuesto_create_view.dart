import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/globals/login/ui/blocs/auth/auth_bloc.dart';
import 'package:switrans_2_0/src/packages/contabilidad/tipo_impuesto/domain/domain.dart';
import 'package:switrans_2_0/src/packages/contabilidad/tipo_impuesto/ui/blocs/tipo_impuesto_bloc.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
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
          final TipoImpuestoRequest request = TipoImpuestoRequest(codigo: state.tipoImpuesto!.codigo);
          context.read<TipoImpuestoBloc>().add(GetTipoImpuestosEvent(request));
          context.go('/contabilidad/tipo_impuesto/buscar');
        }
      },
      builder: (BuildContext context, TipoImpuestoState state) {
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
            if (state.status == TipoImpuestoStatus.loading) const LoadingModal(),
          ],
        );
      },
    );
  }
}

class _BuildFieldsForm extends StatelessWidget {
  final TipoImpuestoState state;
  const _BuildFieldsForm(this.state);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TipoImpuestoBloc tipoImpuestoBloc = context.watch<TipoImpuestoBloc>();
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
                minLength: 5,
                onChanged: (String result) => request.nombre = result.isNotEmpty ? result.toUpperCase() : null,
              ),
            ],
          ),
          FormButton(
            onPressed: () async {
              final bool isValid = formKey.currentState!.validate();
              if (isValid) {
                tipoImpuestoBloc.request.codigoUsuario = context.read<AuthBloc>().state.auth?.usuario.codigo;
                context.read<TipoImpuestoBloc>().add(SetTipoImpuestoEvent(request));
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

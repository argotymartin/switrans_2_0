import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/globals/login/ui/blocs/auth/auth_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/domain/entities/request/transaccion_contable_request.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/ui/blocs/transaccion_contable/transaccion_contable_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/ui/views/field_transaccion_contable_impuesto.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
import 'package:switrans_2_0/src/util/shared/widgets/cards/white_card.dart';
import 'package:switrans_2_0/src/util/shared/widgets/dialog/error_dialog.dart';
import 'package:switrans_2_0/src/util/shared/widgets/forms/build_form_fields.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/inputs_with_titles/number_input_title.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/inputs_with_titles/text_input_title.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';

class TransaccionContableCreateView extends StatelessWidget {
  const TransaccionContableCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransaccionContableBloc, TransaccionContableState>(
      listener: (BuildContext context, TransaccionContableState state) {
        if (state is TransaccionContableFailedState) {
          ErrorDialog.showDioException(context, state.exception!);
        }

        if (state is TransaccionContableSuccessState) {
          final TransaccionContableRequest request = TransaccionContableRequest(nombre: state.transaccionContable!.nombre);
          context.read<TransaccionContableBloc>().add(GetTransaccionContableEvent(request));
          context.go('/maestros/transaccion_contable/buscar');
        }
      },
      child: ListView(
        padding: const EdgeInsets.only(right: 32, top: 8),
        physics: const ClampingScrollPhysics(),
        children: const <Widget>[
          BuildViewDetail(),
          WhiteCard(
            title: "Registrar Nuevo",
            icon: Icons.add_circle_outline_outlined,
            child: _BuildFieldsForm(),
          ),
        ],
      ),
    );
  }
}

class _BuildFieldsForm extends StatelessWidget {
  const _BuildFieldsForm();

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController siglaController = TextEditingController();
    final TextEditingController impuestoController = TextEditingController();
    final TextEditingController secuenciaController = TextEditingController();
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
                controller: nameController,
                typeInput: TypeInput.lettersAndNumbers,
              ),
              TextInputTitle(
                title: "Sigla",
                controller: siglaController,
                typeInput: TypeInput.lettersAndNumbers,
              ),
              NumberInputTitle(title: "Secuencia", controller: secuenciaController),
              FieldTransaccionContableImpuesto(impuestoController),
            ],
          ),
          FilledButton.icon(
            onPressed: () {
              final bool isValid = formKey.currentState!.validate();
              if (isValid) {
                final TransaccionContableRequest request = TransaccionContableRequest(
                  nombre: nameController.text.toUpperCase(),
                  sigla: siglaController.text,
                  usuario: context.read<AuthBloc>().state.auth?.usuario.codigo,
                  tipoImpuesto: impuestoController.text,
                  secuencia: int.parse(secuenciaController.text),
                  isActivo: true,
                );
                context.read<TransaccionContableBloc>().add(SetTransaccionContableEvent(request));
              }
            },
            icon: const Icon(Icons.save),
            label: const Text("Crear", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

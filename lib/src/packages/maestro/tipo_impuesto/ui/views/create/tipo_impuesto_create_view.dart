import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/packages/maestro/tipo_impuesto/domain/entities/request/tipo_impuesto_request.dart';
import 'package:switrans_2_0/src/packages/maestro/tipo_impuesto/ui/blocs/tipo_impuesto/tipo_impuesto_bloc.dart';
import 'package:switrans_2_0/src/util/shared/views/views_shared.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class TipoImpuestoCreateView extends StatelessWidget {
  const TipoImpuestoCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TipoImpuestoBloc, TipoImpuestoState>(
      listener: (BuildContext context, TipoImpuestoState state) {
        if (state is TipoImpuestoExceptionState) {
          ErrorDialog.showDioException(context, state.exception!);
        }

        if (state is TipoImpuestoSuccesState) {
          final TipoImpuestoRequest request = TipoImpuestoRequest(
            nombre: state.tipoImpuesto!.nombre,
          );
          context.read<TipoImpuestoBloc>().add(GetImpuestoEvent(request));
          context.go('/tipo_impuesto/buscar');
        }
      },
      child: Stack(
        children: <Widget>[
          ListView(
            padding: const EdgeInsets.only(right: 32, top: 8),
            physics: const ClampingScrollPhysics(),
            children: const <Widget>[
              BuildViewDetail(),
              WhiteCard(title: "Registrar Nuevo", icon: Icons.price_change_outlined, child: _BuildFieldsForm()),
            ],
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
    final TextEditingController controller = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BuildFormFields(
            children: <Widget>[
              TextInputTitle(title: "Nombre", controller: controller, typeInput: TypeInput.lettersAndNumbers, minLength: 3),
              const SizedBox(),
            ],
          ),
          FilledButton.icon(
            onPressed: () {
              final bool isValid = formKey.currentState!.validate();
              if (isValid) {
                final TipoImpuestoRequest request = TipoImpuestoRequest(nombre: controller.text, usuario: 1);
                context.read<TipoImpuestoBloc>().add(SetImpuestoEvent(request));
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

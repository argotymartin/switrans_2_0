import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/modules/maestro/tipo_impuesto/domain/entities/request/tipo_impuesto_request.dart';
import 'package:switrans_2_0/src/modules/maestro/tipo_impuesto/ui/blocs/tipo_impuesto/tipo_impuesto_bloc.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
import 'package:switrans_2_0/src/util/shared/widgets/forms/build_rows_form.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/custom_text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class TipoImpuestoCreateView extends StatelessWidget {
  const TipoImpuestoCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    final fullPath = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
    List<String> names = fullPath.split("/");
    return BlocListener<TipoImpuestoBloc, TipoImpuestoState>(
      listener: (context, state) {
        if (state is TipoImpuestoErrorState) {
          ErrorDialog.showErrorDioException(context, state.exception!);
        }
        if (state is TipoImpuestoSuccesState) {
          context.go('/tipo_impuesto/buscar');
        }
      },
      child: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.only(right: 32, top: 8),
            physics: const ClampingScrollPhysics(),
            children: [
              BuildViewDetail(
                title: "Tipo Impuesto",
                detail: "Sistema de gestión de Tipo Impuestos (Iva, Retefuente, Reteica)",
                breadcrumbTrails: names,
              ),
              const SizedBox(height: 16),
              const WhiteCard(title: "Registrar", icon: Icons.price_change_outlined, child: _BuildFields()),
              const SizedBox(height: 16),
            ],
          ),
        ],
      ),
    );
  }
}

class _BuildFields extends StatelessWidget {
  const _BuildFields();

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BuildRowsForm(
            children: [
              CustomTextInput(title: "Tipo Impuesto", controller: controller),
              const SizedBox(),
            ],
          ),
          Row(
            children: [
              FilledButton.icon(
                onPressed: () {
                  final isValid = formKey.currentState!.validate();
                  if (isValid) {
                    final request = TipoImpuestoRequest(nombre: controller.text, usuario: 1);
                    context.read<TipoImpuestoBloc>().add(SetImpuestoEvent(request));
                  }

                  //formFacturaBloc.onPressedSearch(isValid);
                },
                icon: const Icon(Icons.save),
                label: const Text("Crear", style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(width: 8),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

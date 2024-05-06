import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/entities/request/accion_documento_request.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/ui/blocs/accion_documentos/accion_documento_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/ui/views/field_tipo_documento.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class AccionDocumentoCreateView extends StatelessWidget {
  const AccionDocumentoCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    final fullPath = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;

    return BlocListener<AccionDocumentoBloc, AccionDocumentoState>(
      listener: (context, state) {
        if (state is AccionDocumentoExceptionState) {
          ErrorDialog.showDioException(context, state.exception!);
        }

        if (state is AccionDocumentoSuccesState) {
          final request = AccionDocumentoRequest(nombre: state.accionDocumento!.nombre);
          context.read<AccionDocumentoBloc>().add(GetAccionDocumentoEvent(request));
          context.go('/maestros/accion_documentos/buscar');
        }
      },
      child: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.only(right: 32, top: 8),
            physics: const ClampingScrollPhysics(),
            children: [
              BuildViewDetail(path: fullPath),
              const WhiteCard(
                title: "Registrar Nuevo",
                icon: Icons.price_change_outlined,
                child: _BuildFieldsForm(),
              ),
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
    final TextEditingController nameController = TextEditingController();
    final TextEditingController typeController = TextEditingController();
    bool esInverso = false;
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BuildRowsForm(
            children: [
              TextInputTitle(title: "Nombre", controller: nameController),
              FieldTipoDocumento(typeController),
              SwitchBoxInputTitle(value: esInverso, title: "Es Naturaleza Inversa")
            ],
          ),
          FilledButton.icon(
            onPressed: () {
              final isValid = formKey.currentState!.validate();
              if (isValid) {
                final request = AccionDocumentoRequest(
                  nombre: nameController.text.toUpperCase(),
                  usuario: 1,
                  isNaturalezaInversa: esInverso,
                  tipoDocumento: typeController.text,
                );
                context.read<AccionDocumentoBloc>().add(SetAccionDocumentoEvent(request));
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

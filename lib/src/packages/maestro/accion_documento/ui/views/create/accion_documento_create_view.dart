import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/entities/request/accion_documento_request.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/entities/tipo_documento_accion_documento.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/ui/blocs/accion_documentos/accion_documento_bloc.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
import 'package:switrans_2_0/src/util/shared/widgets/forms/build_rows_form.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/custom_text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class AccionDocumentoCreateView extends StatelessWidget {
  const AccionDocumentoCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    final fullPath = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;

    return BlocListener<AccionDocumentoBloc, AccionDocumentoState>(
      listener: (context, state) {
        if (state is AccionDocumentoExceptionState) ErrorDialog.showDioException(context, state.exception!);

        if (state is AccionDocumentoSuccesState) {
          final request = AccionDocumentoRequest(
            nombre: state.accionDocumento!.nombre,
          );
          context.read<AccionDocumentoBloc>().add(GetAccionDocumentoEvent(request));
          context.go('/maestro/accion_documentos/buscar');
        }
      },
      child: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.only(right: 32, top: 8),
            physics: const ClampingScrollPhysics(),
            children: [
              BuildViewDetail(path: fullPath),
              const WhiteCard(title: "Registrar Nuevo", icon: Icons.price_change_outlined, child: _BuildFieldsForm()),
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
              CustomTextInput(title: "Nombre", controller: nameController),
              FieldTipoDocumento(typeController),
              SwitchBoxInput(
                title: "Naturaleza inversa",
                onChanged: (value) => esInverso = value,
              )
            ],
          ),
          FilledButton.icon(
            onPressed: () {
              final isValid = formKey.currentState!.validate();
              if (isValid) {
                final request = AccionDocumentoRequest(
                  nombre: nameController.text.toUpperCase(),
                  usuario: 1,
                  isInverso: esInverso,
                  tipo: int.tryParse(typeController.text),
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

class FieldTipoDocumento extends StatelessWidget {
  final TextEditingController typeController;
  const FieldTipoDocumento(this.typeController, {super.key});

  @override
  Widget build(BuildContext context) {
    void onPressed(EntryAutocomplete entry) {
      typeController.text = entry.codigo.toString();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("Tipo Documento", style: AppTheme.titleStyle),
        const SizedBox(height: 8),
        FutureBuilder(
          future: context.read<AccionDocumentoBloc>().onGetTipoDocumento(),
          builder: (
            context,
            AsyncSnapshot<dynamic> snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.done) {
              final List<EntryAutocomplete> entryMenus = [];
              for (TipoDocumentoAccionDocumento e in snapshot.data) {
                entryMenus.add(EntryAutocomplete(title: e.nombre, codigo: e.codigo));
              }
              return AutocompleteInput(
                entries: entryMenus,
                label: "Tipo Documento",
                onPressed: onPressed,
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ],
    );
  }
}

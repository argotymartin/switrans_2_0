import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/domain/entities/request/pagina_request.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/ui/blocs/pagina_bloc.dart';
import 'package:switrans_2_0/src/util/resources/custom_functions.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class PaginaCreateView extends StatelessWidget {
  const PaginaCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    final String fullPath = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;

    return BlocListener<PaginaBloc, PaginaState>(
      listener: (BuildContext context, PaginaState state) {
        if (state is PaginaExceptionState) {
          ErrorDialog.showDioException(context, state.exception!);
        }

        if (state is PaginaSuccessState) {
          final PaginaRequest request = PaginaRequest(paginaNombre: state.pagina!.paginaNombre);
          context.read<PaginaBloc>().add(GetPaginaEvent(request));
          context.go('/maestros/pagina/buscar');
        }
      },
      child: ListView(
        padding: const EdgeInsets.only(right: 32, top: 8),
        physics: const ClampingScrollPhysics(),
        children: <Widget>[
          BuildViewDetail(path: fullPath),
          const WhiteCard(
            title: "Registrar Nuevo",
            icon: Icons.storage_outlined,
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
    final TextEditingController nombreController = TextEditingController();
    const bool isVisible = true;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BuildRowsForm(
            children: <Widget>[
              TextInputTitle(title: "Nombre", controller: nombreController, typeInput: TypeInput.lettersAndNumbers, minLength: 5),
            ],
          ),
          FilledButton.icon(
            onPressed: () async {
              final bool isValid = formKey.currentState!.validate();
              if (isValid) {
                final PaginaRequest request = PaginaRequest(
                  paginaNombre: nombreController.text,
                  paginaPath: CustomFunctions.formatPath(nombreController.text.toLowerCase()),
                  paginaVisible: isVisible,
                );
                context.read<PaginaBloc>().add(SetPaginaEvent(request));
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

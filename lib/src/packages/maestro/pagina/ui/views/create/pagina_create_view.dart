import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/config/share_preferences/preferences.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/domain/entities/request/pagina_request.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/ui/blocs/pagina_bloc.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class PaginaCreateView extends StatelessWidget {
  const PaginaCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaginaBloc, PaginaState>(
      listener: (BuildContext context, PaginaState state) {
        if (state.status == PaginaStatus.exception) {
          CustomToast.showError(context, state.exception!);
        }
        if (state.status == PaginaStatus.succes) {
          context.read<PaginaBloc>().request = PaginaRequest(codigo: state.pagina!.codigo);
          context.read<PaginaBloc>().add(const GetPaginaEvent());
          context.go('/maestros/pagina/buscar');
          Preferences.isResetForm = false;
        }
      },
      builder: (BuildContext context, PaginaState state) {
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
            if (state.status == PaginaStatus.loading) const LoadingModal(),
          ],
        );
      },
    );
  }
}

class _BuildFieldsForm extends StatelessWidget {
  final PaginaState state;
  const _BuildFieldsForm(this.state);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final PaginaBloc paginaBloc = context.read<PaginaBloc>();
    final PaginaRequest request = paginaBloc.request;
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
                onChanged: (String result) => request.nombre = result.isNotEmpty ? result.toUpperCase() : null,
              ),
              AutocompleteInputForm(
                entries: state.entriesModulos,
                title: "Modulos",
                value: request.modulo,
                isRequired: true,
                onChanged: (EntryAutocomplete result) => request.modulo = result.codigo,
              ),
            ],
          ),
          FormButton(
            onPressed: () async {
              final bool isValid = formKey.currentState!.validate();
              if (isValid) {
                request.path = "/${request.nombre!.toLowerCase().replaceAll(' ', '-')}";
                request.isActivo = true;
                context.read<PaginaBloc>().add(SetPaginaEvent(request));
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

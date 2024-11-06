import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/globals/login/ui/blocs/auth/auth_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/municipio/domain/domain.dart';
import 'package:switrans_2_0/src/packages/maestro/municipio/ui/blocs/municipio_bloc.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class MunicipioCreateView extends StatelessWidget {
  const MunicipioCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MunicipioBloc, MunicipioState>(
      listener: (BuildContext context, MunicipioState state) {
        if (state.status == MunicipioStatus.exception) {
          CustomToast.showError(context, state.exception!);
        }
        if (state.status == MunicipioStatus.succes) {
          final MunicipioRequest request = MunicipioRequest(codigo: state.municipio!.codigo);
          context.read<MunicipioBloc>().add(GetMunicipiosEvent(request));
          context.go('/maestros/municipio/buscar');
        }
      },
      builder: (BuildContext context, MunicipioState state) {
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
            if (state.status == MunicipioStatus.loading) const LoadingModal(),
          ],
        );
      },
    );
  }
}

class _BuildFieldsForm extends StatelessWidget {
  final MunicipioState state;
  const _BuildFieldsForm(this.state);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final MunicipioBloc municipioBloc = context.watch<MunicipioBloc>();
    final MunicipioRequest request = municipioBloc.request;
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BuildFormFields(
            children: <Widget>[
              TextInputForm(
                title: "Nombre",
                value: state.nombre ?? '',
                typeInput: TypeInput.lettersAndNumbers,
                minLength: 5,
                onChanged: (String result) {
                  municipioBloc.add(UpdateNombreEvent(result));
                  request.nombre = result;
                },
                autofocus: true,
              ),
              TextInputForm(
                title: "Codigo Dane",
                value: request.codigoDane,
                typeInput: TypeInput.onlyNumbers,
                minLength: 3,
                maxLength: 3,
                icon: Icons.numbers,
                onChanged: (String result) => request.codigoDane = result.isNotEmpty ? result : null,
              ),
              AutocompleteInputForm(
                title: 'Pais',
                entries: state.municipioPaises,
                value: request.codigoPais,
                onChanged: (EntryAutocomplete result) {
                  request.codigoPais = result.codigo;
                  if (result.codigo != null) {
                    final MunicipioPais resultPais = MunicipioPais(
                      codigo: result.codigo!,
                      nombre: result.title,
                    );
                    municipioBloc.add(SelectMunicipioPaisEvent(resultPais));
                  }
                  if (result.codigo == null) {
                    municipioBloc.add(const CleanSelectMunicipioPaisEvent());
                  }
                },
              ),
              AutocompleteInputForm(
                entries: state.municipioDepartamentos,
                title: "Departamentos",
                value: request.codigoDepartamento,
                isRequired: true,
                onChanged: (EntryAutocomplete result) => request.codigoDepartamento = result.codigo,
              ),
            ],
          ),
          FormButton(
            onPressed: () async {
              final bool isValid = formKey.currentState!.validate();
              if (isValid) {
                municipioBloc.request.codigoUsuario = context.read<AuthBloc>().state.auth?.usuario.codigo;
                context.read<MunicipioBloc>().add(SetMunicipioEvent(request));
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

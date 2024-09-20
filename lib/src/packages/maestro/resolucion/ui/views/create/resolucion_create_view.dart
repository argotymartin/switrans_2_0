import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/config/share_preferences/preferences.dart';
import 'package:switrans_2_0/src/globals/login/ui/blocs/auth/auth_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/resolucion/domain/resolucion_domain.dart';
import 'package:switrans_2_0/src/packages/maestro/resolucion/ui/blocs/resolucion_bloc.dart';
import 'package:switrans_2_0/src/util/shared/models/entry_autocomplete.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/inputs_forms/date_picker_input_form.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/inputs_forms/number_range_form.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class ResolucionCreateView extends StatelessWidget {
  const ResolucionCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResolucionBloc, ResolucionState>(
      listener: (BuildContext context, ResolucionState state) {
        if (state.status == ResolucionStatus.exception) {
          CustomToast.showError(context, state.exception!);
        }
        if (state.status == ResolucionStatus.success) {
          context.read<ResolucionBloc>().request = ResolucionRequest(codigo: state.resolucion!.codigo);
          context.read<ResolucionBloc>().add(const GetResolucionesEvent());
          context.go('/maestros/resolucion/buscar');
          Preferences.isResetForm = false;
        }
      },
      builder: (BuildContext context, ResolucionState state) {
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
            //if (state.status == ResolucionStatus.loading) const LoadingModal(),
          ],
        );
      },
    );
  }
}

class _BuildFieldsForm extends StatelessWidget {
  final ResolucionState state;
  const _BuildFieldsForm(this.state);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final ResolucionBloc resolucionBloc = context.read<ResolucionBloc>();
    final ResolucionRequest request = resolucionBloc.request;

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BuildFormFields(
            children: <Widget>[
              TextInputForm(
                title: 'Numero de Resolución',
                value: request.numero,
                typeInput: TypeInput.lettersAndNumbers,
                minLength: 3,
                onChanged: (String result) => request.numero = result.isNotEmpty ? result : null,
              ),
              AutocompleteInputForm(
                title: 'Empresa',
                entries: state.resolucionesEmpresas,
                value: request.codigoEmpresa,
                onChanged: (EntryAutocomplete result) => request.codigoEmpresa = result.codigo,
              ),
              AutocompleteInputForm(
                title: 'Documento',
                entries: state.resolucionesDocumentos,
                value: request.codigoDocumento,
                onChanged: (EntryAutocomplete result) => request.codigoDocumento = result.codigo,
              ),
            ],
          ),
          BuildFormFields(
            children: <Widget>[
              DatePickerInputForm(
                title: "Fecha Resolución",
                value: request.fecha,
                onChanged: (String result) => request.fecha = result,
                isRange: false,
              ),
              NumberRangeForm(
                title: "Rango Inicial - Rango Final",
                min: 1,
                max: 10000,
                onChanged1: (int value) => request.rangoInicial = value,
                onChanged2: (int value) => request.rangoFinal = value,
              ),
              DatePickerInputForm(
                title: "Fecha Vigencia",
                value: request.fechaVigencia,
                onChanged: (String result) => request.fechaVigencia = result,
                isRange: false,
              ),
            ],
          ),
          BuildFormFields(
            children: <Widget>[
              TextInputForm(
                title: "Prefijo Empresa",
                value: request.empresaPrefijo,
                typeInput: TypeInput.lettersAndNumbers,
                minLength: 1,
                onChanged: (String result) => request.empresaPrefijo = result.isNotEmpty ? result : null,
              ),
              TextInputForm(
                title: "Version",
                value: request.version,
                typeInput: TypeInput.lettersAndNumbers,
                minLength: 1,
                onChanged: (String result) => request.version = result.isNotEmpty ? result : null,
              ),
              const SizedBox(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormButton(
              onPressed: () async {
                final bool isValid = formKey.currentState!.validate();
                if (isValid) {
                  resolucionBloc.request.codigoUsuario = context.read<AuthBloc>().state.auth?.usuario.codigo;
                  context.read<ResolucionBloc>().add(SetResolucionEvent(request: resolucionBloc.request));
                }
              },
              icon: Icons.save,
              label: "Crear",
            ),
          ),
        ],
      ),
    );
  }
}

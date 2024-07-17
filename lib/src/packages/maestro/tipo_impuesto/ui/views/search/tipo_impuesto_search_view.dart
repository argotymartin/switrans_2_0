import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/tipo_impuesto/domain/entities/request/tipo_impuesto_request.dart';
import 'package:switrans_2_0/src/packages/maestro/tipo_impuesto/ui/blocs/tipo_impuesto/tipo_impuesto_bloc.dart';
import 'package:switrans_2_0/src/util/shared/views/views_shared.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/toasts/custom_toasts.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class TipoImpuestoSearchView extends StatelessWidget {
  const TipoImpuestoSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TipoImpuestoBloc, TipoImpuestoState>(
      listener: (BuildContext context, TipoImpuestoState state) {
        if (state is TipoImpuestoExceptionState) {
          CustomToast.showError(context, state.exception!);
        }
      },
      child: Stack(
        children: <Widget>[
          ListView(
            padding: const EdgeInsets.only(right: 32, top: 8),
            physics: const ClampingScrollPhysics(),
            children: const <Widget>[
              BuildViewDetail(),
              WhiteCard(title: "Buscar Registros", icon: Icons.search, child: _BuildFieldsForm()),
              _BluildDataTable(),
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
    final TextEditingController nombreController = TextEditingController();
    final TextEditingController codigoController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final TipoImpuestoBloc tipoImpuestoBloc = context.read<TipoImpuestoBloc>();

    void onPressed() {
      bool isValid = formKey.currentState!.validate();
      final bool isCampoVacio = nombreController.text.isEmpty && codigoController.text.isEmpty;

      if (isCampoVacio) {
        isValid = false;
        tipoImpuestoBloc.add(const ErrorFormTipoImpuestoEvent("Por favor diligenciar por lo menos un campo del formulario"));
      }
      if (isValid) {
        final TipoImpuestoRequest request = TipoImpuestoRequest(
          nombre: nombreController.text,
          codigo: int.tryParse(codigoController.text),
          usuario: 1,
        );
        context.read<TipoImpuestoBloc>().add(GetImpuestoEvent(request));
      }
    }

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BuildFormFields(
            children: <Widget>[
              TextInputTitle(title: "Nombre", controller: nombreController, typeInput: TypeInput.lettersAndNumbers),
              NumberInputTitle(title: "Codigo", controller: codigoController),
            ],
          ),
          BlocBuilder<TipoImpuestoBloc, TipoImpuestoState>(
            builder: (BuildContext context, TipoImpuestoState state) {
              int cantdiad = 0;
              bool isConsulted = false;
              bool isInProgress = false;
              String error = "";
              if (state is TipoImpuestoLoadingState) {
                isInProgress = true;
              }

              if (state is TipoImpuestoErrorFormState) {
                error = state.error!;
              }
              if (state is TipoImpuestoConsultedState) {
                isInProgress = false;
                isConsulted = true;
                cantdiad = state.tipoImpuestos.length;
              }

              return BuildButtonForm(
                onPressed: onPressed,
                icon: Icons.search,
                label: "Buscar",
                cantdiad: cantdiad,
                isConsulted: isConsulted,
                isInProgress: isInProgress,
                error: error,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _BluildDataTable extends StatelessWidget {
  const _BluildDataTable();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TipoImpuestoBloc, TipoImpuestoState>(
      builder: (BuildContext context, TipoImpuestoState state) {
        if (state is TipoImpuestoConsultedState) {
          //return CustomPlutoGridTable(
          //  columns: CustomPlutoGridDataBuilder.buildColumns(context),
          //  rows: CustomPlutoGridDataBuilder.buildDataRows(state.tipoImpuestos, context),
          //);
        }
        return const SizedBox();
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/modules/maestro/tipo_impuesto/domain/entities/request/tipo_impuesto_request.dart';
import 'package:switrans_2_0/src/modules/maestro/tipo_impuesto/ui/blocs/tipo_impuesto/tipo_impuesto_bloc.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
import 'package:switrans_2_0/src/util/shared/widgets/forms/build_rows_form.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/custom_number_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/custom_text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/tables/custom_pluto_grid/custom_pluto_grid_data_builder.dart';
import 'package:switrans_2_0/src/util/shared/widgets/tables/custom_pluto_grid/custom_pluto_grid_table.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class TipoImpuestoSearchView extends StatelessWidget {
  const TipoImpuestoSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final fullPath = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;

    return BlocListener<TipoImpuestoBloc, TipoImpuestoState>(
      listener: (context, state) {
        if (state is TipoImpuestoErrorState) ErrorDialog.showDioException(context, state.exception!);
      },
      child: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.only(right: 32, top: 8),
            physics: const ClampingScrollPhysics(),
            children: [
              BuildViewDetail(path: fullPath),
              const WhiteCard(title: "Buscar Registros", icon: Icons.search, child: _BuildFieldsForm()),
              const _BluildDataTable()
            ],
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
      builder: (context, state) {
        if (state is TipoImpuestoConsultedState) {
          return CustomPlutoGridTable(
            columns: CustomPlutoGridDataBuilder.buildColumns(context),
            rows: CustomPlutoGridDataBuilder.buildDataRows(state.tipoImpuestos, context),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class _BuildFieldsForm extends StatelessWidget {
  const _BuildFieldsForm();

  @override
  Widget build(BuildContext context) {
    final TextEditingController nombreController = TextEditingController();
    final TextEditingController codigoController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BuildRowsForm(
            children: [
              CustomTextInput(title: "Nombre", controller: nombreController, minLength: 0),
              CustomNumberInput(title: "Codigo", controller: codigoController),
            ],
          ),
          FilledButton.icon(
            onPressed: () {
              final isValid = formKey.currentState!.validate();
              if (isValid) {
                final request = TipoImpuestoRequest(
                  nombre: nombreController.text,
                  codigo: int.tryParse(codigoController.text),
                  usuario: 1,
                );
                context.read<TipoImpuestoBloc>().add(GetImpuestoEvent(request));
              }
            },
            icon: const Icon(Icons.save),
            label: const Text("Buscar", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

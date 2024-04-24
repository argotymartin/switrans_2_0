import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/entities/request/accion_documento_request.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/ui/blocs/accion_documentos/accion_documento_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/ui/views/create/accion_documento_create_view.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/ui/views/search/accion_documento_pluto_grid_data_builder.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
import 'package:switrans_2_0/src/util/shared/widgets/forms/build_button_form.dart';
import 'package:switrans_2_0/src/util/shared/widgets/forms/build_button_form_save.dart';
import 'package:switrans_2_0/src/util/shared/widgets/forms/build_rows_form.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/custom_number_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/custom_text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/tables/custom_pluto_grid/custom_pluto_grid_table.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class AccionDocumentoSearchView extends StatelessWidget {
  const AccionDocumentoSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final fullPath = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;

    return BlocListener<AccionDocumentoBloc, AccionDocumentoState>(
      listener: (context, state) {
        if (state is AccionDocumentoExceptionState) ErrorDialog.showDioException(context, state.exception!);
      },
      child: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.only(right: 32, top: 8),
            physics: const ClampingScrollPhysics(),
            children: [
              BuildViewDetail(path: fullPath),
              const WhiteCard(title: "Buscar Registros", icon: Icons.search, child: _BuildFieldsForm()),
              const _BluildDataTable(),
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
    final TextEditingController typeController = TextEditingController();

    final formKey = GlobalKey<FormState>();

    final AccionDocumentoBloc accionDocumentoBloc = context.read<AccionDocumentoBloc>();

    void onPressed() {
      bool isValid = formKey.currentState!.validate();
      bool isCampoVacio = nombreController.text.isEmpty && codigoController.text.isEmpty && typeController.text.isEmpty;

      if (isCampoVacio) {
        isValid = false;
        accionDocumentoBloc.add(const ErrorFormAccionDocumentoEvent("Por favor diligenciar por lo menos un campo del formulario"));
      }
      if (isValid) {
        final request = AccionDocumentoRequest(
          nombre: nombreController.text,
          codigo: int.tryParse(codigoController.text),
          tipoDocumento: int.tryParse(typeController.text),
        );
        context.read<AccionDocumentoBloc>().add(GetAccionDocumentoEvent(request));
      }
    }

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BuildRowsForm(
            children: [
              CustomTextInput(title: "Nombre", controller: nombreController, minLength: 0),
              CustomNumberInput(title: "Codigo", controller: codigoController),
              FieldTipoDocumento(typeController),
            ],
          ),
          BlocBuilder<AccionDocumentoBloc, AccionDocumentoState>(
            builder: (context, state) {
              int cantdiad = 0;
              bool isConsulted = false;
              bool isInProgress = false;
              String error = "";
              if (state is AccionDocumentoLoadingState) {
                isInProgress = true;
              }

              if (state is AccionDocumentoErrorFormState) {
                error = state.error!;
              }
              if (state is AccionDocumentoConsultedState) {
                isInProgress = false;
                isConsulted = true;
                cantdiad = state.accionDocumentos.length;
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

class _BluildDataTable extends StatefulWidget {
  const _BluildDataTable();

  @override
  State<_BluildDataTable> createState() => _BluildDataTableState();
}

class _BluildDataTableState extends State<_BluildDataTable> {
  List<AccionDocumentoRequest> listUpdate = [];
  @override
  Widget build(BuildContext context) {
    void onRowChecked(PlutoGridOnRowCheckedEvent event) {
      setState(() {});
      if (event.row == null || event.rowIdx == null || event.isChecked == null) {
        return;
      }
      Map<String, dynamic> mapRow = Map.fromEntries(
        event.row!.cells.entries.map((entry) => MapEntry(entry.key, entry.value.value)),
      );
      final request = AccionDocumentoRequest.fromMap(mapRow);

      if (event.isChecked!) {
        if (!listUpdate.contains(request)) listUpdate.add(request);
      } else {
        listUpdate.removeWhere((element) => element.codigo! == request.codigo!);
      }
      listUpdate.map((e) => e.codigo);
    }

    void onPressedSave() {
      print(listUpdate.map((e) => e.codigo));
    }

    return BlocBuilder<AccionDocumentoBloc, AccionDocumentoState>(
      builder: (context, state) {
        if (state is AccionDocumentoConsultedState) {
          return Column(
            children: [
              CustomPlutoGridTable(
                columns: AccionDocumentoPlutoGridDataBuilder.buildColumns(context),
                rows: AccionDocumentoPlutoGridDataBuilder.buildDataRows(state.accionDocumentos, context),
                onRowChecked: onRowChecked,
              ),
              BuildButtonFormSave(
                onPressed: onPressedSave,
                icon: Icons.save,
                label: "Actualizar",
                cantdiad: listUpdate.length,
                isConsulted: true,
                isInProgress: false,
                error: "",
              )
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/entities/request/accion_documento_request.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/ui/blocs/accion_documentos/accion_documento_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/ui/views/create/accion_documento_create_view.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
import 'package:switrans_2_0/src/util/shared/widgets/forms/build_button_form.dart';
import 'package:switrans_2_0/src/util/shared/widgets/forms/build_button_form_save.dart';
import 'package:switrans_2_0/src/util/shared/widgets/forms/build_rows_form.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/custom_number_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/custom_text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/tables/custom_pluto_grid/pluto_grid_data_builder.dart';
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
              CustomNumberInput(title: "Codigo", controller: codigoController),
              CustomTextInput(title: "Nombre", controller: nombreController, minLength: 0),
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
  List<Map<String, dynamic>> listUpdate = [];
  @override
  Widget build(BuildContext context) {
    void onRowChecked(dynamic event) {
      listUpdate.clear();
      setState(() => listUpdate.addAll(event));
    }

    void onPressedSave() {
      for (Map<String, dynamic> map in listUpdate) {
        final request = AccionDocumentoRequest.fromMap(map);
        context.read<AccionDocumentoBloc>().add(UpdateAccionDocumentoEvent(request));
      }
    }

    return BlocBuilder<AccionDocumentoBloc, AccionDocumentoState>(
      builder: (context, state) {
        if (state is AccionDocumentoConsultedState) {
          final nombres = context.read<AccionDocumentoBloc>().tipos.map((e) => '${e.codigo}-${e.nombre.toUpperCase()}').toList();
          final List<Map<String, dynamic>> plutoRes = [];
          for (var e in state.accionDocumentos) {
            Map<String, dynamic> map = {};
            map.addEntries({
              'codigo': {'type': Tipo.item, 'value': e.codigo, 'edit': false},
              'nombre': {'type': Tipo.text, 'value': e.nombre, 'edit': true},
              'tipo_documento': {'type': Tipo.select, 'value': e.tipo, 'edit': true, 'data': nombres},
              'naturaleza_inversa': {'type': Tipo.boolean, 'value': e.esInverso, 'edit': true},
              'activo': {'type': Tipo.boolean, 'value': e.esActivo, 'edit': true},
              'fecha_creacion': {'type': Tipo.date, 'value': e.fechaCreacion, 'edit': false},
              'fecha_actualizacion': {'type': Tipo.date, 'value': e.fechaActualizacion, 'edit': false},
              'usuario': {'type': Tipo.text, 'value': e.usuario, 'edit': false}
            }.entries);
            plutoRes.add(map);
          }
          return Column(
            children: [
              PlutoGridDataBuilder(plutoData: plutoRes, onRowChecked: onRowChecked),
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

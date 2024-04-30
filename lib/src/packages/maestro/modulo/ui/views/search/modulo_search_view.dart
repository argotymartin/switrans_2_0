import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/modulo.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/inputs_with_titles/text_input_title.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/inputs_with_titles/web_date_picker_title.dart';
import 'package:switrans_2_0/src/util/shared/widgets/tables/custom_pluto_grid/pluto_grid_data_builder.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
import 'package:switrans_2_0/src/util/shared/widgets/cards/white_card.dart';
import 'package:switrans_2_0/src/util/shared/widgets/dialog/error_dialog.dart';
import 'package:switrans_2_0/src/util/shared/widgets/forms/build_button_form.dart';
import 'package:switrans_2_0/src/util/shared/widgets/forms/build_rows_form.dart';
import 'package:switrans_2_0/src/util/shared/widgets/tables/custom_pluto_grid/data_grid_item.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/request/modulo_request.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/ui/blocs/modulo_bloc.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class ModuloSearchView extends StatelessWidget {
  const ModuloSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final fullPath = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;

    return BlocListener<ModuloBloc, ModuloState>(
      listener: (context, state) {
        if (state is ModuloExceptionState) ErrorDialog.showDioException(context, state.exception!);
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
class _BuildFieldsForm extends StatelessWidget {
  const _BuildFieldsForm();
  @override
  Widget build(BuildContext context) {
    final TextEditingController nombreController = TextEditingController();
    final TextEditingController codigoController = TextEditingController();
    final TextEditingController fechaInicioController = TextEditingController();
    final TextEditingController fechaFinController = TextEditingController();

    final formKey = GlobalKey<FormState>();

    final ModuloBloc moduloBloc = context.read<ModuloBloc>();

    void onPressed() {
      bool isValid = formKey.currentState!.validate();
      bool isCampoVacio = nombreController.text.isEmpty && codigoController.text.isEmpty &&
          fechaInicioController.text.isEmpty && fechaFinController.text.isEmpty;

      if (isCampoVacio) {
        isValid = false;
        moduloBloc.add(const ErrorFormModuloEvent("Por favor diligenciar por lo menos un campo del formulario"));
      }

      if (isValid) {
        final request = ModuloRequest(
          moduloNombre: nombreController.text,
          moduloCodigo: int.tryParse(codigoController.text),
          fechaInicial: fechaInicioController.text,
          fechaFinal: fechaFinController.text,
        );
        context.read<ModuloBloc>().add(GetModuloEvent(request));
      }
    }
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BuildRowsForm(
            children: [
              TextInputTitle(title: "Nombre", controller: nombreController, minLength: 0),
              NumberInputTitle(title: "Codigo", controller: codigoController),
              WebDatePickerTitle(title: "Fecha Inicial", controller: fechaInicioController),
              WebDatePickerTitle(title: "Fecha Final", controller: fechaFinController),
            ],
          ),
          BlocBuilder<ModuloBloc, ModuloState>(
            builder: (context, state) {
              int cantdiad = 0;
              bool isConsulted = false;
              bool isInProgress = false;
              String error = "";
              if (state is ModuloLoadingState) {
                isInProgress = true;
              }
              if (state is ModuloErrorFormState) {
                error = state.error!;
              }
              if (state is ModuloConsultedState) {
                isInProgress = false;
                isConsulted = true;
                cantdiad = state.modulos.length;
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
        final request = ModuloRequest.fromMap(map);
        context.read<ModuloBloc>().add(UpdateModuloEvent(request));
      }
    }

    Map<String, DataItemGrid> buildPlutoRowData(Modulo modulo, List<String> tiposList) {
      return {
        'id': DataItemGrid(type: Tipo.item, value: modulo.moduloId, edit: false),
        'codigo': DataItemGrid(type: Tipo.text, value: modulo.moduloCodigo, edit: false),
        'nombre': DataItemGrid(type: Tipo.text, value: modulo.moduloNombre, edit: true),
        'detalles': DataItemGrid(type: Tipo.text, value: modulo.moduloDetalles, edit: false),
        'path': DataItemGrid(type: Tipo.text, value: modulo.moduloPath, edit: false),
        'icono': DataItemGrid(type: Tipo.text, value: modulo.moduloIcono, edit: false),
        'paquete': DataItemGrid(type: Tipo.text, value: modulo.paquete, edit: false),
        'fecha_creacion': DataItemGrid(type: Tipo.date, value: modulo.fechaCreacion, edit: false),
        'visible': DataItemGrid(type: Tipo.boolean, value: modulo.moduloVisible, edit: true),
      };
    }

    return BlocBuilder<ModuloBloc, ModuloState>(
      builder: (context, state) {
        if (state is ModuloConsultedState) {
          final tiposList = context.read<ModuloBloc>().paquetes.map((e) => '${e.codigo}-${e.nombre.toUpperCase()}').toList();
          final List<Map<String, DataItemGrid>> plutoRes = [];
          for (Modulo modulo in state.modulos) {
            final Map<String, DataItemGrid> rowData = buildPlutoRowData(modulo, tiposList);
            plutoRes.add(rowData);
          }
          if (plutoRes.isEmpty) {
            return const Text("No se encontraron resultados");
          }
          return PlutoGridDataBuilder(plutoData: plutoRes, onRowChecked: onRowChecked, onPressedSave: onPressedSave);
        }
        return const SizedBox();
      }
    );
  }

}
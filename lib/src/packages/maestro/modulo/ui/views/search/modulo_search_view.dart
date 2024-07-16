import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/modulo.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/modulo_paquete.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/request/modulo_request.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/ui/blocs/modulo_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/ui/views/field_paquete.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class ModuloSearchView extends StatelessWidget {
  const ModuloSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ModuloBloc, ModuloState>(
      listener: (BuildContext context, ModuloState state) {
        if (state is ModuloExceptionState) {
          ErrorDialog.showDioException(context, state.exception!);
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
    final TextEditingController paqueteController = TextEditingController();
    bool isActivo = true;

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final ModuloBloc moduloBloc = context.read<ModuloBloc>();

    void onPressed() {
      bool isValid = formKey.currentState!.validate();
      final bool isCampoVacio =
          nombreController.text.isEmpty && codigoController.text.isEmpty && paqueteController.text.isEmpty && isActivo;

      if (isCampoVacio) {
        isValid = false;
        moduloBloc.add(const ErrorFormModuloEvent("Por favor diligenciar por lo menos un campo del formulario"));
      }

      if (isValid) {
        final ModuloRequest request = ModuloRequest(
          moduloNombre: nombreController.text,
          moduloCodigo: int.tryParse(codigoController.text),
          paquete: paqueteController.text,
          moduloActivo: isActivo,
        );
        context.read<ModuloBloc>().add(GetModuloEvent(request));
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
              FieldPaquete(paqueteController),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Activo", style: AppTheme.titleStyle),
                  const SizedBox(height: 8),
                  SwitchBoxInput(value: isActivo, onChanged: (bool newValue) => isActivo = newValue),
                ],
              ),
            ],
          ),
          BlocBuilder<ModuloBloc, ModuloState>(
            builder: (BuildContext context, ModuloState state) {
              int cantdiad = 0;
              bool isConsulted = false;
              bool isInProgress = false;
              String error = "";
              if (state is ModuloLoadingState) {
                isInProgress = true;
              }
              if (state is ModuloErrorFormState) {
                error = state.error;
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
  List<Map<String, dynamic>> listUpdate = <Map<String, dynamic>>[];

  @override
  Widget build(BuildContext context) {
    void onRowChecked(List<Map<String, dynamic>> event) {
      listUpdate.clear();
      setState(() => listUpdate.addAll(event));
    }

    void onPressedSave() {
      for (final Map<String, dynamic> map in listUpdate) {
        final ModuloRequest request = ModuloRequest.fromMap(map);
        context.read<ModuloBloc>().add(UpdateModuloEvent(request));
      }
    }

    Map<String, DataItemGrid> buildPlutoRowData(Modulo modulo, List<String> tiposList) {
      return <String, DataItemGrid>{
        'id': DataItemGrid(type: Tipo.item, value: modulo.moduloId, edit: false),
        'codigo': DataItemGrid(type: Tipo.text, value: modulo.moduloCodigo, edit: false),
        'nombre': DataItemGrid(type: Tipo.text, value: modulo.moduloNombre, edit: true),
        'detalles': DataItemGrid(type: Tipo.text, value: modulo.moduloDetalles, edit: false),
        'path': DataItemGrid(type: Tipo.text, value: modulo.moduloPath, edit: false),
        'icono': DataItemGrid(type: Tipo.text, value: modulo.moduloIcono, edit: false),
        'paquete': DataItemGrid(type: Tipo.text, value: modulo.paquete, edit: false),
        'fecha_creacion': DataItemGrid(type: Tipo.date, value: modulo.fechaCreacion, edit: false),
        'activo': DataItemGrid(type: Tipo.boolean, value: modulo.moduloActivo, edit: false),
        'visible': DataItemGrid(type: Tipo.boolean, value: modulo.moduloVisible, edit: true),
      };
    }

    return BlocBuilder<ModuloBloc, ModuloState>(
      builder: (BuildContext context, ModuloState state) {
        if (state is ModuloConsultedState) {
          final List<String> tiposList =
              context.read<ModuloBloc>().paquetes.map((ModuloPaquete e) => '${e.codigo}-${e.nombre.toUpperCase()}').toList();
          final List<Map<String, DataItemGrid>> plutoRes = <Map<String, DataItemGrid>>[];
          for (final Modulo modulo in state.modulos) {
            final Map<String, DataItemGrid> rowData = buildPlutoRowData(modulo, tiposList);
            plutoRes.add(rowData);
          }
          if (plutoRes.isEmpty) {
            return const Text("No se encontraron resultados");
          }
          return PlutoGridDataBuilder(plutoData: plutoRes, onRowChecked: onRowChecked, onPressedSave: onPressedSave);
        }
        return const SizedBox();
      },
    );
  }
}

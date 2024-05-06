import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/accion_documento_domain.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/ui/blocs/accion_documentos/accion_documento_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/ui/views/field_tipo_documento.dart';
import 'package:switrans_2_0/src/util/shared/views/views_shared.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class AccionDocumentoSearchView extends StatelessWidget {
  const AccionDocumentoSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final fullPath = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;

    return BlocListener<AccionDocumentoBloc, AccionDocumentoState>(
      listener: (context, state) {
        if (state is AccionDocumentoExceptionState) {
          ErrorDialog.showDioException(context, state.exception!);
        }
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
          tipoDocumento: typeController.text,
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
              NumberInputTitle(title: "Codigo", controller: codigoController),
              TextInputTitle(title: "Nombre", controller: nombreController, minLength: 0),
              FieldTipoDocumento(typeController),
            ],
          ),
          BlocBuilder<AccionDocumentoBloc, AccionDocumentoState>(
            builder: (context, state) {
              int cantidad = 0;
              bool isConsulted = false;
              bool isInProgress = false;
              String error = "";
              if (state is AccionDocumentoLoadingState) {
                isInProgress = true;
              } else if (state is AccionDocumentoErrorFormState) {
                error = state.error!;
              } else if (state is AccionDocumentoConsultedState) {
                isConsulted = true;
                cantidad = state.accionDocumentos.length;
              } else if (state is AccionDocumentoSuccesState) {
                final request = AccionDocumentoRequest(codigo: state.accionDocumento!.codigo);
                context.read<AccionDocumentoBloc>().add(GetAccionDocumentoEvent(request));
                context.go('/maestros/accion_documentos/buscar');
              }
              return BuildButtonForm(
                onPressed: onPressed,
                icon: Icons.search,
                label: "Buscar",
                cantdiad: cantidad,
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

    Map<String, DataItemGrid> buildPlutoRowData(AccionDocumento accionDocumento, List<String> tiposList) {
      return {
        'codigo': DataItemGrid(type: Tipo.item, value: accionDocumento.codigo, edit: false),
        'nombre': DataItemGrid(type: Tipo.text, value: accionDocumento.nombre, edit: true),
        'tipo_documento': DataItemGrid(type: Tipo.select, value: accionDocumento.tipo, edit: true, dataList: tiposList),
        'naturaleza_inversa': DataItemGrid(type: Tipo.boolean, value: accionDocumento.esInverso, edit: true),
        'activo': DataItemGrid(type: Tipo.boolean, value: accionDocumento.esActivo, edit: true),
        'fecha_creacion': DataItemGrid(type: Tipo.date, value: accionDocumento.fechaCreacion, edit: false),
        'fecha_actualizacion': DataItemGrid(type: Tipo.date, value: accionDocumento.fechaActualizacion, edit: false),
        'usuario': DataItemGrid(type: Tipo.text, value: accionDocumento.usuario, edit: false),
      };
    }

    return BlocBuilder<AccionDocumentoBloc, AccionDocumentoState>(
      builder: (context, state) {
        if (state is AccionDocumentoConsultedState) {
          final tiposList = context.read<AccionDocumentoBloc>().tipos.map((e) => '${e.codigo}-${e.nombre.toUpperCase()}').toList();
          final List<Map<String, DataItemGrid>> plutoRes = [];
          for (AccionDocumento accionDocumento in state.accionDocumentos) {
            final Map<String, DataItemGrid> rowData = buildPlutoRowData(accionDocumento, tiposList);
            plutoRes.add(rowData);
          }
          if (plutoRes.isEmpty) {
            return const Text("No se encontraon resultados");
          }
          return PlutoGridDataBuilder(plutoData: plutoRes, onRowChecked: onRowChecked, onPressedSave: onPressedSave);
        }
        return const SizedBox();
      },
    );
  }
}

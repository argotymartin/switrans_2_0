import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/data/models/request/unidad_negocio_request_model.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/domain/entities/request/unidad_negocio_request.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/domain/entities/unidad_negocio.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/ui/blocs/unidad_negocio/unidad_negocio_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/ui/views/field_unidad_negocio_empresa.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class UnidadNegocioSearchView extends StatelessWidget {
  const UnidadNegocioSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final fullPath = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;

    return BlocListener<UnidadNegocioBloc, UnidadNegocioState>(
      listener: (context, state) {
        if (state is UnidadNegocioFailedState) {
          ErrorDialog.showDioException(context, state.exception!);
        }
      },
      child: ListView(
        padding: const EdgeInsets.only(right: 32, top: 8),
        physics: const ClampingScrollPhysics(),
        children: [
          BuildViewDetail(path: fullPath),
          const WhiteCard(title: "Buscar Registros", icon: Icons.search, child: _BuildFieldsForm()),
          const _BluildDataTable(),
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
    final TextEditingController empresaController = TextEditingController();
    bool? isActivo = true;

    final formKey = GlobalKey<FormState>();

    final UnidadNegocioBloc unidadNegocioBloc = context.read<UnidadNegocioBloc>();

    void onPressed() {
      bool isValid = formKey.currentState!.validate();
      final bool isCampoVacio =
          nombreController.text.isEmpty && codigoController.text.isEmpty && empresaController.text.isEmpty && isActivo == null;

      if (isCampoVacio) {
        isValid = false;
        unidadNegocioBloc.add(const ErrorFormUnidadNegocioEvent("Por favor diligenciar por lo menos un campo del formulario"));
      }
      if (isValid) {
        final request = UnidadNegocioRequest(
          nombre: nombreController.text,
          codigo: int.tryParse(codigoController.text),
          empresa: empresaController.text,
          isActivo: isActivo,
        );
        unidadNegocioBloc.add(GetUnidadNegocioEvent(request));
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
              FieldUnidadNegocioEmpresa(empresaController),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text("Activo", style: AppTheme.titleStyle),
                const SizedBox(height: 8),
                SwitchBoxInput(value: isActivo, onChanged: (newValue) => isActivo = newValue),
              ])
            ],
          ),
          BlocBuilder<UnidadNegocioBloc, UnidadNegocioState>(
            builder: (context, state) {
              int cantidad = 0;
              bool isConsulted = false;
              bool isInProgress = false;
              String error = "";
              if (state is UnidadNegocioLoadingState) {
                isInProgress = true;
              } else if (state is UnidadNegocioErrorFormState) {
                error = state.errorForm!;
              } else if (state is UnidadNegocioConsultedState) {
                isConsulted = true;
                cantidad = state.unidadNegocioList.length;
              } else if (state is UnidadNegocioSuccessState) {
                final request = UnidadNegocioRequest(codigo: state.unidadNegocio!.codigo);
                unidadNegocioBloc.add(GetUnidadNegocioEvent(request));
                context.go('/maestros/unidad_negocio/buscar');
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
    void onRowChecked(event) {
      listUpdate.clear();
      setState(() => listUpdate.addAll(event));
    }

    void onPressedSave() {
      for (final Map<String, dynamic> map in listUpdate) {
        final request = UnidadNegocioRequestModel.fromMapTable(map);
        context.read<UnidadNegocioBloc>().add(UpdateUnidadNegocioEvent(request));
      }
    }

    Map<String, DataItemGrid> buildPlutoRowData(UnidadNegocio unidadNegocio) {
      return {
        'codigo': DataItemGrid(type: Tipo.item, value: unidadNegocio.codigo, edit: false),
        'nombre': DataItemGrid(type: Tipo.text, value: unidadNegocio.nombre, edit: true),
        'activo': DataItemGrid(type: Tipo.boolean, value: unidadNegocio.isActivo, edit: true),
        'fecha_creacion': DataItemGrid(type: Tipo.date, value: unidadNegocio.fechaCreacion, edit: false),
        'usuario': DataItemGrid(type: Tipo.text, value: unidadNegocio.usuario, edit: false),
        'empresa': DataItemGrid(type: Tipo.text, value: unidadNegocio.empresa, edit: true),
      };
    }

    return BlocBuilder<UnidadNegocioBloc, UnidadNegocioState>(
      builder: (context, state) {
        if (state is UnidadNegocioConsultedState) {
          final List<Map<String, DataItemGrid>> plutoRes = [];
          for (final UnidadNegocio unidadNegocio in state.unidadNegocioList) {
            final Map<String, DataItemGrid> rowData = buildPlutoRowData(unidadNegocio);
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

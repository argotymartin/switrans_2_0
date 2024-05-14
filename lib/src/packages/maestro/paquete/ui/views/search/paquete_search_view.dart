import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/domain/entities/paquete.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/domain/entities/request/paquete_request.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/ui/blocs/paquete_bloc.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class PaqueteSearchView extends StatelessWidget {
  const PaqueteSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final String fullPath = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;

    return BlocListener<PaqueteBloc, PaqueteState>(
      listener: (BuildContext context, PaqueteState state) {
        if (state is PaqueteExceptionState) {
          ErrorDialog.showDioException(context, state.exception!);
        }
      },
      child: Stack(
        children: <Widget>[
          ListView(
            padding: const EdgeInsets.only(right: 32, top: 8),
            physics: const ClampingScrollPhysics(),
            children: <Widget>[
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
    bool isVisible = true;

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final PaqueteBloc paqueteBloc = context.read<PaqueteBloc>();

    void onPressed() {
      bool isValid = formKey.currentState!.validate();
      final bool isCampoVacio =
          nombreController.text.isEmpty && codigoController.text.isEmpty && isVisible;

      if (isCampoVacio) {
        isValid = false;
        paqueteBloc.add(const ErrorFormPaqueteEvent("Por favor diligenciar por lo menos un campo del formulario"));
      }

      if (isValid) {
        final PaqueteRequest request = PaqueteRequest(
          paqueteNombre: nombreController.text,
          paqueteCodigo: int.tryParse(codigoController.text),
          paqueteVisible: isVisible,
        );
        context.read<PaqueteBloc>().add(GetPaqueteEvent(request));
      }
    }

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BuildRowsForm(
            children: <Widget>[
              TextInputTitle(title: "Nombre", controller: nombreController, minLength: 0),
              NumberInputTitle(title: "Codigo", controller: codigoController),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Visible", style: AppTheme.titleStyle),
                  const SizedBox(height: 8),
                  SwitchBoxInput(value: isVisible, onChanged: (bool newValue) => isVisible = newValue),
                ],
              ),
            ],
          ),
          BlocBuilder<PaqueteBloc, PaqueteState>(
            builder: (BuildContext context, PaqueteState state) {
              int cantdiad = 0;
              bool isConsulted = false;
              bool isInProgress = false;
              String error = "";
              if (state is PaqueteLoadingState) {
                isInProgress = true;
              }
              if (state is PaqueteErrorFormState) {
                error = state.error;
              }
              if (state is PaqueteConsultedState) {
                isInProgress = false;
                isConsulted = true;
                cantdiad = state.paquetes.length;
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
        final PaqueteRequest request = PaqueteRequest.fromMap(map);
        context.read<PaqueteBloc>().add(UpdatePaqueteEvent(request));
      }
    }

    Map<String, DataItemGrid> buildPlutoRowData(Paquete paquete) {
      return <String, DataItemGrid>{
        'id': DataItemGrid(type: Tipo.item, value: paquete.paqueteId, edit: false),
        'codigo': DataItemGrid(type: Tipo.text, value: paquete.paqueteCodigo, edit: false),
        'nombre': DataItemGrid(type: Tipo.text, value: paquete.paqueteNombre, edit: true),
        'path': DataItemGrid(type: Tipo.text, value: paquete.paquetePath, edit: false),
        'icono': DataItemGrid(type: Tipo.text, value: paquete.paqueteIcono, edit: true),
        'fecha_creacion': DataItemGrid(type: Tipo.date, value: paquete.fechaCreacion, edit: false),
        'visible': DataItemGrid(type: Tipo.boolean, value: paquete.paqueteVisible, edit: true),
      };
    }

    return BlocBuilder<PaqueteBloc, PaqueteState>(
      builder: (BuildContext context, PaqueteState state) {
        if (state is PaqueteConsultedState) {
          final List<Map<String, DataItemGrid>> plutoRes = <Map<String, DataItemGrid>>[];
          for (final Paquete paquete in state.paquetes) {
            final Map<String, DataItemGrid> rowData = buildPlutoRowData(paquete);
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

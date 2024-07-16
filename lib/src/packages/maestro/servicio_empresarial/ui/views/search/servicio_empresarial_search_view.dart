import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/packages/maestro/servicio_empresarial/domain/entities/request/servicio_empresarial_request.dart';
import 'package:switrans_2_0/src/packages/maestro/servicio_empresarial/domain/entities/servicio_empresarial.dart';
import 'package:switrans_2_0/src/packages/maestro/servicio_empresarial/ui/blocs/servicio_empresarial/servicio_empresarial_bloc.dart';
import 'package:switrans_2_0/src/util/shared/views/views_shared.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class ServicoEmpresarialSearchView extends StatelessWidget {
  const ServicoEmpresarialSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ServicioEmpresarialBloc, ServicioEmpresarialState>(
      listener: (BuildContext context, ServicioEmpresarialState state) {
        if (state is ServicioEmpresarialExceptionState) {
          ErrorDialog.showDioException(context, state.exception);
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

    final ServicioEmpresarialBloc accionDocumentoBloc = context.read<ServicioEmpresarialBloc>();

    void onPressed() {
      bool isValid = formKey.currentState!.validate();
      final bool isCampoVacio = nombreController.text.isEmpty && codigoController.text.isEmpty;

      if (isCampoVacio) {
        isValid = false;
        accionDocumentoBloc.add(const ErrorFormServicioEmpresarialEvent("Por favor diligenciar por lo menos un campo del formulario"));
      }
      if (isValid) {
        final ServicioEmpresarialRequest request = ServicioEmpresarialRequest(
          nombre: nombreController.text,
          codigo: int.tryParse(codigoController.text),
        );
        accionDocumentoBloc.add(GetServicioEmpresarialEvent(request));
      }
    }

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BuildFormFields(
            children: <Widget>[
              NumberInputTitle(title: "Codigo", controller: codigoController),
              TextInputTitle(title: "Nombre", controller: nombreController, typeInput: TypeInput.lettersAndNumbers),
            ],
          ),
          BlocBuilder<ServicioEmpresarialBloc, ServicioEmpresarialState>(
            builder: (BuildContext context, ServicioEmpresarialState state) {
              int cantidad = 0;
              bool isConsulted = false;
              bool isInProgress = false;
              String error = "";
              if (state is ServicioEmpresarialLoadingState) {
                isInProgress = true;
              } else if (state is ServicioEmpresarialErrorFormState) {
                error = state.errorForm;
              } else if (state is ServicioEmpresarialConsultedState) {
                isConsulted = true;
                cantidad = state.serviciosEmpresariales.length;
              } else if (state is ServicioEmpresarialSuccesState) {
                final ServicioEmpresarialRequest request = ServicioEmpresarialRequest(codigo: state.servicioEmpresarial!.codigo);
                accionDocumentoBloc.add(GetServicioEmpresarialEvent(request));
                context.go('/maestros/servicio_empresarial/buscar');
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
  List<Map<String, dynamic>> listUpdate = <Map<String, dynamic>>[];
  @override
  Widget build(BuildContext context) {
    void onRowChecked(List<Map<String, dynamic>> event) {
      listUpdate.clear();
      setState(() => listUpdate.addAll(event));
    }

    void onPressedSave() {
      for (final Map<String, dynamic> map in listUpdate) {
        final ServicioEmpresarialRequest request = ServicioEmpresarialRequest.fromMapTable(map);
        context.read<ServicioEmpresarialBloc>().add(UpdateServicioEmpresarialEvent(request));
      }
    }

    Map<String, DataItemGrid> buildPlutoRowData(ServicioEmpresarial servicio) {
      return <String, DataItemGrid>{
        'codigo': DataItemGrid(type: Tipo.item, value: servicio.codigo, edit: false),
        'nombre': DataItemGrid(type: Tipo.text, value: servicio.nombre, edit: true),
        'activo': DataItemGrid(type: Tipo.boolean, value: servicio.esActivo, edit: true),
        'fecha_creacion': DataItemGrid(type: Tipo.date, value: servicio.fechaCreacion, edit: false),
        'fecha_actualizacion': DataItemGrid(type: Tipo.date, value: servicio.fechaModificacion, edit: false),
        'usuario': DataItemGrid(type: Tipo.text, value: servicio.usuario, edit: false),
      };
    }

    return BlocBuilder<ServicioEmpresarialBloc, ServicioEmpresarialState>(
      builder: (BuildContext context, ServicioEmpresarialState state) {
        if (state is ServicioEmpresarialConsultedState) {
          final List<Map<String, DataItemGrid>> plutoRes = <Map<String, DataItemGrid>>[];
          for (final ServicioEmpresarial servico in state.serviciosEmpresariales) {
            final Map<String, DataItemGrid> rowData = buildPlutoRowData(servico);
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

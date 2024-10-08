import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/servicio_empresarial/data/models/request/servicio_empresarial_request_model.dart';
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
    return BlocConsumer<ServicioEmpresarialBloc, ServicioEmpresarialState>(
      listener: (BuildContext context, ServicioEmpresarialState state) {
        if (state.status == ServicioEmpresarialStatus.exception) {
          CustomToast.showError(context, state.exception!);
        }
      },
      builder: (BuildContext context, ServicioEmpresarialState state) {
        return Stack(
          children: <Widget>[
            ListView(
              padding: const EdgeInsets.only(right: 32, top: 8),
              physics: const ClampingScrollPhysics(),
              children: <Widget>[
                const BuildViewDetail(),
                CardExpansionPanel(title: "Buscar Registros", icon: Icons.search, child: _BuildFieldsForm(state)),
                const _BluildDataTable(),
              ],
            ),
            if (state.status == ServicioEmpresarialStatus.loading) const LoadingModal(),
          ],
        );
      },
    );
  }
}

class _BuildFieldsForm extends StatelessWidget {
  final ServicioEmpresarialState state;
  const _BuildFieldsForm(this.state);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final ServicioEmpresarialBloc accionDocumentoBloc = context.read<ServicioEmpresarialBloc>();
    final ServicioEmpresarialRequest request = accionDocumentoBloc.request;

    void onPressed() {
      if (request.hasNonNullField()) {
        accionDocumentoBloc.add(GetServicioEmpresarialEvent(request));
      } else {
        accionDocumentoBloc.add(const ErrorFormServicioEmpresarialEvent("Por favor diligenciar por lo menos un campo del formulario"));
      }
    }

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BuildFormFields(
            children: <Widget>[
              NumberInputForm(
                title: "Codigo",
                value: request.codigo,
                autofocus: true,
                onChanged: (String result) => request.codigo = result.isNotEmpty ? int.parse(result) : null,
              ),
              TextInputForm(
                title: "Nombre",
                value: request.nombre != null ? request.nombre! : "",
                typeInput: TypeInput.lettersAndNumbers,
                onChanged: (String result) => request.nombre = result.isNotEmpty ? result : null,
              ),
              SegmentedInputForm(
                title: "Activo",
                value: request.isActivo,
                onChanged: (bool? newValue) => request.isActivo = newValue,
              ),
            ],
          ),
          FormButton(label: "Buscar", icon: Icons.search, onPressed: onPressed),
          if (state.status == ServicioEmpresarialStatus.error) ErrorModal(title: state.error!),
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
    return BlocBuilder<ServicioEmpresarialBloc, ServicioEmpresarialState>(
      builder: (BuildContext context, ServicioEmpresarialState state) {
        if (state.status == ServicioEmpresarialStatus.consulted) {
          void onRowChecked(List<Map<String, dynamic>> event) {
            listUpdate.clear();
            setState(() => listUpdate.addAll(event));
          }

          void onPressedSave() {
            final List<ServicioEmpresarialRequest> requestList = <ServicioEmpresarialRequest>[];
            for (final Map<String, dynamic> map in listUpdate) {
              final ServicioEmpresarialRequest request = ServicioEmpresarialRequestModel.fromTable(map);
              requestList.add(request);
            }
            context.read<ServicioEmpresarialBloc>().add(UpdateServicioEmpresarialEvent(requestList));
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

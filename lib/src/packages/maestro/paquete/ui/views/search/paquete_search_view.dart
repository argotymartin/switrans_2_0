import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/data/models/request/paquete_request_model.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/domain/entities/paquete.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/domain/entities/request/paquete_request.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/ui/blocs/paquete_bloc.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class PaqueteSearchView extends StatelessWidget {
  const PaqueteSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaqueteBloc, PaqueteState>(
      listener: (BuildContext context, PaqueteState state) {
        if (state.status == PaqueteStatus.exception) {
          CustomToast.showError(context, state.exception!);
        }
      },
      builder: (BuildContext context, PaqueteState state) {
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
            if (state.status == PaqueteStatus.loading) const LoadingModal(),
          ],
        );
      },
    );
  }
}

class _BuildFieldsForm extends StatelessWidget {
  final PaqueteState state;
  const _BuildFieldsForm(this.state);
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final PaqueteBloc paqueteBloc = context.watch<PaqueteBloc>();
    final PaqueteRequest request = paqueteBloc.request;

    void onPressed() {
      if (request.hasNonNullField()) {
        paqueteBloc.add(GetPaqueteEvent(request));
      } else {
        paqueteBloc.add(const ErrorFormPaqueteEvent("Por favor diligenciar por lo menos un campo del formulario"));
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
                value: request.nombre,
                typeInput: TypeInput.lettersAndNumbers,
                onChanged: (String result) => request.nombre = result.isNotEmpty ? result : null,
              ),
              SegmentedInputForm(
                title: "Visible",
                value: request.isVisible,
                onChanged: (bool? newValue) => request.isVisible = newValue,
              ),
              SegmentedInputForm(
                title: "Activo",
                value: request.isActivo,
                onChanged: (bool? newValue) => request.isActivo = newValue,
              ),
            ],
          ),
          FormButton(label: "Buscar", icon: Icons.search, onPressed: onPressed),
          if (state.status == PaqueteStatus.error) ErrorModal(title: state.error!),
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
    return BlocBuilder<PaqueteBloc, PaqueteState>(
      builder: (BuildContext context, PaqueteState state) {
        if (state.status == PaqueteStatus.consulted) {
          void onRowChecked(List<Map<String, dynamic>> event) {
            listUpdate.clear();
            setState(() => listUpdate.addAll(event));
          }

          void onPressedSave() {
            final List<PaqueteRequest> requestList = <PaqueteRequest>[];
            for (final Map<String, dynamic> map in listUpdate) {
              final PaqueteRequest request = PaqueteRequestModel.fromMap(map);
              requestList.add(request);
            }
            context.read<PaqueteBloc>().add(UpdatePaqueteEvent(requestList));
          }

          Map<String, DataItemGrid> buildPlutoRowData(Paquete paquete) {
            return <String, DataItemGrid>{
              'codigo': DataItemGrid(type: Tipo.item, value: paquete.codigo, edit: false),
              'nombre': DataItemGrid(type: Tipo.text, value: paquete.nombre, edit: true),
              'path': DataItemGrid(type: Tipo.text, value: paquete.path, edit: false),
              'icono': DataItemGrid(type: Tipo.text, value: paquete.icono, edit: true),
              'fecha_creacion': DataItemGrid(type: Tipo.date, value: paquete.fechaCreacion, edit: false),
              'visible': DataItemGrid(type: Tipo.boolean, value: paquete.isVisible, edit: true),
              'activo': DataItemGrid(type: Tipo.boolean, value: paquete.isActivo, edit: true),
            };
          }

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

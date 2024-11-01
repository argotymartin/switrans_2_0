import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/globals/login/ui/login_ui.dart';
import 'package:switrans_2_0/src/packages/contabilidad/tipo_impuesto/data/data.dart';
import 'package:switrans_2_0/src/packages/contabilidad/tipo_impuesto/domain/domain.dart';
import 'package:switrans_2_0/src/packages/contabilidad/tipo_impuesto/ui/blocs/tipo_impuesto_bloc.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class TipoImpuestoSearchView extends StatelessWidget {
  const TipoImpuestoSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TipoImpuestoBloc, TipoImpuestoState>(
      listener: (BuildContext context, TipoImpuestoState state) {
        if (state.status == TipoImpuestoStatus.exception) {
          CustomToast.showError(context, state.exception!);
        }
      },
      builder: (BuildContext context, TipoImpuestoState state) {
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
            if (state.status == TipoImpuestoStatus.loading) const LoadingModal(),
          ],
        );
      },
    );
  }
}

class _BuildFieldsForm extends StatelessWidget {
  final TipoImpuestoState state;
  const _BuildFieldsForm(
    this.state,
  );

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TipoImpuestoBloc tipoImpuestoBloc = context.read<TipoImpuestoBloc>();
    final TipoImpuestoRequest request = tipoImpuestoBloc.request;

    void onPressed() {
      if (request.hasNonNullField()) {
        tipoImpuestoBloc.add(GetTipoImpuestosEvent(request));
      } else {
        tipoImpuestoBloc.add(const ErrorFormTipoImpuestoEvent("Por favor diligenciar por lo menos un campo del formulario"));
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
                title: "Activo",
                value: request.isActivo,
                onChanged: (bool? newValue) => request.isActivo = newValue,
              ),
            ],
          ),
          FormButton(label: "Buscar", icon: Icons.search, onPressed: onPressed),
          if (state.status == TipoImpuestoStatus.error) ErrorModal(title: state.error),
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
    return BlocBuilder<TipoImpuestoBloc, TipoImpuestoState>(
      builder: (BuildContext context, TipoImpuestoState state) {
        if (state.status == TipoImpuestoStatus.consulted) {
          void onRowChecked(List<Map<String, dynamic>> event) {
            listUpdate.clear();
            setState(() => listUpdate.addAll(event));
          }

          void onPressedSave() {
            final List<EntityUpdate<TipoImpuestoRequest>> requestList = <EntityUpdate<TipoImpuestoRequest>>[];
            for (final Map<String, dynamic> map in listUpdate) {
              final TipoImpuestoRequest request = TipoImpuestoRequestModel.fromMap(map["data"]);
              request.codigoUsuario = context.read<AuthBloc>().state.auth?.usuario.codigo;
              requestList.add(EntityUpdate<TipoImpuestoRequest>(id: map["id"], entity: request));
            }
            context.read<TipoImpuestoBloc>().add(UpdateTipoImpuestosEvent(requestList));
          }

          Map<String, DataItemGrid> buildPlutoRowData(TipoImpuesto tipoImpuesto) {
            return <String, DataItemGrid>{
              'codigo': DataItemGrid(
                title: "Codigo",
                type: Tipo.item,
                value: tipoImpuesto.codigo,
                edit: false,
              ),
              'nombre': DataItemGrid(
                title: "Nombre",
                type: Tipo.text,
                value: tipoImpuesto.nombre,
                typeInput: TypeInput.lettersAndNumbers,
                minLength: 5,
                edit: false,
                width: 400,
              ),
              'nombreUsuario': DataItemGrid(
                title: "Usuario",
                type: Tipo.text,
                value: tipoImpuesto.nombreUsuario,
                typeInput: TypeInput.lettersAndNumbers,
                minLength: 5,
                edit: false,
                width: 200,
              ),
              'fechaCreacion': DataItemGrid(
                title: "Fecha Creacion",
                type: Tipo.text,
                value: tipoImpuesto.fechaCreacion,
                edit: false,
              ),
              'isActivo': DataItemGrid(
                title: "Activo",
                type: Tipo.boolean,
                value: tipoImpuesto.isActivo,
                edit: true,
              ),
            };
          }

          final List<Map<String, DataItemGrid>> plutoRes = <Map<String, DataItemGrid>>[];
          for (final TipoImpuesto tipoImpuestos in state.tipoImpuestos) {
            final Map<String, DataItemGrid> rowData = buildPlutoRowData(tipoImpuestos);
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

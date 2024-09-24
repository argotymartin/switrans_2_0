import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/globals/login/ui/login_ui.dart';
import 'package:switrans_2_0/src/packages/maestro/pais/data/models/request/pais_request_model.dart';
import 'package:switrans_2_0/src/packages/maestro/pais/domain/entities/pais.dart';
import 'package:switrans_2_0/src/packages/maestro/pais/domain/entities/request/pais_request.dart';
import 'package:switrans_2_0/src/packages/maestro/pais/ui/blocs/pais_bloc.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class PaisSearchView extends StatelessWidget {
  const PaisSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaisBloc, PaisState>(
      listener: (BuildContext context, PaisState state) {
        if (state.status == PaisStatus.exception) {
          CustomToast.showError(context, state.exception!);
        }
      },
      builder: (BuildContext context, PaisState state) {
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
            if (state.status == PaisStatus.loading) const LoadingModal(),
          ],
        );
      },
    );
  }
}

class _BuildFieldsForm extends StatelessWidget {
  final PaisState state;
  const _BuildFieldsForm(this.state);
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final PaisBloc paisBloc = context.read<PaisBloc>();
    final PaisRequest request = paisBloc.request;

    void onPressed() {
      if (request.hasNonNullField()) {
        paisBloc.add(const GetPaisEvent());
      } else {
        paisBloc.add(const ErrorFormPaisEvent("Por favor diligenciar por lo menos un campo del formulario"));
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
                value: request.estado,
                onChanged: (bool? newValue) => request.estado = newValue,
              ),
            ],
          ),
          FormButton(label: "Buscar", icon: Icons.search, onPressed: onPressed),
          if (state.status == PaisStatus.error) ErrorModal(title: state.error),
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
    final PaisBloc paisBloc = context.read<PaisBloc>();
    return BlocBuilder<PaisBloc, PaisState>(
      builder: (BuildContext context, PaisState state) {
        if (state.status == PaisStatus.consulted) {
          void onRowChecked(List<Map<String, dynamic>> event) {
            listUpdate.clear();
            setState(() => listUpdate.addAll(event));
          }

          void onPressedSave() {
            final List<PaisRequest> requestList = <PaisRequest>[];
            for (final Map<String, dynamic> map in listUpdate) {
              final PaisRequest request = PaisRequestModel.fromTable(map);
              paisBloc.request.codigoUsuario = context.read<AuthBloc>().state.auth?.usuario.codigo;
              context.read<PaisBloc>().add(UpdatePaisEvent(requestList));
              request.codigoUsuario = context.read<AuthBloc>().state.auth?.usuario.codigo;
              requestList.add(request);
            }
          }

          Map<String, DataItemGrid> buildPlutoRowData(Pais pais) {
            return <String, DataItemGrid>{
              'codigo': DataItemGrid(type: Tipo.item, value: pais.codigo, edit: false),
              'nombre': DataItemGrid(type: Tipo.text, value: pais.nombre, edit: true),
              'fecha_creacion': DataItemGrid(type: Tipo.text, value: pais.fechaCreacion, edit: false),
              'activo': DataItemGrid(type: Tipo.boolean, value: pais.estado, edit: true),
            };
          }

          final List<Map<String, DataItemGrid>> plutoRes = <Map<String, DataItemGrid>>[];
          for (final Pais pais in state.paises) {
            final Map<String, DataItemGrid> rowData = buildPlutoRowData(pais);
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

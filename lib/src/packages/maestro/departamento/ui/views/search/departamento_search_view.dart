import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/globals/login/ui/login_ui.dart';
import 'package:switrans_2_0/src/packages/maestro/departamento/data/data.dart';
import 'package:switrans_2_0/src/packages/maestro/departamento/domain/domain.dart';
import 'package:switrans_2_0/src/packages/maestro/departamento/ui/blocs/departamento_bloc.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';
import 'package:switrans_2_0/src/util/shared/models/entry_autocomplete.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class DepartamentoSearchView extends StatelessWidget {
  const DepartamentoSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DepartamentoBloc, DepartamentoState>(
      listener: (BuildContext context, DepartamentoState state) {
        if (state.status == DepartamentoStatus.exception) {
          CustomToast.showError(context, state.exception!);
        }
      },
      builder: (BuildContext context, DepartamentoState state) {
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
            if (state.status == DepartamentoStatus.loading) const LoadingModal(),
          ],
        );
      },
    );
  }
}

class _BuildFieldsForm extends StatelessWidget {
  final DepartamentoState state;
  const _BuildFieldsForm(
    this.state,
  );

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final DepartamentoBloc departamentoBloc = context.read<DepartamentoBloc>();
    final DepartamentoRequest request = departamentoBloc.request;

    void onPressed() {
      if (request.hasNonNullField()) {
        departamentoBloc.add(GetDepartamentosEvent(request));
      } else {
        departamentoBloc.add(const ErrorFormDepartamentoEvent("Por favor diligenciar por lo menos un campo del formulario"));
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
              TextInputForm(
                title: "Codigo Dane",
                value: request.codigoDane,
                typeInput: TypeInput.onlyNumbers,
                minLength: 2,
                maxLength: 2,
                icon: Icons.numbers,
                onChanged: (String result) => request.codigoDane = result.isNotEmpty ? result : '',
              ),
              AutocompleteInputForm(
                title: "Paises",
                entries: state.entriesPaises,
                value: request.pais,
                onChanged: (EntryAutocomplete result) => request.pais = result.codigo,
              ),
              SegmentedInputForm(
                title: "Activo",
                value: request.isActivo,
                onChanged: (bool? newValue) => request.isActivo = newValue,
              ),
            ],
          ),
          FormButton(label: "Buscar", icon: Icons.search, onPressed: onPressed),
          if (state.status == DepartamentoStatus.error) ErrorModal(title: state.error),
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
    return BlocBuilder<DepartamentoBloc, DepartamentoState>(
      builder: (BuildContext context, DepartamentoState state) {
        if (state.status == DepartamentoStatus.consulted) {
          void onRowChecked(List<Map<String, dynamic>> event) {
            listUpdate.clear();
            setState(() => listUpdate.addAll(event));
          }

          void onPressedSave() {
            final List<EntityUpdate<DepartamentoRequest>> requestList = <EntityUpdate<DepartamentoRequest>>[];
            for (final Map<String, dynamic> map in listUpdate) {
              final DepartamentoRequest request = DepartamentoRequestModel.fromMap(map["data"]);
              request.codigoUsuario = context.read<AuthBloc>().state.auth?.usuario.codigo;
              requestList.add(EntityUpdate<DepartamentoRequest>(id: map["id"], entity: request));
            }
            context.read<DepartamentoBloc>().add(UpdateDepartamentosEvent(requestList));
          }

          Map<String, DataItemGrid> buildPlutoRowData(Departamento departamento) {
            return <String, DataItemGrid>{
              'codigo': DataItemGrid(
                title: "Codigo",
                type: Tipo.item,
                value: departamento.codigo,
                edit: false,
              ),
              'nombre': DataItemGrid(
                title: "Nombre",
                type: Tipo.text,
                value: departamento.nombre,
                edit: true,
              ),
              'Codigo Dane': DataItemGrid(
                title: "Codigo Dane",
                type: Tipo.text,
                value: departamento.codigoDane,
                edit: true,
              ),
              'pais': DataItemGrid(
                title: "Pais",
                type: Tipo.select,
                value: departamento.pais,
                edit: true,
                entryMenus: state.entriesPaises,
              ),
              'fechaCreacion': DataItemGrid(
                title: "Fecha Creacion",
                type: Tipo.text,
                value: departamento.fechaCreacion,
                edit: false,
              ),
              'isActivo': DataItemGrid(
                title: "Activo",
                type: Tipo.boolean,
                value: departamento.isActivo,
                edit: true,
              ),
            };
          }

          final List<Map<String, DataItemGrid>> plutoRes = <Map<String, DataItemGrid>>[];
          for (final Departamento departamento in state.departamentos) {
            final Map<String, DataItemGrid> rowData = buildPlutoRowData(departamento);
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

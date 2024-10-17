import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/globals/login/ui/login_ui.dart';
import 'package:switrans_2_0/src/packages/maestro/municipio/data/data.dart';
import 'package:switrans_2_0/src/packages/maestro/municipio/domain/domain.dart';
import 'package:switrans_2_0/src/packages/maestro/municipio/ui/blocs/municipio_bloc.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';
import 'package:switrans_2_0/src/util/shared/models/entry_autocomplete.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class MunicipioSearchView extends StatelessWidget {
  const MunicipioSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MunicipioBloc, MunicipioState>(
      listener: (BuildContext context, MunicipioState state) {
        if (state.status == MunicipioStatus.exception) {
          CustomToast.showError(context, state.exception!);
        }
      },
      builder: (BuildContext context, MunicipioState state) {
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
            if (state.status == MunicipioStatus.loading) const LoadingModal(),
          ],
        );
      },
    );
  }
}

class _BuildFieldsForm extends StatelessWidget {
  final MunicipioState state;
  const _BuildFieldsForm(
    this.state,
  );

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final MunicipioBloc municipioBloc = context.read<MunicipioBloc>();
    final MunicipioRequest request = municipioBloc.request;

    void onPressed() {
      if (request.hasNonNullField()) {
        municipioBloc.add(GetMunicipiosEvent(request));
      } else {
        municipioBloc.add(const ErrorFormMunicipioEvent("Por favor diligenciar por lo menos un campo del formulario"));
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
                minLength: 3,
                maxLength: 3,
                icon: Icons.numbers,
                onChanged: (String result) => request.codigoDane = result.isNotEmpty ? result : null,
              ),
              AutocompleteInputForm(
                title: "Departamento",
                entries: state.entriesDepartamentos,
                value: request.departamento,
                onChanged: (EntryAutocomplete result) => request.departamento = result.codigo,
              ),
              SegmentedInputForm(
                title: "Activo",
                value: request.isActivo,
                onChanged: (bool? newValue) => request.isActivo = newValue,
              ),
            ],
          ),
          FormButton(label: "Buscar", icon: Icons.search, onPressed: onPressed),
          if (state.status == MunicipioStatus.error) ErrorModal(title: state.error),
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
    context.watch<MunicipioBloc>();
    return BlocBuilder<MunicipioBloc, MunicipioState>(
      builder: (BuildContext context, MunicipioState state) {
        if (state.status == MunicipioStatus.consulted) {
          void onRowChecked(List<Map<String, dynamic>> event) {
            listUpdate.clear();
            setState(() => listUpdate.addAll(event));
          }

          void onPressedSave() {
            final List<EntityUpdate<MunicipioRequest>> requestList = <EntityUpdate<MunicipioRequest>>[];
            for (final Map<String, dynamic> map in listUpdate) {
              final MunicipioRequest request = MunicipioRequestModel.fromMap(map["data"]);
              request.codigoUsuario = context.read<AuthBloc>().state.auth?.usuario.codigo;
              requestList.add(EntityUpdate<MunicipioRequest>(id: map["id"], entity: request));
            }
            context.read<MunicipioBloc>().add(UpdateMunicipiosEvent(requestList));
          }

          Map<String, DataItemGrid> buildPlutoRowData(Municipio municipio) {
            return <String, DataItemGrid>{
              'codigo': DataItemGrid(
                title: "Codigo",
                type: Tipo.item,
                value: municipio.codigo,
                edit: false,
              ),
              'nombre': DataItemGrid(
                title: "Nombre",
                type: Tipo.text,
                value: municipio.nombre,
                edit: true,
              ),
              'codigoDane': DataItemGrid(
                title: "Codigo Dane",
                type: Tipo.text,
                value: municipio.codigoDane ?? '---',
                edit: true,
              ),
              'departamento': DataItemGrid(
                title: "Departamento",
                type: Tipo.select,
                value: municipio.departamento,
                edit: true,
                entryMenus: state.entriesDepartamentos,
              ),
              'nombreUsuario': DataItemGrid(
                title: "Usuario",
                type: Tipo.text,
                value: municipio.nombreUsuario,
                edit: false,
              ),
              'fechaCreacion': DataItemGrid(
                title: "Fecha Creacion",
                type: Tipo.text,
                value: municipio.fechaCreacion,
                edit: false,
              ),
              'isActivo': DataItemGrid(
                title: "Activo",
                type: Tipo.boolean,
                value: municipio.isActivo,
                edit: true,
              ),
            };
          }

          final List<Map<String, DataItemGrid>> plutoRes = <Map<String, DataItemGrid>>[];
          for (final Municipio municipio in state.municipios) {
            final Map<String, DataItemGrid> rowData = buildPlutoRowData(municipio);
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

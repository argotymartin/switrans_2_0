import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/resolucion/data/models/request/resolucion_request_model.dart';
import 'package:switrans_2_0/src/packages/maestro/resolucion/domain/domain.dart';
import 'package:switrans_2_0/src/packages/maestro/resolucion/ui/blocs/resolucion_bloc.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';
import 'package:switrans_2_0/src/util/shared/views/views_shared.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/inputs_forms/date_picker_input_form.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class ResolucionSearchView extends StatelessWidget {
  const ResolucionSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResolucionBloc, ResolucionState>(
      listener: (BuildContext context, ResolucionState state) {
        if (state.status == ResolucionStatus.exception) {
          CustomToast.showError(context, state.exception!);
        }
      },
      builder: (BuildContext context, ResolucionState state) {
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
            if (state.status == ResolucionStatus.loading) const LoadingModal(),
          ],
        );
      },
    );
  }
}

class _BuildFieldsForm extends StatelessWidget {
  final ResolucionState state;
  const _BuildFieldsForm(this.state);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final ResolucionBloc resolucionBloc = context.read<ResolucionBloc>();
    final ResolucionRequest request = resolucionBloc.request;

    void onPressed() {
      if (request.hasNonNullField()) {
        resolucionBloc.add(GetResolucionesEvent(request));
      } else {
        resolucionBloc.add(const ErrorFormResolucionEvent("Por favor diligenciar por lo menos un campo del formulario"));
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
                title: "Código",
                value: request.codigo,
                autofocus: true,
                onChanged: (String result) => request.codigo = result.isNotEmpty ? int.parse(result) : null,
              ),
              TextInputForm(
                title: "Número de Resolución",
                value: request.numero != null ? request.numero! : "",
                typeInput: TypeInput.lettersAndNumbers,
                onChanged: (String result) => request.numero = result.isNotEmpty ? result : null,
              ),
              AutocompleteInputForm(
                title: 'Documento',
                entries: state.resolucionesDocumentos,
                value: request.codigoDocumento,
                onChanged: (EntryAutocomplete result) => request.codigoDocumento = result.codigo,
              ),
            ],
          ),
          BuildFormFields(
            children: <Widget>[
              AutocompleteInputForm(
                title: 'Empresa',
                entries: state.resolucionesEmpresas,
                value: request.codigoEmpresa,
                onChanged: (EntryAutocomplete result) {
                  request.codigoEmpresa = result.codigo;
                  if (result.codigo != null) {
                    final ResolucionEmpresa resultEmpresa =
                        ResolucionEmpresa(codigo: result.codigo!, nombre: result.title, nit: result.subTitle!);
                    resolucionBloc.add(SelectResolucionEmpresaEvent(resultEmpresa));
                  }
                  if (result.codigo == null) {
                    resolucionBloc.add(const CleanSelectResolucionEmpresaEvent());
                  }
                },
              ),
              AutocompleteInputForm(
                title: 'Centro de Costo',
                entries: request.codigoEmpresa == null ? <EntryAutocomplete>[] : state.resolucionesCentroCosto,
                value: request.codigoCentroCosto,
                onChanged: (EntryAutocomplete result) => request.codigoCentroCosto = result.codigo,
              ),
              DatePickerInputForm(
                title: "Fecha Vigencia",
                value: request.fechaVigencia,
                onChanged: (String result) => request.fechaVigencia = result,
                isRange: false,
              ),
            ],
          ),
          BuildFormFields(
            children: <Widget>[
              SegmentedInputForm(
                title: "Activo",
                value: request.isActiva,
                onChanged: (bool? newValue) => request.isActiva = newValue,
              ),
              Container(),
              Container(),
            ],
          ),
          FormButton(label: "Buscar", icon: Icons.search, onPressed: onPressed),
          if (state.status == ResolucionStatus.error) ErrorModal(title: state.error!),
        ],
      ),
    );
  }
}

class _BluildDataTable extends StatefulWidget {
  const _BluildDataTable();

  @override
  _BluildDataTableState createState() => _BluildDataTableState();
}

class _BluildDataTableState extends State<_BluildDataTable> {
  List<Map<String, dynamic>> listUpdate = <Map<String, dynamic>>[];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResolucionBloc, ResolucionState>(
      builder: (BuildContext context, ResolucionState state) {
        if (state.status == ResolucionStatus.consulted) {
          void onRowChecked(List<Map<String, dynamic>> event) {
            listUpdate.clear();
            setState(() => listUpdate.addAll(event));
          }

          void onPressedSave() {
            final List<EntityUpdate<ResolucionRequest>> requestList = <EntityUpdate<ResolucionRequest>>[];
            for (final Map<String, dynamic> map in listUpdate) {
              final ResolucionRequestModel request = ResolucionRequestModel.fromMap(map["data"]);
              requestList.add(EntityUpdate<ResolucionRequest>(id: map["id"], entity: request));
            }
            context.read<ResolucionBloc>().add(UpdateResolucionesEvent(requestList));
          }

          Map<String, DataItemGrid> buildPlutoRowData(Resolucion resolucion) {
            return <String, DataItemGrid>{
              'codigo': DataItemGrid(
                title: "Codigo",
                type: Tipo.item,
                value: resolucion.codigo,
                edit: false,
              ),
              'numero': DataItemGrid(
                title: "Numero",
                type: Tipo.text,
                value: resolucion.numero,
                edit: true,
              ),
              'codigoDocumento': DataItemGrid(
                title: "Documento",
                type: Tipo.select,
                value: resolucion.codigoDocumento,
                entryMenus: state.resolucionesDocumentos,
                edit: false,
              ),
              'fecha': DataItemGrid(
                title: "Fecha",
                type: Tipo.date,
                value: resolucion.fecha,
                edit: true,
              ),
              'fechaVigencia': DataItemGrid(
                title: "Vigencia",
                type: Tipo.date,
                value: resolucion.fechaVigencia,
                edit: false,
              ),
              'rangoInicial': DataItemGrid(
                title: "Rango Inicial",
                type: Tipo.text,
                value: resolucion.rangoInicial,
                edit: false,
              ),
              'rangoFinal': DataItemGrid(
                title: "Rango Final",
                type: Tipo.text,
                value: resolucion.rangoFinal,
                edit: false,
              ),
              'empresaPrefijo': DataItemGrid(
                title: "Prefijo",
                type: Tipo.text,
                value: resolucion.empresaPrefijo,
                edit: false,
              ),
              'codigoEmpresa': DataItemGrid(
                title: "Empresa",
                type: Tipo.select,
                value: resolucion.codigoEmpresa,
                entryMenus: state.resolucionesEmpresas,
                edit: false,
              ),
              'version': DataItemGrid(
                title: "Version",
                type: Tipo.text,
                value: resolucion.version,
                edit: false,
              ),
              'isActiva': DataItemGrid(
                title: "Activa",
                type: Tipo.boolean,
                value: resolucion.isActiva,
                edit: true,
              ),
              'nombreUsuario': DataItemGrid(
                title: "Usuario",
                type: Tipo.text,
                value: resolucion.nombreUsuario,
                edit: false,
              ),
            };
          }

          final List<Map<String, DataItemGrid>> plutoRowData = <Map<String, DataItemGrid>>[];
          for (final Resolucion resolucion in state.resoluciones) {
            final Map<String, DataItemGrid> row = buildPlutoRowData(resolucion);
            plutoRowData.add(row);
          }
          if (plutoRowData.isEmpty) {
            return const Text("No existen registros");
          }
          return PlutoGridDataBuilder(plutoData: plutoRowData, onRowChecked: onRowChecked, onPressedSave: onPressedSave);
        }
        return const SizedBox();
      },
    );
  }
}

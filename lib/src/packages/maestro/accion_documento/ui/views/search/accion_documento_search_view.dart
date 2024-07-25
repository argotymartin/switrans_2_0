import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/accion_documento_domain.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/entities/tipo_documento_accion_documento.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/ui/blocs/accion_documentos/accion_documento_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/ui/views/field_tipo_documento.dart';
import 'package:switrans_2_0/src/util/shared/views/views_shared.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/toasts/custom_toasts.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class AccionDocumentoSearchView extends StatelessWidget {
  const AccionDocumentoSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccionDocumentoBloc, AccionDocumentoState>(
      listener: (BuildContext context, AccionDocumentoState state) {
        if (state is AccionDocumentoExceptionState) {
          CustomToast.showError(context, state.exception!);
        }
      },
      child: ListView(
        padding: const EdgeInsets.only(right: 32, top: 8),
        //physics: const ClampingScrollPhysics(),
        children: const <Widget>[
          BuildViewDetail(),
          CardExpansionPanel(title: "Buscar Registros", icon: Icons.search, child: _BuildFieldsForm()),
          _BluildDataTable(),
        ],
      ),
    );
  }
}

class _BuildFieldsForm extends StatelessWidget {
  const _BuildFieldsForm();

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final AccionDocumentoBloc accionDocumentoBloc = context.read<AccionDocumentoBloc>();

    void onPressed() {
      bool isValid = formKey.currentState!.validate();
      if (!accionDocumentoBloc.request.hasNonNullField()) {
        isValid = false;
        accionDocumentoBloc.add(const ErrorFormAccionDocumentoEvent("Por favor diligenciar por lo menos un campo del formulario"));
      }
      if (isValid) {
        accionDocumentoBloc.add(GetAccionDocumentoEvent(accionDocumentoBloc.request));
      }
    }

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BuildFormFields(
            children: <Widget>[
              NumberInputTitle(
                title: "Codigo",
                onChanged: (String result) {
                  if (result.isNotEmpty) {
                    accionDocumentoBloc.request.codigo = int.parse(result);
                  } else {
                    accionDocumentoBloc.request.codigo = null;
                  }
                },
              ),
              TextInputTitle(
                title: "Nombre",
                typeInput: TypeInput.lettersAndNumbers,
                onChanged: (String result) {
                  accionDocumentoBloc.request.nombre = result;
                },
              ),
              const FieldTipoDocumento(),
            ],
          ),
          FormButton(label: "Buscar", icon: Icons.search, onPressed: onPressed),
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
  void onRowChecked(List<Map<String, dynamic>> event) {
    listUpdate.clear();
    setState(() => listUpdate.addAll(event));
  }

  void onPressedSave() {
    for (final Map<String, dynamic> map in listUpdate) {
      final AccionDocumentoRequest request = AccionDocumentoRequest.fromMap(map);
      context.read<AccionDocumentoBloc>().add(UpdateAccionDocumentoEvent(request));
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, DataItemGrid> buildPlutoRowData(AccionDocumento accionDocumento, List<String> tiposList) {
      return <String, DataItemGrid>{
        'codigo': DataItemGrid(type: Tipo.item, value: accionDocumento.codigo, edit: false),
        'nombre': DataItemGrid(type: Tipo.text, value: accionDocumento.nombre, edit: true),
        'tipo_documento': DataItemGrid(type: Tipo.select, value: accionDocumento.tipo, edit: true, dataList: tiposList),
        'naturaleza_inversa': DataItemGrid(type: Tipo.boolean, value: accionDocumento.esInverso, edit: true),
        'activo': DataItemGrid(type: Tipo.boolean, value: accionDocumento.esActivo, edit: true),
        'fecha_creacion': DataItemGrid(type: Tipo.date, value: accionDocumento.fechaCreacion, edit: false),
        'fecha_actualizacion': DataItemGrid(type: Tipo.date, value: accionDocumento.fechaActualizacion, edit: false),
        'usuario': DataItemGrid(type: Tipo.text, value: accionDocumento.usuario, edit: false),
      };
    }

    return BlocBuilder<AccionDocumentoBloc, AccionDocumentoState>(
      builder: (BuildContext context, AccionDocumentoState state) {
        if (state is AccionDocumentoConsultedState) {
          final List<String> tiposList = context
              .read<AccionDocumentoBloc>()
              .tipos
              .map((TipoDocumentoAccionDocumento e) => '${e.codigo}-${e.nombre.toUpperCase()}')
              .toList();
          final List<Map<String, DataItemGrid>> plutoRes = <Map<String, DataItemGrid>>[];
          for (final AccionDocumento accionDocumento in state.accionDocumentos) {
            final Map<String, DataItemGrid> rowData = buildPlutoRowData(accionDocumento, tiposList);
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

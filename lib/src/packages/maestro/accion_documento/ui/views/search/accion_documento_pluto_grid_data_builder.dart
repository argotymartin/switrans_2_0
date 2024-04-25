// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/entities/accion_documento.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class AccionDocumentoPlutoGridDataBuilder {
  static List<PlutoColumn> buildColumns(BuildContext context) {
    return [
      PlutoColumn(
        enableEditingMode: false,
        enableAutoEditing: false,
        enableColumnDrag: false,
        enableContextMenu: false,
        applyFormatterInEditing: false,
        enableDropToResize: false,
        enableFilterMenuItem: false,
        title: 'Codigo',
        field: 'codigo',
        type: PlutoColumnType.text(),
        minWidth: 80,
        width: 80,
        renderer: (renderContext) => _BuildFieldItem(renderContext: renderContext),
      ),
      PlutoColumn(
        enableEditingMode: true,
        enableAutoEditing: true,
        title: 'Nombre',
        field: 'nombre',
        type: PlutoColumnType.text(),
        renderer: (renderContext) => _BuildFieldText(renderContext: renderContext),
      ),
      PlutoColumn(
        enableEditingMode: true,
        enableAutoEditing: true,
        title: 'Tipo Documento',
        field: 'tipo_documento',
        type: PlutoColumnType.select(<String>[
          'Programmer',
          'Designer',
          'Owner',
        ]),
        renderer: (renderContext) => _BuildFieldText(renderContext: renderContext),
      ),
      PlutoColumn(
        enableEditingMode: true,
        enableAutoEditing: true,
        title: 'Naturaleza Inversa',
        field: 'naturaleza_inversa',
        type: PlutoColumnType.text(),
        renderer: (renderContext) => _BuildFieldCheckBox(renderContext: renderContext),
      ),
      PlutoColumn(
        minWidth: 188,
        enableEditingMode: false,
        title: 'Fecha Creacion',
        field: 'fecha_creacion',
        type: PlutoColumnType.text(),
        renderer: (renderContext) => _BuildFieldDate(renderContext: renderContext),
      ),
      PlutoColumn(
        minWidth: 188,
        enableEditingMode: false,
        title: 'Fecha Actualizacion',
        field: 'fecha_actualizacion',
        type: PlutoColumnType.text(),
        renderer: (renderContext) => _BuildFieldDate(renderContext: renderContext),
      ),
      PlutoColumn(
        title: 'Activo',
        field: 'activo',
        type: PlutoColumnType.text(),
        renderer: (renderContext) => _BuildFieldCheckBox(renderContext: renderContext),
      ),
      PlutoColumn(
        enableEditingMode: false,
        title: 'Usuario',
        field: 'usuario',
        type: PlutoColumnType.text(),
        renderer: (renderContext) => _BuildFieldText(renderContext: renderContext),
      ),
      PlutoColumn(
        enableRowChecked: true,
        enableEditingMode: false,
        title: 'Guardar Cambios',
        field: 'cambios',
        type: PlutoColumnType.text(),
        renderer: (renderContext) => _BuildFieldText(renderContext: renderContext),
      ),
    ];
  }

  static List<PlutoRow> buildDataRows(List<AccionDocumento> itemsRow, BuildContext context) {
    final List<PlutoRow> dataRows = [];
    itemsRow.asMap().forEach((index, accion) {
      final Map<String, dynamic> dataColumn = {
        'codigo': accion.codigo,
        'nombre': accion.nombre,
        'usuario': accion.usuario,
        'naturaleza_inversa': accion.esInverso,
        'tipo_documento': accion.tipo,
        'fecha_creacion': accion.fechaCreacion,
        'fecha_actualizacion': accion.fechaActualizacion,
        'activo': accion.esActivo,
        'cambios': "",
      };
      final row = TablePlutoGridDataSource.rowByColumns(buildColumns(context), dataColumn);
      dataRows.add(row);
    });
    return dataRows;
  }
}

class _BuildFieldText extends StatelessWidget {
  final PlutoColumnRendererContext renderContext;
  const _BuildFieldText({
    required this.renderContext,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      renderContext.cell.value.toString().toUpperCase(),
      style: const TextStyle(color: Colors.black),
    );
  }
}

class _BuildFieldDate extends StatelessWidget {
  final PlutoColumnRendererContext renderContext;
  const _BuildFieldDate({
    required this.renderContext,
  });

  @override
  Widget build(BuildContext context) {
    final dateValue = renderContext.cell.value.toString().split(" ");
    final fecha = dateValue[0];
    final hora = dateValue[1].split(".")[0];
    return Row(
      children: [
        const Icon(Icons.calendar_month, color: Colors.black54),
        Text(
          fecha,
          style: const TextStyle(color: Colors.black),
        ),
        const SizedBox(width: 4),
        const Icon(Icons.timelapse_rounded, color: Colors.black54),
        Text(
          hora,
          style: const TextStyle(color: Colors.black),
        ),
      ],
    );
  }
}

class _BuildFieldCheckBox extends StatelessWidget {
  final PlutoColumnRendererContext renderContext;
  const _BuildFieldCheckBox({
    required this.renderContext,
  });

  @override
  Widget build(BuildContext context) {
    void onChangedValue(bool newValue) => renderContext.cell.value = newValue;
    return Center(
      child: SwitchBoxInput(onChanged: onChangedValue, value: renderContext.cell.value),
    );
  }
}

class _BuildFieldItem extends StatelessWidget {
  final PlutoColumnRendererContext renderContext;
  const _BuildFieldItem({
    required this.renderContext,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.8,
      child: Chip(
        clipBehavior: Clip.antiAlias,
        backgroundColor: Theme.of(context).colorScheme.primary,
        labelPadding: const EdgeInsets.symmetric(horizontal: 16),
        padding: EdgeInsets.zero,
        shape: const StadiumBorder(),
        side: BorderSide.none,
        elevation: 0,
        label: Text(
          renderContext.cell.value.toString(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

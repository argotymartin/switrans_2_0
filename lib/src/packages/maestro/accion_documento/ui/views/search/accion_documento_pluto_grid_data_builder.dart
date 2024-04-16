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
        title: 'Codigo',
        field: 'codigo',
        type: PlutoColumnType.text(),
        minWidth: 80,
        width: 80,
        renderer: (renderContext) => _BuildFieldItem(renderContext: renderContext),
      ),
      PlutoColumn(
        title: 'Nombre',
        field: 'nombre',
        type: PlutoColumnType.text(),
        renderer: (renderContext) => _BuildFieldText(renderContext: renderContext),
      ),
      PlutoColumn(
        title: 'Tipo Documento',
        field: 'tipo_documento',
        type: PlutoColumnType.text(),
        renderer: (renderContext) => _BuildFieldText(renderContext: renderContext),
      ),
      PlutoColumn(
        title: 'Naturaleza Inversa',
        field: 'naturaleza_inversa',
        type: PlutoColumnType.text(),
        renderer: (renderContext) => _BuildFieldText(renderContext: renderContext),
      ),
      PlutoColumn(
        enableEditingMode: false,
        title: 'Usuario',
        field: 'usuario',
        type: PlutoColumnType.text(),
        renderer: (renderContext) => _BuildFieldText(renderContext: renderContext),
      ),
      PlutoColumn(
        enableEditingMode: false,
        title: 'Fecha Creacion',
        field: 'fecha_creacion',
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

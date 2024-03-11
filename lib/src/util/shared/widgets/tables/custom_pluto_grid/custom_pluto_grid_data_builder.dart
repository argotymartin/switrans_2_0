// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:switrans_2_0/src/modules/maestro/tipo_impuesto/domain/entities/tipo_impuesto.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class CustomPlutoGridDataBuilder {
  static List<PlutoColumn> buildColumns(BuildContext context) {
    return [
      PlutoColumn(
        enableEditingMode: false,
        title: 'Codigo',
        field: 'codigo',
        type: PlutoColumnType.text(),
        minWidth: 40,
        width: 60,
        renderer: (renderContext) => _BuildFieldItem(renderContext: renderContext),
      ),
      PlutoColumn(
        title: 'Nombre',
        field: 'nombre',
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

  static List<PlutoRow> buildDataRows(List<TipoImpuesto> itemsRow, BuildContext context) {
    final List<PlutoRow> dataRows = [];
    itemsRow.asMap().forEach((index, tipoImpuesto) {
      final Map<String, dynamic> dataColumn = {
        'codigo': tipoImpuesto.codigo,
        'nombre': tipoImpuesto.nombre,
        'usuario': tipoImpuesto.usuario,
        'fecha_creacion': tipoImpuesto.fechaCreacion,
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
    return Center(
      child: Text(
        renderContext.cell.value.toString().toUpperCase(),
        style: const TextStyle(color: Colors.black),
      ),
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

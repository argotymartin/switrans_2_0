import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class PlutoGridDataBuilder extends StatefulWidget {
  final List<Map<String, DataItemGrid>> plutoData;
  final Function(List<Map<String, dynamic>> value)? onRowChecked;
  final Function()? onPressedSave;

  const PlutoGridDataBuilder({
    required this.plutoData,
    this.onRowChecked,
    this.onPressedSave,
    super.key,
  });

  @override
  State<PlutoGridDataBuilder> createState() => _PlutoGridDataBuilderState();
}

class _PlutoGridDataBuilderState extends State<PlutoGridDataBuilder> {
  List<Map<String, dynamic>> listValues = <Map<String, dynamic>>[];
  @override
  Widget build(BuildContext context) {
    List<PlutoColumn> buildColumns(BuildContext context) {
      final List<PlutoColumn> columns = <PlutoColumn>[];
      widget.plutoData.first.forEach((String key, DataItemGrid v) {
        final Tipo tipo = v.type;
        final bool isEdit = v.edit;
        final String tilte = key.toUpperCase().replaceAll("_", " ");

        if (tipo == Tipo.item) {
          columns.add(
            PlutoColumn(
              enableEditingMode: false,
              enableColumnDrag: false,
              enableContextMenu: false,
              enableDropToResize: false,
              enableFilterMenuItem: false,
              title: tilte,
              field: key,
              type: PlutoColumnType.text(),
              width: 80,
              renderer: (PlutoColumnRendererContext renderContext) => _BuildFieldItem(renderContext: renderContext),
            ),
          );
        }
        if (tipo == Tipo.text) {
          columns.add(
            PlutoColumn(
              enableEditingMode: isEdit,
              enableAutoEditing: isEdit,
              title: tilte,
              field: key,
              type: PlutoColumnType.text(),
              renderer: (PlutoColumnRendererContext renderContext) =>
                  isEdit ? _BuildFieldTextEdit(renderContext: renderContext, title: tilte) : _BuildFieldText(renderContext: renderContext),
            ),
          );
        }
        if (tipo == Tipo.select) {
          final List<String> data = v.dataList!;
          columns.add(
            PlutoColumn(
              enableEditingMode: isEdit,
              enableAutoEditing: isEdit,
              title: tilte,
              field: key,
              type: PlutoColumnType.select(<String>[...data]),
            ),
          );
        }
        if (tipo == Tipo.boolean) {
          columns.add(
            PlutoColumn(
              enableEditingMode: isEdit,
              title: tilte,
              field: key,
              type: PlutoColumnType.text(),
              renderer: (PlutoColumnRendererContext renderContext) => _BuildFieldCheckBox(renderContext: renderContext),
            ),
          );
        }
        if (tipo == Tipo.date) {
          columns.add(
            PlutoColumn(
              minWidth: 188,
              enableEditingMode: false,
              title: tilte,
              field: key,
              type: PlutoColumnType.text(),
              renderer: (PlutoColumnRendererContext renderContext) => _BuildFieldDate(renderContext: renderContext),
            ),
          );
        }
      });
      columns.add(
        PlutoColumn(
          enableRowChecked: true,
          enableEditingMode: false,
          title: 'Guardar Cambios',
          field: 'cambios',
          type: PlutoColumnType.text(),
          renderer: (PlutoColumnRendererContext renderContext) => _BuildFieldText(renderContext: renderContext),
        ),
      );
      return columns;
    }

    List<PlutoRow> buildDataRows(BuildContext context) {
      final List<PlutoRow> dataRows = <PlutoRow>[];

      widget.plutoData.asMap().forEach((int index, Map<String, DataItemGrid> dato) {
        final Map<String, dynamic> dataColumn = <String, dynamic>{};
        dato.forEach((String key, DataItemGrid value) {
          dataColumn.addEntries(<String, dynamic>{key: value.value}.entries);
        });
        dataColumn.addEntries(<String, String>{'cambios': ''}.entries);
        final PlutoRow row = TablePlutoGridDataSource.rowByColumns(buildColumns(context), dataColumn);
        dataRows.add(row);
      });
      return dataRows;
    }

    final Map<int, Map<String, dynamic>> selectedMap = <int, Map<String, dynamic>>{};
    return Column(
      children: <Widget>[
        CustomPlutoGridTable(
          columns: buildColumns(context),
          rows: buildDataRows(context),
          onRowChecked: (PlutoGridOnRowCheckedEvent event) {
            if (event.row == null || event.rowIdx == null || event.isChecked == null) {
              return;
            }
            if (event.isChecked!) {
              final Map<String, dynamic> mapRow = Map<String, dynamic>.fromEntries(
                event.row!.cells.entries.map(
                  (MapEntry<String, PlutoCell> entry) {
                    if (entry.value.column.type.isSelect) {
                      return MapEntry<String, String>(entry.key, entry.value.value.toString().split("-")[0]);
                    }
                    return MapEntry<String, dynamic>(entry.key, entry.value.value);
                  },
                ),
              );
              selectedMap.addEntries(<int, Map<String, dynamic>>{event.rowIdx!: mapRow}.entries);
            } else {
              selectedMap.remove(event.rowIdx);
            }
            //print(selectedMap);
            setState(() => listValues = selectedMap.values.toList());
            widget.onRowChecked!.call(listValues);
          },
        ),
        BuildButtonFormSave(
          onPressed: widget.onPressedSave!,
          enabled: listValues.isEmpty,
          icon: Icons.save,
          label: "Actualizar",
          cantdiad: listValues.length,
          isConsulted: true,
          isInProgress: false,
          error: "",
        ),
      ],
    );
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

class _BuildFieldTextEdit extends StatefulWidget {
  final PlutoColumnRendererContext renderContext;
  final String title;
  const _BuildFieldTextEdit({
    required this.renderContext,
    required this.title,
  });

  @override
  State<_BuildFieldTextEdit> createState() => _BuildFieldTextEditState();
}

class _BuildFieldTextEditState extends State<_BuildFieldTextEdit> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(text: widget.renderContext.cell.value.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextInputTitle(title: widget.title, controller: controller, typeInput: TypeInput.lettersAndNumbers),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            title: const Text("Editar Campo"),
            actions: <Widget>[
              FilledButton(
                onPressed: () {
                  context.pop();
                  setState(() {
                    widget.renderContext.cell.value = controller.text;
                  });
                },
                child: const Text("OK"),
              ),
            ],
          ),
        );
      },
      child: Text(
        controller.text,
        style: const TextStyle(color: Colors.black),
      ),
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
    final List<String> dateValue = renderContext.cell.value.toString().split(" ");
    final String fecha = dateValue[0];
    final String hora = dateValue[1].split(".")[0];
    return Row(
      children: <Widget>[
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

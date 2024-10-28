import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:switrans_2_0/src/util/resources/compare_json.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/date_input_picker.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_area_input.dart';
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
        final String tilte = v.title;

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
              width: 20,
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
          final double screenWidth = MediaQuery.of(context).size.width;
          final double width = (v.entryMenus != null && v.entryMenus!.isNotEmpty)
              ? screenWidth * 0.35
              : screenWidth * 0.25;
          final double minWidth = (v.entryMenus != null && v.entryMenus!.isNotEmpty)
              ? screenWidth * 0.18
              : screenWidth * 0.12;

          columns.add(
            PlutoColumn(
              title: tilte,
              field: key,
              width: width,
              minWidth: minWidth,
              type: PlutoColumnType.text(),
              renderer: (PlutoColumnRendererContext rendererContext) => _BuildFieldAutoComplete(
                renderContext: rendererContext,
                entryMenus: v.entryMenus!,
              ),
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
              renderer: (PlutoColumnRendererContext renderContext) => _BuildFieldCheckBox(
                renderContext: renderContext,
                editing: isEdit,
              ),
            ),
          );
        }
        if (tipo == Tipo.date) {
          final double screenWidth = MediaQuery.of(context).size.width;
          final bool isSmallScreen = screenWidth < 600;
          columns.add(
            PlutoColumn(
              minWidth: isSmallScreen ? screenWidth * 0.5 : 300,
              enableEditingMode: false,
              title: tilte,
              field: key,
              type: PlutoColumnType.text(),
              renderer: (PlutoColumnRendererContext renderContext) => _BuildFieldDate(
                renderContext: renderContext,
                editing: isEdit,
              ),
            ),
          );
        }
      });

      columns.add(
        PlutoColumn(
          enableRowChecked: true,
          enableEditingMode: false,
          title: 'Guardar',
          field: 'cambios',
          type: PlutoColumnType.text(),
          renderer: (PlutoColumnRendererContext renderContext) => Center(
            child: _BuildFieldText(renderContext: renderContext),
          ),
        ),
      );

      return columns;
    }

    final Map<int, dynamic> dataMap = <int, dynamic>{};
    List<PlutoRow> buildDataRows(BuildContext context) {
      final List<PlutoRow> dataRows = <PlutoRow>[];

      widget.plutoData.asMap().forEach((int index, Map<String, DataItemGrid> dato) {
        final Map<String, dynamic> dataColumn = dato.map((String key, DataItemGrid value) => MapEntry<String, dynamic>(key, value.value));
        final int keyMap = dato.values.first.value;

        dataColumn['cambios'] = '';
        dataMap[keyMap] = Map<String, dynamic>.from(dataColumn);

        final PlutoRow row = TablePlutoGridDataSource.rowByColumns(buildColumns(context), dataColumn);
        dataRows.add(row);
      });
      return dataRows;
    }

    return Column(
      children: <Widget>[
        CustomPlutoGridTable(
          columns: buildColumns(context),
          rows: buildDataRows(context),
          onRowChecked: (PlutoGridOnRowCheckedEvent event) {
            if (event.row == null || event.rowIdx == null || event.isChecked == null) {
              return;
            }

            final PlutoRow row = event.row!;
            final bool isChecked = event.isChecked!;

            final int key = row.cells.values.first.value;
            final Map<String, dynamic> mapRow = row.cells.map((String cellKey, PlutoCell cell) {
              return MapEntry<String, dynamic>(cellKey, cell.value);
            });

            setState(() {
              if (isChecked) {
                final Map<String, dynamic> mapDiff = compareJson(dataMap[key], mapRow);
                listValues.add(<String, dynamic>{'id': key, 'data': mapDiff});
              } else {
                listValues.removeWhere((Map<String, dynamic> element) => element['id'] == key);
              }
            });

            if (listValues.isNotEmpty) {
              widget.onRowChecked?.call(listValues);
            }
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
    return Text(renderContext.cell.value.toString().toUpperCase());
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
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: SingleChildScrollView(
              child: SizedBox(
                child: TextAreaInput(
                  hintText: widget.title,
                  controller: controller,
                  typeInput: TypeInput.lettersAndNumbers,
                  autofocus: true,
                ),
              ),
            ),
            actions: <Widget>[
              FilledButton(
                onPressed: () {
                  context.pop();
                  setState(() {
                    widget.renderContext.cell.value = controller.text.toUpperCase();
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
      ),
    );
  }
}

class _BuildFieldDate extends StatelessWidget {
  final PlutoColumnRendererContext renderContext;
  final bool editing;
  const _BuildFieldDate({
    required this.renderContext,
    required this.editing,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> dateValue = renderContext.cell.value.toString().split(" ");
    final String fecha = dateValue[0];
    final String hora = dateValue.length > 1 ? dateValue[1].split(".")[0] : "";
    final Color color = Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.6);
    return editing
        ? DateInputPicker(
            onDateSelected: (String value) => renderContext.cell.value = value,
            dateInitialValue: renderContext.cell.value.toString(),
          )
        : Row(
            children: <Widget>[
              Icon(Icons.calendar_month, color: color),
              Text(
                fecha,
              ),
              hora.isEmpty ? Container() : const SizedBox(width: 4),
              hora.isEmpty ? Container() : Icon(Icons.timelapse_rounded, color: color),
              hora.isEmpty
                  ? Container()
                  : Text(
                      hora,
                    ),
            ],
          );
  }
}

class _BuildFieldCheckBox extends StatelessWidget {
  final PlutoColumnRendererContext renderContext;
  final bool editing;
  const _BuildFieldCheckBox({
    required this.renderContext,
    required this.editing,
  });

  @override
  Widget build(BuildContext context) {
    void onChangedValue(bool newValue) => renderContext.cell.value = newValue;
    return Center(
      child: SwitchBoxInput(onChanged: editing ? onChangedValue : null, value: renderContext.cell.value),
    );
  }
}

class _BuildFieldAutoComplete extends StatelessWidget {
  final PlutoColumnRendererContext renderContext;
  final List<EntryAutocomplete> entryMenus;
  const _BuildFieldAutoComplete({
    required this.renderContext,
    required this.entryMenus,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AutocompleteInput(
        entryCodigoSelected: renderContext.cell.value,
        entries: entryMenus,
        onPressed: (EntryAutocomplete result) {
          renderContext.cell.value = result.codigo;
        },
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
        clipBehavior: Clip.antiAlias,
        backgroundColor: Theme.of(context).canvasColor,
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

String toCapitalCase(String text) {
  return text
      .split(' ')
      .map(
        (String word) => word.isNotEmpty
            ? word[0].toUpperCase() + word.substring(1).toLowerCase() //
            : '',
      )
      .join(' ');
}

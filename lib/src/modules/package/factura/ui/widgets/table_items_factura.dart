// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/entities/factuta_entities.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/widgets_shared.dart';

class TableItemsFactura extends StatelessWidget {
  final List<Remesa> remesas;
  const TableItemsFactura({
    super.key,
    required this.remesas,
  });

  @override
  Widget build(BuildContext context) {
    final tableRowsTitle = TableRow(
      decoration: BoxDecoration(color: Colors.grey.shade100),
      children: const [
        _CellTitle(title: "Item"),
        _CellTitle(title: "Documento"),
        _CellTitle(title: "Descripcion"),
        _CellTitle(title: "Valor"),
        _CellTitle(title: "Cantidad"),
        _CellTitle(title: "Total"),
        _CellTitle(title: "Accion"),
      ],
    );
    List<TableRow> buildTableRows = remesas.map(
      (remesa) {
        final valorController = TextEditingController(text: remesa.tarifaBase);
        final cantidadController = TextEditingController(text: '0');
        return TableRow(
          children: [
            const _BuildFieldItem(),
            _CellContent(child: _BuildFiledDocumento(remesas: remesas)),
            _CellContent(child: _BuildFieldDescription(title: remesa.obervaciones)),
            _CellContent(child: CurrencyInput(controller: valorController, color: Colors.blue.shade800)),
            _CellContent(child: NumberInput(colorText: Colors.blue.shade700, controller: cantidadController)),
            _CellContent(child: CurrencyLabel(color: Colors.green.shade900, text: remesa.rcp)),
            const _CellContent(child: _BuildFiledAccion()),
          ],
        );
      },
    ).toList();

    const columnWidth = {
      0: FlexColumnWidth(0.6),
      1: FractionColumnWidth(0.2),
      2: FractionColumnWidth(0.25),
      3: FractionColumnWidth(0.15),
      6: FractionColumnWidth(0.15),
    };
    return Table(
      border: TableBorder.all(color: Colors.grey.shade200, width: 1),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: columnWidth,
      children: [tableRowsTitle, ...buildTableRows],
    );
  }
}

class _BuildFieldItem extends StatelessWidget {
  const _BuildFieldItem();

  @override
  Widget build(BuildContext context) {
    return _CellContent(
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).colorScheme.primary,
          ),
          child: const Center(
            child: Text(
              "1",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class _BuildFiledAccion extends StatelessWidget {
  const _BuildFiledAccion();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomSizeButton(
          width: 32,
          icon: Icons.remove_circle_outline,
          color: Colors.red.shade800,
          iconColor: Colors.white,
        ),
        const SizedBox(width: 4),
        const CustomSizeButton(width: 32, icon: Icons.refresh_outlined),
      ],
    );
  }
}

class _BuildFieldDescription extends StatelessWidget {
  final String title;
  const _BuildFieldDescription({required this.title});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: title,
      autovalidateMode: AutovalidateMode.always,
      minLines: 4,
      style: const TextStyle(fontSize: 10),
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration: const InputDecoration(
        alignLabelWithHint: true,
        border: OutlineInputBorder(),
      ),
    );
  }
}

class _BuildFiledDocumento extends StatelessWidget {
  final List<Remesa> remesas;

  const _BuildFiledDocumento({required this.remesas});

  @override
  Widget build(BuildContext context) {
    final documentoController = TextEditingController();

    final suggestions = remesas.map((remesa) {
      return SuggestionModel(
        title: remesa.remesa.split("(")[1].replaceAll(")", ""),
        subTitle: remesa.remesa.split("(")[0].replaceAll(")", ""),
        details: Row(children: [const Icon(Icons.monetization_on_outlined), Text(remesa.centroCosto)]),
      );
    }).toList();
    return SizedBox(
      child: AutocompleteInput(
        title: "Documento",
        suggestions: suggestions,
        controller: documentoController,
      ),
    );
  }
}

class _CellTitle extends StatelessWidget {
  final String title;
  const _CellTitle({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Container(
          width: 4,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )),
    );
  }
}

class _CellContent extends StatelessWidget {
  final Widget child;
  const _CellContent({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: child,
      ),
    );
  }
}

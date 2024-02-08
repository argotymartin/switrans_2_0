import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/entities/factuta_entities.dart';
import 'package:switrans_2_0/src/modules/package/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/modules/package/factura/ui/widgets/radio_buttons.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/widgets_shared.dart';

class TableItemsFactura extends StatelessWidget {
  final List<Documento> remesas;
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
    int index = 0;
    List<TableRow> buildTableRows = remesas.map(
      (remesa) {
        final valorController = TextEditingController(text: '${remesa.total}');
        final cantidadController = TextEditingController(text: '0');
        index++;
        return TableRow(
          children: [
            _BuildFieldItem(index),
            _CellContent(child: _BuildFiledDocumento(documento: remesa)),
            _CellContent(child: _BuildFieldDescription(title: remesa.observacion)),
            _CellContent(child: CurrencyInput(controller: valorController, color: Colors.blue.shade800)),
            _CellContent(child: NumberInput(colorText: Colors.blue.shade700, controller: cantidadController)),
            _CellContent(child: CurrencyLabel(color: Colors.green.shade900, text: '${remesa.rcp}')),
            _CellContent(child: _BuildFiledAccion(onPressed: () {
              context.read<ItemFacturaBloc>().add(RemoveItemFacturaEvent(documento: remesa));
            })),
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
  final int index;
  const _BuildFieldItem(this.index);

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
          child: Center(
            child: Text(
              index.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class _BuildFiledDocumento extends StatelessWidget {
  final Documento documento;

  const _BuildFiledDocumento({required this.documento});

  @override
  Widget build(BuildContext context) {
    final documentosAll = context.read<FacturaBloc>().state.documentos;
    final documentoController = TextEditingController(text: documento.toString());
    final suggestionSeleted = SuggestionModel(title: documento.remesa.toString(), subTitle: "");
    final suggestions = documentosAll.map((remesa) {
      return SuggestionModel(
        title: '${remesa.remesa}',
        subTitle: '(${remesa.impreso})',
        details: Row(children: [const Icon(Icons.monetization_on_outlined), Text(remesa.cencosNombre)]),
      );
    }).toList();
    return Column(
      children: [
        AutocompleteInput(
          title: "Documento",
          suggestions: suggestions,
          controller: documentoController,
          suggestionSelected: suggestionSeleted,
        ),

        const RadioButtons(onSelected: true),

        //
      ],
    );
  }
}

class _BuildFiledAccion extends StatelessWidget {
  final VoidCallback onPressed;
  const _BuildFiledAccion({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomSizeButton(
          onPressed: onPressed,
          width: 32,
          icon: Icons.remove_circle_outline,
          color: Colors.red.shade800,
          iconColor: Colors.white,
        ),
        const SizedBox(width: 4),
        CustomSizeButton(width: 32, icon: Icons.refresh_outlined, onPressed: onPressed),
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
      minLines: 2,
      style: const TextStyle(fontSize: 8.5),
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration: const InputDecoration(
        alignLabelWithHint: true,
        border: OutlineInputBorder(),
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
        ),
      ),
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

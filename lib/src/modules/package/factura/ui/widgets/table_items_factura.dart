import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/entities/pre_factura.dart';
import 'package:switrans_2_0/src/modules/package/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/modules/package/factura/ui/widgets/radio_buttons.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/widgets_shared.dart';
import 'package:switrans_2_0/src/util/resources/custom_functions.dart';
import 'package:switrans_2_0/src/util/resources/formatters/upper_case_formatter.dart';

class TableItemsFactura extends StatelessWidget {
  final List<PreFactura> prefacturas;
  const TableItemsFactura({
    super.key,
    required this.prefacturas,
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
        _CellTitle(title: "IVA %"),
        _CellTitle(title: "IVA Valor"),
        _CellTitle(title: "Cantidad"),
        _CellTitle(title: "Total"),
        _CellTitle(title: "Accion"),
      ],
    );
    int index = 0;
    List<TableRow> buildTableRows = prefacturas.map(
      (prefactura) {
        final valorController = TextEditingController(text: '${prefactura.valor}');
        final cantidadController = TextEditingController(text: '1');
        index++;
        return TableRow(
          children: [
            _BuildFieldItem(index),
            _CellContent(child: _BuildFiledDocumento(preFactura: prefactura)),
            _CellContent(child: _BuildFieldDescription(title: prefactura.descripcion)),
            _CellContent(child: _BuildValor(valorController: valorController)),
            const _CellContent(child: _BuildPorcentajeIva()),
            const _CellContent(child: _BuildValorIva()),
            _CellContent(child: _BuildCantidad(cantidadController: cantidadController)),
            const _CellContent(child: _BuildTotal()),
            _CellContent(
              child: _BuildFiledAccion(
                onPressed: () {
                  context.read<ItemFacturaBloc>().add(RemoveItemByPositionFacturaEvent(index: index - 1));
                },
              ),
            ),
          ],
        );
      },
    ).toList();

    const columnWidth = {
      0: FlexColumnWidth(0.6),
      1: FractionColumnWidth(0.15),
      2: FractionColumnWidth(0.30),
      3: FractionColumnWidth(0.1),
      6: FractionColumnWidth(0.08),
    };
    return Table(
      border: TableBorder.all(color: Colors.grey.shade200, width: 1),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: columnWidth,
      children: [tableRowsTitle, ...buildTableRows],
    );
  }
}

class _BuildTotal extends StatelessWidget {
  const _BuildTotal();

  @override
  Widget build(BuildContext context) {
    return CurrencyLabel(color: Colors.green.shade900, text: "200");
  }
}

class _BuildCantidad extends StatelessWidget {
  const _BuildCantidad({
    required this.cantidadController,
  });

  final TextEditingController cantidadController;

  @override
  Widget build(BuildContext context) {
    return NumberInput(colorText: Colors.blue.shade700, controller: cantidadController);
  }
}

class _BuildValorIva extends StatelessWidget {
  const _BuildValorIva();

  @override
  Widget build(BuildContext context) {
    return CurrencyLabel(color: Colors.green.shade900, text: "200");
  }
}

class _BuildPorcentajeIva extends StatelessWidget {
  const _BuildPorcentajeIva();

  @override
  Widget build(BuildContext context) {
    return Text(
      "19%",
      style: TextStyle(color: Colors.green.shade900),
    );
  }
}

class _BuildValor extends StatelessWidget {
  const _BuildValor({
    required this.valorController,
  });

  final TextEditingController valorController;

  @override
  Widget build(BuildContext context) {
    return CurrencyInput(controller: valorController, color: Colors.blue.shade800);
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
  final PreFactura preFactura;

  const _BuildFiledDocumento({required this.preFactura});

  @override
  Widget build(BuildContext context) {
    final documentosAll = context.read<FacturaBloc>().state.documentos;
    final documentoController = TextEditingController(text: preFactura.toString());
    final suggestionSeleted = preFactura.documento > 0 ? SuggestionModel(title: preFactura.documento.toString(), subTitle: "") : null;
    final suggestions = documentosAll.map((remesa) {
      return SuggestionModel(
        codigo: '${remesa.remesa}',
        title: '${remesa.remesa}',
        subTitle: '(${remesa.impreso})',
        details: Row(children: [const Icon(Icons.monetization_on_outlined), Text(remesa.cencosNombre)]),
      );
    }).toList();

    void setValueFactura(String value) {
      if (value.isNotEmpty) {
        preFactura.documento = int.parse(value);
      }
    }

    return Column(
      children: [
        AutocompleteInput(
          isShowCodigo: false,
          title: "Documento",
          suggestions: suggestions,
          controller: documentoController,
          suggestionSelected: suggestionSeleted,
          onPressed: setValueFactura,
        ),
        RadioButtons(tipo: preFactura.tipo),
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
      inputFormatters: [UpperCaseFormatter()],
      initialValue: CustomFunctions.limpiarTexto(title),
      autovalidateMode: AutovalidateMode.always,
      maxLines: 7,
      minLines: 5,
      textAlign: TextAlign.justify,
      style: const TextStyle(fontSize: 10),
      keyboardType: TextInputType.multiline,
      decoration: const InputDecoration(
        alignLabelWithHint: true,
        border: OutlineInputBorder(),
      ),
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

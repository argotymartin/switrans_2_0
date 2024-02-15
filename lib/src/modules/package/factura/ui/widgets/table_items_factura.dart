import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/entities/factuta_entities.dart';
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
        index++;
        return TableRow(
          children: [
            _CellContent(child: _BuildFieldItem(index)),
            _CellContent(child: _BuildFiledDocumento(preFactura: prefactura)),
            _CellContent(child: _BuildFieldDescription(title: prefactura.descripcion)),
            _CellContent(child: _BuildValor(preFactura: prefactura)),
            _CellContent(child: _BuildPorcentajeIva(prefactura.porcentajeIva)),
            _CellContent(child: _BuildValorIva(valorIva: prefactura.valorIva)),
            _CellContent(child: _BuildCantidad(preFactura: prefactura)),
            _CellContent(child: _BuildTotal(total: prefactura.total)),
            _CellContent(child: _BuildFiledAccion(index: index - 1)),
          ],
        );
      },
    ).toList();

    const columnWidth = {
      0: FractionColumnWidth(0.04),
      1: FractionColumnWidth(0.18),
      2: FractionColumnWidth(0.3),
      3: FractionColumnWidth(0.1),
      4: FractionColumnWidth(0.05),
      5: FractionColumnWidth(0.08),
      6: FractionColumnWidth(0.06),
      7: FractionColumnWidth(0.1),
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
    return Center(
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
    );
  }
}

class _BuildFiledDocumento extends StatelessWidget {
  final PreFactura preFactura;

  const _BuildFiledDocumento({required this.preFactura});

  @override
  Widget build(BuildContext context) {
    final documentosAll = context.read<FacturaBloc>().state.documentos;
    final suggestionSeleted = preFactura.documento > 0 ? SuggestionModel(title: preFactura.documento.toString(), subTitle: "") : null;
    final suggestions = documentosAll.map((remesa) {
      return SuggestionModel(
        codigo: '${remesa.remesa}',
        title: '${remesa.remesa}',
        subTitle: '(${remesa.impreso})',
        details: Row(children: [const Icon(Icons.monetization_on_outlined), Text(remesa.cencosNombre)]),
      );
    }).toList();

    void setValueFactura(String value) async {
      if (value.isNotEmpty && preFactura.documento == 0) {
        final Documento documento = documentosAll.firstWhere((element) => element.remesa == int.parse(value));
        preFactura.documento = documento.remesa;
        preFactura.documentoImpreso = documento.impreso;
        context.read<ItemFacturaBloc>().add(ChangedItemFacturaEvent(preFactura: preFactura));
      }
    }

    return Column(
      children: [
        suggestionSeleted != null
            ? AutocompleteInput(
                isShowCodigo: false,
                title: "Documento",
                suggestions: const [],
                suggestionSelected: suggestionSeleted,
              )
            : AutocompleteInput(
                isShowCodigo: false,
                title: "Documento",
                suggestions: suggestions,
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

class _BuildValor extends StatelessWidget {
  const _BuildValor({
    required this.preFactura,
  });

  final PreFactura preFactura;

  @override
  Widget build(BuildContext context) {
    void onChaneged(String value) {
      String cadenaSinSigno = value.replaceAll(RegExp(r'[\$,]'), '');
      String textValue = cadenaSinSigno == "" ? "0" : cadenaSinSigno;
      double intValue = double.parse(textValue);
      double newValorIva = intValue * preFactura.porcentajeIva / 100;

      preFactura.valor = intValue;
      preFactura.valorIva = newValorIva;
      preFactura.total = (preFactura.valor + preFactura.valorIva) * preFactura.cantidad;
      context.read<ItemFacturaBloc>().add(ChangedItemFacturaEvent(preFactura: preFactura));
    }

    return CurrencyInput(
      color: Colors.blue.shade800,
      onChanged: onChaneged,
    );
  }
}

class _BuildPorcentajeIva extends StatelessWidget {
  final int valor;
  const _BuildPorcentajeIva(this.valor);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$valor%",
      style: TextStyle(color: Colors.green.shade900, fontWeight: FontWeight.w400, fontSize: 16),
    );
  }
}

class _BuildValorIva extends StatelessWidget {
  final double valorIva;
  const _BuildValorIva({required this.valorIva});

  @override
  Widget build(BuildContext context) {
    return CurrencyLabel(color: Colors.green.shade900, text: '${valorIva.toInt()}');
  }
}

class _BuildCantidad extends StatelessWidget {
  final PreFactura preFactura;
  const _BuildCantidad({
    required this.preFactura,
  });

  @override
  Widget build(BuildContext context) {
    void onChanged(String value) {
      String cadenaSinSigno = value.replaceAll(RegExp(r'[\$,]'), '');
      String textValue = cadenaSinSigno == "" ? "1" : cadenaSinSigno;
      int intValue = int.parse(textValue);
      preFactura.cantidad = intValue;
      preFactura.total = (preFactura.valor + preFactura.valorIva) * preFactura.cantidad;
      context.read<ItemFacturaBloc>().add(ChangedItemFacturaEvent(preFactura: preFactura));
    }

    return NumberInput(colorText: Colors.blue.shade700, onChanged: onChanged);
  }
}

class _BuildTotal extends StatelessWidget {
  final double total;
  const _BuildTotal({required this.total});

  @override
  Widget build(BuildContext context) {
    return CurrencyLabel(color: Colors.green.shade900, text: '${total.toInt()}');
  }
}

class _BuildFiledAccion extends StatelessWidget {
  final int index;
  const _BuildFiledAccion({required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomSizeButton(
          onPressed: () {
            context.read<ItemFacturaBloc>().add(RemoveItemByPositionFacturaEvent(index: index));
          },
          width: 32,
          icon: Icons.remove_circle_outline,
          color: Colors.red.shade800,
          iconColor: Colors.white,
        ),
        const SizedBox(width: 4),
        CustomSizeButton(width: 32, icon: Icons.refresh_outlined, onPressed: () {}),
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

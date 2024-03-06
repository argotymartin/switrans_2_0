import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/modules/financiero/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/modules/financiero/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/modules/financiero/factura/ui/views/create/widgets/radio_buttons.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';
import 'package:switrans_2_0/src/util/resources/custom_functions.dart';
import 'package:switrans_2_0/src/util/resources/formatters/upper_case_formatter.dart';

class TableItemsDocumento extends StatelessWidget {
  const TableItemsDocumento({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemDocumentoBloc, ItemDocumentoState>(
      builder: (context, state) {
        final tableRowsTitle = TableRow(
          decoration: BoxDecoration(color: Theme.of(context).colorScheme.primaryContainer),
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
        List<TableRow> buildTableRows = state.itemDocumentos.map(
          (itemDocumento) {
            index++;
            return TableRow(
              children: [
                _CellContent(child: _BuildFieldItem(index)),
                _CellContent(child: _BuildFiledDocumento(item: itemDocumento)),
                _CellContent(child: _BuildFieldDescription(item: itemDocumento)),
                _CellContent(child: _BuildValor(item: itemDocumento)),
                _CellContent(child: _BuildPorcentajeIva(itemDocumento.porcentajeIva)),
                _CellContent(child: _BuildValorIva(valorIva: itemDocumento.valorIva)),
                _CellContent(child: _BuildCantidad(item: itemDocumento)),
                _CellContent(child: _BuildTotal(total: itemDocumento.total)),
                _CellContent(child: _BuildFiledAccion(index: index)),
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
      },
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

class _BuildFiledDocumento extends StatefulWidget {
  final ItemDocumento item;

  const _BuildFiledDocumento({required this.item});

  @override
  State<_BuildFiledDocumento> createState() => _BuildFiledDocumentoState();
}

class _BuildFiledDocumentoState extends State<_BuildFiledDocumento> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final documentosAll = context.read<DocumentoBloc>().state.documentos;

    final List<EntryAutocomplete> entriesDocumentos = documentosAll.map((documento) {
      return EntryAutocomplete(
        title: '${documento.remesa}',
        subTitle: '(${documento.impreso})',
        codigo: documento.remesa,
        details: Row(children: [const Icon(Icons.monetization_on_outlined), Text(documento.cencosNombre)]),
      );
    }).toList();
    entriesDocumentos.add(EntryAutocomplete(
      title: '0',
      subTitle: '( Sin documento )',
      codigo: 0,
    ));
    final String entrySelected = widget.item.documento > 0 ? widget.item.documento.toString() : '';
    void setValueFactura(EntryAutocomplete value) {
      if (value.codigo != 0) {
        setState(() {
          final Documento documento = documentosAll.firstWhere((element) => element.remesa == value.codigo);
          widget.item.documento = documento.remesa;
          widget.item.documentoImpreso = documento.impreso;
          widget.item.descripcion = documento.observacionFactura.isNotEmpty ? documento.observacionFactura : documento.observacionFactura;
          context.read<ItemDocumentoBloc>().add(ChangedItemDocumentoEvent(itemDocumento: widget.item));
        });
      } else {
        setState(() {
          widget.item.tipo == "SA";
          context.read<ItemDocumentoBloc>().add(ChangedItemDocumentoEvent(itemDocumento: widget.item));
        });
      }
    }

    return Column(
      children: [
        Autocomplete2Input(
          entrySelected: entrySelected,
          enabled: widget.item.tipo != "TR",
          controller: _controller,
          isShowCodigo: false,
          label: "",
          entries: entriesDocumentos,
          onPressed: setValueFactura,
        ),
        RadioButtons(tipo: widget.item.tipo),
      ],
    );
  }
}

class _BuildFieldDescription extends StatelessWidget {
  final ItemDocumento item;
  const _BuildFieldDescription({required this.item});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        item.descripcion = value;
      },
      inputFormatters: [UpperCaseFormatter()],
      initialValue: CustomFunctions.limpiarTexto(item.descripcion),
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
  final ItemDocumento item;
  const _BuildValor({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    void onChaneged(String value) {
      String cadenaSinSigno = value.replaceAll(RegExp(r'[\$,]'), '');
      String textValue = cadenaSinSigno == "" ? "0" : cadenaSinSigno;
      double intValue = double.parse(textValue);
      double newValorIva = intValue * item.porcentajeIva / 100;

      item.valor = intValue;
      item.valorIva = newValorIva;
      item.total = (item.valor + item.valorIva) * item.cantidad;
      context.read<ItemDocumentoBloc>().add(ChangedItemDocumentoEvent(itemDocumento: item));
    }

    return CurrencyInput(
      color: Colors.blue.shade800,
      onChanged: onChaneged,
      initialValue: item.valor.toInt().toString(),
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
  final ItemDocumento item;
  const _BuildCantidad({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    void onChanged(String value) {
      String cadenaSinSigno = value.replaceAll(RegExp(r'[\$,]'), '');
      String textValue = cadenaSinSigno == "" ? "1" : cadenaSinSigno;
      int intValue = int.parse(textValue);
      item.cantidad = intValue;
      item.total = (item.valor + item.valorIva) * item.cantidad;
      context.read<ItemDocumentoBloc>().add(ChangedItemDocumentoEvent(itemDocumento: item));
    }

    return NumberInput(colorText: Colors.blue.shade700, onChanged: onChanged, initialValue: item.cantidad.toString());
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
            context.read<ItemDocumentoBloc>().add(RemoveItemByPositionFacturaEvent(index: index));
          },
          width: 32,
          icon: Icons.delete_outlined,
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
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimaryContainer),
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

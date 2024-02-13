import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:switrans_2_0/src/util/resources/formatters/currency_formatter.dart';

class CurrencyInput extends StatelessWidget {
  final TextEditingController controller;
  final Color color;
  const CurrencyInput({super.key, required this.controller, required this.color});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.simpleCurrency(decimalDigits: 0);
    controller.text = currencyFormat.format(int.parse(controller.text));

    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primaryContainer,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
        CurrencyFormatter(currencyFormat),
      ],
      style: TextStyle(color: color, fontWeight: FontWeight.w400, fontSize: 16),
    );
  }
}

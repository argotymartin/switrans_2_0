import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:switrans_2_0/src/util/resources/formatters/currency_formatter.dart';

class CurrencyInput extends StatelessWidget {
  final TextEditingController? controller;
  final Color color;
  final Function(String result)? onChanged;
  const CurrencyInput({super.key, this.controller, required this.color, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.simpleCurrency(decimalDigits: 0);
    if (controller != null) {
      controller!.text = currencyFormat.format(int.parse(controller!.text));
    }

    return TextFormField(
      controller: controller,
      initialValue: "\$0",
      onChanged: (value) {
        if (onChanged != null) onChanged?.call(value);
      },
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

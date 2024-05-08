import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyLabel extends StatelessWidget {
  final Color color;
  final String text;
  final double fontSize;
  const CurrencyLabel({
    required this.color,
    required this.text,
    this.fontSize = 16.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final NumberFormat formatCurrency = NumberFormat.simpleCurrency(decimalDigits: 0);
    return Text(
      formatCurrency.format(int.parse(text)),
      style: TextStyle(color: color, fontWeight: FontWeight.w400, fontSize: fontSize),
    );
  }
}

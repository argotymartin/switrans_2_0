import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyLabel extends StatelessWidget {
  final Color color;
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  const CurrencyLabel({
    required this.color,
    required this.text,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.w400,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final NumberFormat formatCurrency = NumberFormat.simpleCurrency(decimalDigits: 0);
    return Container(
      alignment: Alignment.centerRight,
      child: Text(
        textAlign: TextAlign.right,
        formatCurrency.format(int.parse(text)),
        style: TextStyle(color: color, fontWeight: fontWeight, fontSize: fontSize),
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyLabel extends StatelessWidget {
  final Color color;
  final String text;
  const CurrencyLabel({
    super.key,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.simpleCurrency(decimalDigits: 0);
    return Text(
      formatCurrency.format(int.parse(text)),
      style: TextStyle(color: color, fontWeight: FontWeight.w400, fontSize: 16),
    );
  }
}

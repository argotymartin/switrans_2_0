import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class NumberInputForm extends StatefulWidget {
  final String title;
  final int? value;
  final int minLength;
  final TextEditingController? controller;
  final Function(String result) onChanged;
  final bool isValidator;
  final bool autofocus;

  const NumberInputForm({
    required this.value,
    required this.title,
    required this.onChanged,
    super.key,
    this.controller,
    this.minLength = 1,
    this.isValidator = false,
    this.autofocus = false,
  });

  @override
  State<NumberInputForm> createState() => _NumberInputFormState();
}

class _NumberInputFormState extends State<NumberInputForm> {
  double higth = 38;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        widget.title.isNotEmpty ? Text(widget.title, style: AppTheme.titleStyle) : const SizedBox(),
        widget.title.isNotEmpty ? const SizedBox(height: 8) : const SizedBox(),
        SizedBox(
          height: higth,
          child: NumberInput(
            initialValue: widget.value != null ? "${widget.value}" : "",
            colorText: Colors.black,
            title: widget.title,
            controller: widget.controller,
            onChanged: widget.onChanged,
            autofocus: widget.autofocus,
          ),
        ),
      ],
    );
  }

  String? onValidator(String? value) {
    if (value != null) {
      if (value.length < widget.minLength) {
        higth = higth + 24;
        setState(() {});
        return "El campo debe ser minimo de ${widget.minLength} caracteres";
      }
    }
    return null;
  }
}

import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class NumberInputTitle extends StatefulWidget {
  final String initialValue;
  final String title;
  final int minLength;
  final TextEditingController? controller;
  final Function(String result)? onChanged;
  final bool isValidator;

  const NumberInputTitle({
    super.key,
    this.controller,
    this.onChanged,
    this.initialValue = "",
    this.title = "",
    this.minLength = 1,
    this.isValidator = false,
  });

  @override
  State<NumberInputTitle> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<NumberInputTitle> {
  double higth = 38;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.title.isNotEmpty ? Text(widget.title, style: AppTheme.titleStyle) : const SizedBox(),
        widget.title.isNotEmpty ? const SizedBox(height: 8) : const SizedBox(),
        SizedBox(
          height: higth,
          child: NumberInput(
            colorText: Colors.black,
            title: widget.title,
            controller: widget.controller,
            onChanged: widget.onChanged,
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

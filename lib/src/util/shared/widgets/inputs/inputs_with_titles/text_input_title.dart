import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';

class TextInputTitle extends StatefulWidget {
  final String initialValue;
  final String title;
  final int minLength;
  final TextEditingController? controller;
  final Function(String result)? onChanged;
  final TypeInput typeInput;
  final bool isFormValid;
  final bool autofocus;

  const TextInputTitle({
    required this.title,
    required this.typeInput,
    this.controller,
    this.onChanged,
    this.initialValue = "",
    this.minLength = 0,
    this.isFormValid = true,
    this.autofocus = false,
    super.key,
  });

  @override
  State<TextInputTitle> createState() => _TextInputTitleState();
}

class _TextInputTitleState extends State<TextInputTitle> {
  String validator = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(widget.title, style: AppTheme.titleStyle),
        const SizedBox(height: 8),
        TextInput(
          typeInput: widget.typeInput,
          controller: widget.controller,
          initialValue: widget.initialValue,
          minLength: widget.minLength,
          onChanged: widget.onChanged,
          hintText: widget.title,
          autofocus: widget.autofocus,
        ),
      ],
    );
  }
}

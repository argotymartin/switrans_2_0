import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';

class TextInputForm extends StatefulWidget {
  final String title;
  final String? value;
  final int minLength;
  final int? maxLength;
  final IconData? icon;
  final TextEditingController? controller;
  final Function(String result)? onChanged;
  final TypeInput typeInput;
  final bool isFormValid;
  final bool autofocus;

  const TextInputForm({
    required this.title,
    required this.typeInput,
    required this.value,
    this.controller,
    this.onChanged,
    this.minLength = 0,
    this.isFormValid = true,
    this.autofocus = false,
    this.maxLength,
    this.icon,
    super.key,
  });

  @override
  State<TextInputForm> createState() => _TextInputFormState();
}

class _TextInputFormState extends State<TextInputForm> {
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
          initialValue: widget.value != null ? widget.value! : "",
          minLength: widget.minLength,
          maxLength: widget.maxLength,
          icon: widget.icon,
          onChanged: widget.onChanged,
          hintText: widget.title,
          autofocus: widget.autofocus,
        ),
      ],
    );
  }
}

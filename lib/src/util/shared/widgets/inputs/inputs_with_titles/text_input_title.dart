import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';

class TextInputTitle extends StatefulWidget {
  final String initialValue;
  final String title;
  final int minLength;
  final TextEditingController? controller;
  final Function(String result)? onChanged;

  const TextInputTitle({
    super.key,
    this.controller,
    this.onChanged,
    this.initialValue = "",
    this.title = "",
    this.minLength = 3,
  });

  @override
  State<TextInputTitle> createState() => _TextInputTitleState();
}

class _TextInputTitleState extends State<TextInputTitle> {
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
            child: TextInput(
              controller: widget.controller,
              initialValue: widget.initialValue,
              minLength: widget.minLength,
              onChanged: widget.onChanged,
              title: widget.title,
            )),
      ],
    );
  }
}

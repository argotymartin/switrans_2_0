import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final String initialValue;
  final String title;
  final int minLength;
  final TextEditingController? controller;
  final Function(String result)? onChanged;

  const TextInput({
    super.key,
    this.controller,
    this.onChanged,
    this.initialValue = "",
    this.title = "",
    this.minLength = 3,
  });

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      initialValue: widget.initialValue.isNotEmpty ? widget.initialValue : null,
      onChanged: widget.onChanged,
      validator: (value) {
        if (value != null) {
          if (value.length < widget.minLength) {
            setState(() {});
            return "El campo debe ser minimo de ${widget.minLength} caracteres";
          }
        }
        return null;
      },
      decoration: InputDecoration(
          errorMaxLines: 1,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          constraints: const BoxConstraints(maxHeight: 24, minHeight: 12),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            gapPadding: 100,
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
              width: 2,
            ),
          ),
          prefixIcon: const Icon(Icons.abc),
          hintText: widget.title.isNotEmpty ? "Ingrese el ${widget.title}" : "",
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
              width: 2,
            ),
          )),
      keyboardType: TextInputType.text,
      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 12),
    );
  }
}

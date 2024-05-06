import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberInput extends StatelessWidget {
  final Color colorText;
  final String initialValue;
  final String title;
  final TextEditingController? controller;
  final Function(String result)? onChanged;

  const NumberInput({
    required this.colorText,
    required this.title,
    this.controller,
    this.onChanged,
    this.initialValue = '',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue.isNotEmpty ? initialValue : null,
      onChanged: onChanged,
      //validator: isValidator ? onValidator : null,
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
          prefixIcon: const Icon(Icons.numbers),
          hintText: title.isNotEmpty ? "Ingrese el $title" : "",
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
              width: 2,
            ),
          )),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 12),
    );
  }
}

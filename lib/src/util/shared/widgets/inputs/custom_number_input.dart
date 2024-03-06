import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';

class CustomNumberInput extends StatefulWidget {
  final String initialValue;
  final String title;
  final int minLength;
  final TextEditingController? controller;
  final Function(String result)? onChanged;
  final bool isValidator;

  const CustomNumberInput({
    super.key,
    this.controller,
    this.onChanged,
    this.initialValue = "",
    this.title = "",
    this.minLength = 1,
    this.isValidator = false,
  });

  @override
  State<CustomNumberInput> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomNumberInput> {
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
          child: TextFormField(
            controller: widget.controller,
            initialValue: widget.initialValue.isNotEmpty ? widget.initialValue : null,
            onChanged: widget.onChanged,
            validator: widget.isValidator ? onValidator : null,
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
                hintText: widget.title.isNotEmpty ? "Ingrese el ${widget.title}" : "",
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

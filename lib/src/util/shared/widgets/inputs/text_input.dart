import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';

enum TypeInput { lettersAndNumbers, lettersAndCaracteres, onlyNumbers }

class TextInput extends StatefulWidget {
  final String initialValue;
  final String hintText;
  final int minLength;
  final int? maxLength;
  final Widget? icon;
  final TextEditingController? controller;
  final Function(String result)? onChanged;
  final TypeInput typeInput;
  final bool autofocus;

  const TextInput({
    required this.typeInput,
    super.key,
    this.controller,
    this.hintText = "",
    this.onChanged,
    this.initialValue = "",
    this.minLength = 3,
    this.icon,
    this.maxLength,
    this.autofocus = false,
  });

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  late bool isError;
  late bool isFocusOut;

  @override
  void initState() {
    isError = false;
    isFocusOut = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.icon != null) {}

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isError ? 66 : 38,
      curve: Curves.easeInOut,
      child: InkWell(
        onFocusChange: (bool value) => setState(() => isFocusOut = value),
        child: TextFormField(
          autofocus: widget.autofocus,
          controller: widget.controller,
          initialValue: widget.initialValue.isNotEmpty ? widget.initialValue : null,
          onChanged: widget.onChanged,
          validator: onValidator,
          decoration: buildInputDecoration(context),
          keyboardType: TextInputType.text,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: TextStyle(color: AppTheme.colorTextTheme, fontWeight: FontWeight.w400, fontSize: 14),
        ),
      ),
    );
  }

  String? onValidator(String? value) {
    Future<void>.microtask(() => setState(() {}));
    isError = false;
    if (value != null && !isFocusOut) {
      if (value.length < widget.minLength) {
        isError = true;
        return "El campo debe ser minimo de ${widget.minLength} caracteres";
      }

      if (widget.maxLength != null && value.length > widget.maxLength!) {
        isError = true;
        return "El campo debe ser maximo de ${widget.maxLength} caracteres";
      }

      if (widget.typeInput == TypeInput.lettersAndNumbers && value.isNotEmpty) {
        if (!RegExp(r'^[a-zA-Z0-9 ]+$').hasMatch(value)) {
          isError = true;
          return "El campo solo permite letras y numeros (ABC123)";
        }
      }

      if (widget.typeInput == TypeInput.lettersAndCaracteres && value.isNotEmpty) {
        if (!RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ. ]+$').hasMatch(value)) {
          isError = true;
          return "El campo solo permite letras, caracteres especiales y el punto.";
        }
      }

      if (widget.typeInput == TypeInput.onlyNumbers && value.isNotEmpty) {
        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
          isError = true;
          return "El campo solo permite numeros";
        }
      }
    }
    return null;
  }

  InputDecoration buildInputDecoration(BuildContext context) {
    return InputDecoration(
      errorMaxLines: 1,
      fillColor: Theme.of(context).colorScheme.surface,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      constraints: const BoxConstraints(maxHeight: 24, minHeight: 12),
      border: InputBorder.none,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.secondary,
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
      prefixIcon: widget.icon ?? const Icon(Icons.abc),
      hintText: widget.hintText.isNotEmpty ? "Ingrese el ${widget.hintText}" : "",
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.error,
          width: 2,
        ),
      ),
    );
  }
}

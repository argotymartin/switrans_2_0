import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';

class TextAreaInput extends StatefulWidget {
  final String initialValue;
  final String hintText;
  final int minLength;
  final int maxLength;
  final TextEditingController? controller;
  final Function(String result)? onChanged;
  final TypeInput typeInput;
  final bool autofocus;

  const TextAreaInput({
    required this.typeInput,
    required this.minLength,
    required this.maxLength,
    super.key,
    this.controller,
    this.hintText = "",
    this.onChanged,
    this.initialValue = "",
    this.autofocus = false,
  });

  @override
  State<TextAreaInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextAreaInput> {
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
    return TextFormField(
      autofocus: widget.autofocus,
      controller: widget.controller,
      autovalidateMode: AutovalidateMode.always,
      validator: onValidator,
      minLines: 4,
      style: const TextStyle(fontSize: 12),
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration: const InputDecoration(
        errorMaxLines: 2,
        alignLabelWithHint: true,
        border: OutlineInputBorder(),
        labelText: 'Editar campo',
      ),
    );
  }

  String? onValidator(String? value) {
    Future<void>.microtask(() => setState(() {}));
    isError = false;
    if (value != null && !isFocusOut) {
      if (value.isNotEmpty && value.length < widget.minLength) {
        isError = true;
        return "El campo debe ser minimo de ${widget.minLength} caracteres";
      }

      if (value.isNotEmpty && value.length > widget.maxLength) {
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
          return "El campo solo permite números";
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
      prefixIcon: const Icon(Icons.abc),
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

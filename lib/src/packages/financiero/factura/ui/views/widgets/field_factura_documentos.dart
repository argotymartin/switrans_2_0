import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';

class FieldFacturaDocumentos extends StatelessWidget {
  final String? value;
  final String title;
  final Function(String result) onChanged;
  const FieldFacturaDocumentos({
    required this.onChanged,
    required this.value,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: AppTheme.titleStyle),
        const SizedBox(height: 8),
        _TextAreaDocumentos(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _TextAreaDocumentos extends StatelessWidget {
  final String? value;
  final Function(String result) onChanged;
  const _TextAreaDocumentos({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      autovalidateMode: AutovalidateMode.always,
      initialValue: value,
      validator: onValidator,
      minLines: 4,
      style: TextStyle(fontSize: 12, color: AppTheme.colorTextTheme),
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        fillColor: Theme.of(context).colorScheme.surface,
        filled: true,
        isDense: true,
        errorMaxLines: 2,
        alignLabelWithHint: true,
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
        border: const OutlineInputBorder(),
        labelText: 'Numeros de Documento (General / Impreso) separados por (,)',
      ),
    );
  }

  String? onValidator(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    RegExp regexDocumento = RegExp("");

    final RegExp regex = RegExp(r'^[0-9, -]+$');
    if (!regex.hasMatch(value)) {
      return "Los valores de texto no estan permitidos";
    }
    final List<String> documentos = value
        .split(",")
        .map((String doc) => doc.trim())
        .takeWhile((String doc) => doc != value.split(",").last.trim())
        .where((String doc) => regexDocumento.hasMatch(doc))
        .toList();
    if (documentos.isEmpty) {
      return null;
    }
    String title = "";
    final RegExp regexGeneral = RegExp(r'^\d{6,7}$');
    final RegExp regexImpreso = RegExp(r'^\d{2,5}-\d+$');

    if (regexGeneral.hasMatch(documentos.first)) {
      regexDocumento = regexGeneral;
      title = "General";
    } else if (regexImpreso.hasMatch(documentos.first)) {
      regexDocumento = regexImpreso;
      title = "Impreso";
    } else {
      return "Los valores digitados no parecen ser documentos validos";
    }

    final List<String> documentosDiferentes = documentos.where((String doc) => !regexDocumento.hasMatch(doc)).toList();

    if (documentosDiferentes.isNotEmpty) {
      if (documentosDiferentes.first != "") {
        return "Los Documentos (${documentosDiferentes.toList()}) No son válidas para el tipo $title";
      }
    }

    return null;
  }
}

import 'package:flutter/material.dart';

class TextAreaDocumentos extends StatelessWidget {
  final TextEditingController controller;
  const TextAreaDocumentos({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
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
        labelText: 'Numeros de remesa (General / Impreso) separados por (,)',
      ),
    );
  }

  String? onValidator(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    RegExp regexRemesas = RegExp("");

    final RegExp regex = RegExp(r'^[0-9, -]+$');
    if (!regex.hasMatch(value)) {
      return "Los valores de texto no estan permitidos";
    }
    final List<String> remesas = value
        .split(",")
        .map((remesa) => remesa.trim())
        .takeWhile((remesa) => remesa != value.split(",").last.trim())
        .where((remesa) => regexRemesas.hasMatch(remesa))
        .toList();
    if (remesas.isEmpty) {
      return null;
    }
    String title = "";
    final RegExp regexGeneral = RegExp(r'^\d{6,7}$');
    final RegExp regexImpreso = RegExp(r'^\d{2,5}-\d+$');

    if (regexGeneral.hasMatch(remesas.first)) {
      regexRemesas = regexGeneral;
      title = "General";
    } else if (regexImpreso.hasMatch(remesas.first)) {
      regexRemesas = regexImpreso;
      title = "Impreso";
    } else {
      return "Los valores digitados no parecen ser remesas validas";
    }

    final List<String> remesasDiferentes = remesas.where((remesa) => !regexRemesas.hasMatch(remesa)).toList();

    if (remesasDiferentes.isNotEmpty) {
      if (remesasDiferentes.first != "") {
        return "Las remesas (${remesasDiferentes.toList()}) No son válidas para el tipo $title";
      }
    }

    return null;
  }
}

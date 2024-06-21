import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/factura_ui.dart';

class FieldFacturaDocumentos extends StatelessWidget {
  const FieldFacturaDocumentos({super.key});

  @override
  Widget build(BuildContext context) {
    final FormFacturaBloc formFacturaBloc = BlocProvider.of<FormFacturaBloc>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Documentos", style: AppTheme.titleStyle),
        const SizedBox(height: 8),
        _TextAreaDocumentos(controller: formFacturaBloc.remesasController),
      ],
    );
  }
}

class _TextAreaDocumentos extends StatelessWidget {
  final TextEditingController controller;
  const _TextAreaDocumentos({
    required this.controller,
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
        .map((String remesa) => remesa.trim())
        .takeWhile((String remesa) => remesa != value.split(",").last.trim())
        .where((String remesa) => regexRemesas.hasMatch(remesa))
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

    final List<String> remesasDiferentes = remesas.where((String remesa) => !regexRemesas.hasMatch(remesa)).toList();

    if (remesasDiferentes.isNotEmpty) {
      if (remesasDiferentes.first != "") {
        return "Las remesas (${remesasDiferentes.toList()}) No son válidas para el tipo $title";
      }
    }

    return null;
  }
}

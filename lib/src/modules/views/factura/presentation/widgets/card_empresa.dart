import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/modules/views/factura/domain/entities/empresa.dart';

class BuildCardEmpresa extends StatefulWidget {
  const BuildCardEmpresa({
    super.key,
    required this.empresa,
  });

  final Empresa empresa;

  @override
  State<BuildCardEmpresa> createState() => _BuildCardEmpresaState();
}

class _BuildCardEmpresaState extends State<BuildCardEmpresa> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: isHovered ? Colors.red : Colors.red.shade50,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(offset: Offset(-4, 0), color: Colors.red),
          ],
        ),
        child: InkWell(
          onTap: () => setState(() => isHovered = !isHovered),
          child: Center(
              child: Text(widget.empresa.nombre,
                  style: isHovered
                      ? const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold)
                      : const TextStyle(fontSize: 10, fontWeight: FontWeight.w300))),
        ),
      ),
    );
  }
}

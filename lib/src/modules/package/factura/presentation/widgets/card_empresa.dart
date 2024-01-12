import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/entities/empresa.dart';

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
        margin: const EdgeInsets.only(bottom: 8, left: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: isHovered ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(offset: const Offset(-4, 0), color: Theme.of(context).colorScheme.primary),
          ],
        ),
        child: InkWell(
          onTap: () => setState(() => isHovered = !isHovered),
          child: Center(
            child: Row(
              children: [
                const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/logo_multicompany.png"),
                    radius: 48,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.empresa.nombre,
                    style: isHovered
                        ? const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold)
                        : const TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

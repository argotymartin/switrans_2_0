import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/factura_ui.dart';

class BuildCardEmpresa extends StatefulWidget {
  final Empresa empresa;

  const BuildCardEmpresa({
    required this.empresa,
    super.key,
  });

  @override
  State<BuildCardEmpresa> createState() => _BuildCardEmpresaState();
}

class _BuildCardEmpresaState extends State<BuildCardEmpresa> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormFacturaBloc, FormFacturaState>(
      builder: (context, state) {
        final bool isActive = state.empresa == widget.empresa.codigo;
        String rutaImagen = "assets/empresas/icon-multicompany.png";
        Color color = Theme.of(context).colorScheme.primary;
        if (widget.empresa.codigo == 1) {
          rutaImagen = "assets/empresas/icon-mct.png";
          color = Colors.red;
        }

        if (widget.empresa.codigo == 2) {
          rutaImagen = "assets/empresas/icon-marketing.png";
          color = Colors.green;
        }

        if (widget.empresa.codigo == 12) {
          rutaImagen = "assets/empresas/icon-ferricar.png";
          color = Colors.orange;
        }

        final hoveredTransform = Matrix4.identity()..scale(1.05);
        final transform = isHovered ? hoveredTransform : Matrix4.identity();
        return Material(
          child: MouseRegion(
            onEnter: (event) => setState(() => isHovered = true),
            onExit: (event) => setState(() => isHovered = false),
            child: AnimatedContainer(
              transform: transform,
              duration: const Duration(milliseconds: 200),
              child: Container(
                height: 40,
                margin: const EdgeInsets.only(bottom: 8, left: 8),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: isActive ? color : Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(offset: const Offset(-4, 0), color: color),
                  ],
                ),
                child: InkWell(
                  onTap: () {
                    context.read<FormFacturaBloc>().add(EmpresaFormFacturaEvent(widget.empresa.codigo));
                  },
                  child: Center(
                    child: Row(
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: CircleAvatar(
                            backgroundImage: AssetImage(rutaImagen),
                            radius: 48,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            widget.empresa.nombre,
                            style: isActive
                                ? const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold)
                                : const TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

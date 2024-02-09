import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/entities/factuta_entities.dart';
import 'package:switrans_2_0/src/modules/package/factura/ui/factura_ui.dart';

class BuildCardEmpresa extends StatelessWidget {
  final Empresa empresa;

  const BuildCardEmpresa({super.key, required this.empresa});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormFacturaBloc, FormFacturaState>(
      builder: (context, state) {
        final bool isActive = state.empresa == empresa.codigo.toString();
        String rutaImagen = "assets/empresas/icon-multicompany.png";
        Color color = Theme.of(context).colorScheme.primary;
        if (empresa.codigo == 1) {
          rutaImagen = "assets/empresas/icon-mct.png";
          color = Colors.red;
        }

        if (empresa.codigo == 2) {
          rutaImagen = "assets/empresas/icon-marketing.png";
          color = Colors.green;
        }

        if (empresa.codigo == 12) {
          rutaImagen = "assets/empresas/icon-ferricar.png";
          color = Colors.orange;
        }

        return Material(
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
                context.read<FormFacturaBloc>().add(EmpresaFormFacturaEvent(empresa.codigo.toString()));
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
                        empresa.nombre,
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
        );
      },
    );
  }
}

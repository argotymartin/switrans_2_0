import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/factura_ui.dart';

class FieldFacturaEmpresa extends StatelessWidget {
  const FieldFacturaEmpresa({super.key});

  @override
  Widget build(BuildContext context) {
    final FormFacturaBloc formFacturaBloc = BlocProvider.of<FormFacturaBloc>(context);
    final List<Empresa> empresas = formFacturaBloc.state.empresas;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Empresa", style: AppTheme.titleStyle),
        const SizedBox(height: 8),
        Wrap(
          runSpacing: 8,
          spacing: 16,
          clipBehavior: Clip.antiAlias,
          children: List<Widget>.generate(
            empresas.length,
            (int index) => SizedBox(width: 180, child: _BuildCardEmpresa(empresa: empresas[index])),
          ),
        ),
      ],
    );
  }
}

class _BuildCardEmpresa extends StatefulWidget {
  final Empresa empresa;

  const _BuildCardEmpresa({
    required this.empresa,
    super.key,
  });

  @override
  State<_BuildCardEmpresa> createState() => _BuildCardEmpresaState();
}

class _BuildCardEmpresaState extends State<_BuildCardEmpresa> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormFacturaBloc, FormFacturaState>(
      builder: (BuildContext context, FormFacturaState state) {
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

        final Matrix4 hoveredTransform = Matrix4.identity()..scale(1.05);
        final Matrix4 transform = isHovered ? hoveredTransform : Matrix4.identity();
        return Material(
          color: Colors.transparent,
          child: MouseRegion(
            onEnter: (PointerEnterEvent event) => setState(() => isHovered = true),
            onExit: (PointerExitEvent event) => setState(() => isHovered = false),
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
                  boxShadow: <BoxShadow>[
                    BoxShadow(offset: const Offset(-4, 0), color: color),
                  ],
                ),
                child: InkWell(
                  onTap: () {
                    context.read<FormFacturaBloc>().add(EmpresaFormFacturaEvent(widget.empresa.codigo));
                  },
                  child: Center(
                    child: Row(
                      children: <Widget>[
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

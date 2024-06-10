import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/widgets/card_details_factura2.dart';

class ModalItemDocumento extends StatefulWidget {
  const ModalItemDocumento({super.key});

  @override
  State<ModalItemDocumento> createState() => _ModalItemDocumentoState();
}

class _ModalItemDocumentoState extends State<ModalItemDocumento> with SingleTickerProviderStateMixin {
  late Animation<double> tralateAnimation;
  late FormFacturaBloc formulario;
  @override
  void initState() {
    formulario = context.read<FormFacturaBloc>();
    formulario.animationController = AnimationController(duration: const Duration(seconds: 1), vsync: this);
    tralateAnimation =
        Tween<double>(begin: 750, end: 0).animate(CurvedAnimation(parent: formulario.animationController, curve: Curves.easeIn));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemDocumentoBloc, ItemDocumentoState>(
      builder: (BuildContext context, ItemDocumentoState state) {
        return AnimatedBuilder(
          animation: formulario.animationController,
          builder: (BuildContext context, Widget? child) => AnimatedOpacity(
            opacity: state.itemDocumentos.isEmpty ? 0.0 : 1.0,
            duration: const Duration(seconds: 1),
            child: Transform.translate(
              offset: Offset(tralateAnimation.value, 0),
              child: InkWell(
                onTap: () => formulario.moveBottomAllScroll(),
                child: const Row(
                  children: <Widget>[
                    Expanded(child: SizedBox()),
                    SizedBox(width: 720, child: CardDetailsFactura2()),
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

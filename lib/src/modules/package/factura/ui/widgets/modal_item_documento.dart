import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/modules/package/factura/ui/factura_ui.dart';

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
    formulario.animationController = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    tralateAnimation =
        Tween<double>(begin: 50, end: -20).animate(CurvedAnimation(parent: formulario.animationController, curve: Curves.bounceOut));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(right: 24),
      height: 64,
      width: size.width,
      child: AnimatedBuilder(
        animation: formulario.animationController,
        builder: (context, child) => Transform.translate(
          offset: Offset(0, tralateAnimation.value),
          child: InkWell(
            onTap: () => formulario.moveBottomAllScroll(),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: BlocBuilder<ItemFacturaBloc, ItemFacturaState>(
                builder: (context, state) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.documentosTransporte.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onPrimary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.all(8),
                        child: Center(
                          child: Row(
                            children: [
                              const Icon(Icons.file_copy),
                              Text("${state.documentosTransporte[index].impreso}  (${state.documentosTransporte[index].remesa})"),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

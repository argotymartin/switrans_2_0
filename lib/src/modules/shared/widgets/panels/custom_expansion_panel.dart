// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:switrans_2_0/src/modules/package/factura/ui/factura_ui.dart';

class CustomExpansionPanel extends StatelessWidget {
  final String title;
  final Widget child;
  const CustomExpansionPanel({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final expansionPanelCubit = context.watch<FormularioFacturaCubit>();
    return Column(
      children: [
        ExpansionPanelList(
          expansionCallback: (panelIndex, isExpanded) {
            expansionPanelCubit.setStatePanel(isExpanded);
          },
          children: <ExpansionPanel>[
            ExpansionPanel(
              backgroundColor: Colors.white,
              headerBuilder: (context, isExpanded) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      isExpanded ? const Icon(Icons.filter_alt_off_outlined) : const Icon(Icons.filter_alt_rounded),
                      SizedBox(
                        height: 24,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            title,
                            style: GoogleFonts.roboto(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: child,
              ),
              isExpanded: expansionPanelCubit.state.expanded,
              canTapOnHeader: true,
            )
          ],
        ),
      ],
    );
  }
}

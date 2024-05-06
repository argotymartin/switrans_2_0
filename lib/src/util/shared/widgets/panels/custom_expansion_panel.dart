// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomExpansionPanel extends StatefulWidget {
  final String title;
  final Widget child;
  const CustomExpansionPanel({
    required this.title,
    required this.child,
    super.key,
  });

  @override
  State<CustomExpansionPanel> createState() => _CustomExpansionPanelState();
}

class _CustomExpansionPanelState extends State<CustomExpansionPanel> {
  bool isExpanded = true;
  @override
  Widget build(BuildContext context) {
    //final expansionPanelCubit = context.watch<FormFacturaBloc>();
    return Column(
      children: [
        ExpansionPanelList(
          expansionCallback: (panelIndex, _) {
            isExpanded = !isExpanded;
            setState(() {});
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
                          child: Text(
                            widget.title,
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
                child: widget.child,
              ),
              isExpanded: isExpanded,
              canTapOnHeader: true,
            ),
          ],
        ),
      ],
    );
  }
}

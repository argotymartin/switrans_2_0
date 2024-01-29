import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomExpansionPanel extends StatefulWidget {
  final String title;
  final Widget child;
  bool active;
  CustomExpansionPanel({super.key, required this.title, required this.child, this.active = true});

  @override
  State<CustomExpansionPanel> createState() => _CustomExpansionPanelState();
}

class _CustomExpansionPanelState extends State<CustomExpansionPanel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpansionPanelList(
          expansionCallback: (panelIndex, isExpanded) {
            widget.active = !widget.active;
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
                      widget.active ? const Icon(Icons.filter_alt_off_outlined) : const Icon(Icons.filter_alt_rounded),
                      SizedBox(
                        height: 24,
                        child: FittedBox(
                          fit: BoxFit.contain,
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
              isExpanded: widget.active,
              canTapOnHeader: true,
            )
          ],
        ),
      ],
    );
  }
}

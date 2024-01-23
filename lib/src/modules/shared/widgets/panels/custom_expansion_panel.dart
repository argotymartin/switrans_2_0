import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomExpansionPanel extends StatefulWidget {
  final String title;
  final Widget child;
  const CustomExpansionPanel({super.key, required this.title, required this.child});

  @override
  State<CustomExpansionPanel> createState() => _CustomExpansionPanelState();
}

class _CustomExpansionPanelState extends State<CustomExpansionPanel> {
  bool active = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpansionPanelList(
          expansionCallback: (panelIndex, isExpanded) {
            active = !active;
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
                      active ? const Icon(Icons.filter_alt_off_outlined) : const Icon(Icons.filter_alt_rounded),
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
              isExpanded: active,
              canTapOnHeader: true,
            )
          ],
        ),
      ],
    );
  }
}

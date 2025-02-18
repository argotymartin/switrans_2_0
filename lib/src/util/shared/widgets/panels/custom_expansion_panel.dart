// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';

class CustomExpansionPanel extends StatefulWidget {
  final String title;
  final Widget child;
  final IconData iconOn;
  final IconData iconOff;
  const CustomExpansionPanel({
    required this.title,
    required this.child,
    required this.iconOn,
    required this.iconOff,
    super.key,
  });

  @override
  State<CustomExpansionPanel> createState() => _CustomExpansionPanelState();
}

class _CustomExpansionPanelState extends State<CustomExpansionPanel> {
  bool isExpanded = true;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (BuildContext context, ThemeState state) {
        return Column(
          children: <Widget>[
            ExpansionPanelList(
              expansionCallback: (int panelIndex, _) {
                isExpanded = !isExpanded;
                setState(() {});
              },
              children: <ExpansionPanel>[
                ExpansionPanel(
                  backgroundColor: AppTheme.colorThemePrimary,
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          isExpanded ? Icon(widget.iconOn) : Icon(widget.iconOff),
                          const SizedBox(width: 8),
                          SizedBox(
                            height: 24,
                            child: FittedBox(
                              child: Text(
                                widget.title,
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
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
      },
    );
  }
}

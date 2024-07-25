import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';

class CardExpansionPanel extends StatefulWidget {
  final String? title;
  final double? width;
  final Widget child;
  final IconData icon;

  const CardExpansionPanel({
    required this.child,
    required this.icon,
    this.title,
    this.width,
    super.key,
  });

  @override
  State<CardExpansionPanel> createState() => _WhiteCardState();
}

class _WhiteCardState extends State<CardExpansionPanel> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AppTheme.colorThemePrimary,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Theme.of(context).colorScheme.surface),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (widget.title != null) ...<Widget>[
            Material(
              child: InkWell(
                onTap: () {
                  setState(() => _isExpanded = !_isExpanded);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 8),
                  decoration: BoxDecoration(
                    color: AppTheme.colorThemeSecundary,
                    border: BorderDirectional(bottom: BorderSide(color: Theme.of(context).colorScheme.surfaceContainerHighest)),
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(widget.icon),
                      const SizedBox(width: 4),
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.title!,
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
                    ],
                  ),
                ),
              ),
            ),
          ],
          if (_isExpanded)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: widget.child,
            ),
        ],
      ),
    );
  }
}

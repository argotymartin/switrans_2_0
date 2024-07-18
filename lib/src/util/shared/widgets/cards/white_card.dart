import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';

class WhiteCard extends StatefulWidget {
  final String? title;
  final double? width;
  final Widget child;
  final IconData icon;

  const WhiteCard({
    required this.child,
    required this.icon,
    this.title,
    this.width,
    super.key,
  });

  @override
  State<WhiteCard> createState() => _WhiteCardState();
}

class _WhiteCardState extends State<WhiteCard> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    Color color;
    Color secundaryColor;
    final ThemeState state = context.watch<ThemeCubit>().state;
    if (state.themeMode == 1) {
      color = Theme.of(context).colorScheme.surfaceContainerLowest;
      secundaryColor = Theme.of(context).colorScheme.surfaceContainerLowest;
    } else if (state.themeMode == 2) {
      color = Colors.black38;
      secundaryColor = Theme.of(context).colorScheme.surfaceContainerHighest;
    } else {
      color = Theme.of(context).colorScheme.surfaceContainerLowest;
      secundaryColor = Theme.of(context).colorScheme.surfaceContainerLowest;
    }
    return Container(
      width: widget.width,
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: color,
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
            Container(
              padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 8),
              decoration: BoxDecoration(
                color: secundaryColor,
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
                  IconButton(
                    icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
                    onPressed: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                  ),
                ],
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

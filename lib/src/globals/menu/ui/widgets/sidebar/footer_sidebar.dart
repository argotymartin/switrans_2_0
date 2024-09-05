import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';

class FooterSidebar extends StatelessWidget {
  const FooterSidebar({
    required this.isMinimize,
    super.key,
  });

  final bool isMinimize;

  @override
  Widget build(BuildContext context) {
    Color color;
    Color iconColor = Theme.of(context).colorScheme.onTertiary.withOpacity(0.6);
    final ThemeState state = context.watch<ThemeCubit>().state;
    if (state.themeMode == 1) {
      color = Theme.of(context).canvasColor;
      iconColor = Theme.of(context).colorScheme.onTertiary.withOpacity(0.6);
    } else if (state.themeMode == 2) {
      color = Colors.black;
      iconColor = Theme.of(context).colorScheme.primaryContainer;
    } else {
      color = Colors.white60;
      iconColor = Theme.of(context).colorScheme.onPrimaryContainer;
    }
    return Container(
      height: 80,
      padding: isMinimize ? null : const EdgeInsets.symmetric(horizontal: 54),
      width: isMinimize ? 80 : 270,
      color: color,
      child: isMinimize
          ? Icon(Icons.double_arrow_outlined, color: Colors.white.withOpacity(0.3))
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(Icons.forum_outlined, color: iconColor, size: 20),
                Icon(Icons.telegram_sharp, color: iconColor, size: 20),
                Icon(Icons.call_outlined, color: iconColor, size: 20),
              ],
            ),
    );
  }
}

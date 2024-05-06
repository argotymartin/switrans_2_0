import 'package:flutter/material.dart';

class FooterSidebar extends StatelessWidget {
  const FooterSidebar({
    required this.isMinimize,
    super.key,
  });

  final bool isMinimize;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      padding: isMinimize ? null : const EdgeInsets.symmetric(horizontal: 54),
      width: isMinimize ? 80 : 270,
      color: Theme.of(context).colorScheme.primary,
      child: isMinimize
          ? Icon(Icons.double_arrow_outlined, color: Colors.white.withOpacity(0.3))
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.forum_outlined, color: Theme.of(context).colorScheme.onTertiary.withOpacity(0.6), size: 20),
                Icon(Icons.telegram_sharp, color: Theme.of(context).colorScheme.onTertiary.withOpacity(0.6), size: 20),
                Icon(Icons.call_outlined, color: Theme.of(context).colorScheme.onTertiary.withOpacity(0.6), size: 20),
              ],
            ),
    );
  }
}

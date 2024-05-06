import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class SwitchBoxInputTitle extends StatelessWidget {
  final bool value;
  final String title;

  const SwitchBoxInputTitle({
    required this.value,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTheme.titleStyle),
        const SizedBox(height: 8),
        SwitchBoxInput(onChanged: (newValue) => newValue = value),
      ],
    );
  }
}

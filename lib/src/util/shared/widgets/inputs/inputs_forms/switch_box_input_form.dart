import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class SwitchBoxInputForm extends StatelessWidget {
  final ValueChanged<bool> onChanged;
  final String title;

  const SwitchBoxInputForm({
    required this.onChanged,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: AppTheme.titleStyle),
        const SizedBox(height: 8),
        SwitchBoxInput(onChanged: onChanged),
      ],
    );
  }

}

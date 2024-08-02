import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/segmented_input.dart';

class SegmentedInputForm extends StatelessWidget {
  final String title;
  final bool? value;
  final ValueChanged<bool?> onChanged;

  const SegmentedInputForm({
    required this.onChanged,
    required this.title,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: AppTheme.titleStyle),
        const SizedBox(height: 8),
        SegmentedInput(onChanged: onChanged, optionSelected: value),
      ],
    );
  }
}

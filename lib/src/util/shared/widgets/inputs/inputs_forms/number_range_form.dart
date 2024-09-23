import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/number_range_input.dart';

class NumberRangeForm extends StatelessWidget {
  final String title;
  final int min;
  final int max;
  final ValueChanged<int> onChanged1;
  final ValueChanged<int> onChanged2;

  const NumberRangeForm({
    required this.min,
    required this.max,
    required this.onChanged1,
    required this.onChanged2,
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
        NumberRangeInput(
          min: min,
          max: max,
          onChanged1: onChanged1,
          onChanged2: onChanged2,
        ),
      ],
    );
  }
}

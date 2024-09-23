import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/range_input.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class RangeInputForm extends StatelessWidget {
  final String title;
  final int min;
  final int max;
  final double interval;
  final SfRangeValues initialValue;
  final ValueChanged<SfRangeValues>? onChanged;

  const RangeInputForm({
    required this.title,
    required this.min,
    required this.max,
    required this.interval,
    required this.initialValue,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: AppTheme.titleStyle),
        const SizedBox(height: 8),
        RangeInput(
          min: min,
          max: max,
          interval: interval,
          onChanged: onChanged,
          initialValue: initialValue,
        ),
      ],
    );
  }
}

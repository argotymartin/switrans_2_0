import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/date_input_picker.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/web_range_date_picker.dart';

class DatePickerInputForm extends StatelessWidget {
  final String title;
  final String? value;
  final Function(String result) onChanged;
  final bool isRequired;
  final bool autofocus;
  final bool isRange;

  const DatePickerInputForm({
    required this.title,
    required this.value,
    required this.onChanged,
    required this.isRange,
    this.isRequired = true,
    this.autofocus = false,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: AppTheme.titleStyle),
        const SizedBox(height: 8),
        isRange
            ? WebRangeDatePicker(
                onChange: onChanged,
                autofocus: autofocus,
                isRequired: isRequired,
                initialValue: value != null ? value! : "",
              )
            : DateInputPicker(
                onDateSelected: onChanged,
                autofocus: autofocus,
                dateInitialValue: value,
              ),
      ],
    );
  }
}

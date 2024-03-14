import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/web_date_picker.dart';

class CustomWebDatePicker extends StatelessWidget {
  final String initialValue;
  final String title;
  final TextEditingController? controller;
  final Function(String result)? onChanged;

  const CustomWebDatePicker({
    super.key,
    this.controller,
    this.onChanged,
    this.initialValue = "",
    this.title = "",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title.isNotEmpty ? Text(title, style: AppTheme.titleStyle) : const SizedBox(),
        title.isNotEmpty ? const SizedBox(height: 8) : const SizedBox(),
        WebDatePicker(
          controller: controller,
          onChange: (value) {},
        ),
      ],
    );
  }
}

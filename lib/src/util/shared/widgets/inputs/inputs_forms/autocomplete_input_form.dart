import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class AutocompleteInputForm extends StatelessWidget {
  final String title;
  final List<EntryAutocomplete> entries;
  final int? value;
  final Function(EntryAutocomplete result) onChanged;
  final bool isRequired;

  const AutocompleteInputForm({
    required this.title,
    required this.entries,
    required this.value,
    required this.onChanged,
    this.isRequired = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: AppTheme.titleStyle),
        const SizedBox(height: 8),
        AutocompleteInput2(
          entries: entries,
          entryCodigoSelected: value,
          onPressed: onChanged,
          isRequired: isRequired,
        ),
      ],
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/modules/shared/models/models_shared.dart';

class Autocomplete2Input extends StatelessWidget {
  final List<EntryAutocomplete> entries;
  final String label;
  final TextEditingController? controller;
  final Function(EntryAutocomplete result)? onPressed;
  final bool enabled;
  final bool isShowCodigo;
  final EntryAutocomplete? entrySelected;
  const Autocomplete2Input({
    Key? key,
    required this.entries,
    required this.label,
    this.controller,
    this.onPressed,
    this.enabled = true,
    this.isShowCodigo = true,
    this.entrySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dropdownMenuEntries = entries.map<DropdownMenuEntry<EntryAutocomplete>>(
      (entry) {
        return DropdownMenuEntry<EntryAutocomplete>(
          style: const ButtonStyle(
              padding: MaterialStatePropertyAll(EdgeInsets.all(8)),
              side: MaterialStatePropertyAll(BorderSide(color: Colors.grey, width: 0.3)),
              backgroundColor: MaterialStatePropertyAll(Colors.white)),
          value: entry,
          label: entry.title,
          leadingIcon: isShowCodigo ? CircleAvatar(child: Text('${entry.codigo}')) : const SizedBox(),
          labelWidget: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(entry.title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300)),
              Text(entry.subTitle, style: const TextStyle(color: Colors.grey, fontSize: 10)),
              // entry.details,
              SizedBox(height: 16, child: FittedBox(fit: BoxFit.contain, child: entry.details))
            ],
          ),
        );
      },
    ).toList();
    return SafeArea(
      child: DropdownMenu<EntryAutocomplete>(
        controller: controller,
        enableFilter: enabled,
        enableSearch: enabled,
        enabled: enabled,
        initialSelection: entrySelected,
        requestFocusOnTap: true,
        expandedInsets: EdgeInsets.zero,
        trailingIcon: const Icon(Icons.arrow_drop_down, size: 20),
        selectedTrailingIcon: const Icon(Icons.arrow_drop_up, size: 20),
        leadingIcon: const Icon(Icons.search),
        label: Text(label),
        hintText: "Buscar $label ...",
        textStyle: const TextStyle(fontSize: 12),
        inputDecorationTheme: const InputDecorationTheme(
          constraints: BoxConstraints(maxHeight: 38, minHeight: 38),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
        ),
        onSelected: (EntryAutocomplete? entry) {
          print("EntryAutocomplete selected: ${entry!.codigo}");
          if (onPressed != null) {
            onPressed?.call(entry);
          }
        },
        dropdownMenuEntries: dropdownMenuEntries,
      ),
    );
  }
}

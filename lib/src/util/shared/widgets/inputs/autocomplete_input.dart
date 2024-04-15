import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';

class AutocompleteInput extends StatefulWidget {
  final List<EntryAutocomplete> entries;
  final String label;
  final TextEditingController? controller;
  final Function(EntryAutocomplete result)? onPressed;
  final bool enabled;
  final bool isShowCodigo;
  final int minChractersSearch;
  final String entrySelected;

  const AutocompleteInput({
    super.key,
    required this.entries,
    required this.label,
    this.controller,
    this.onPressed,
    this.enabled = true,
    this.isShowCodigo = true,
    this.entrySelected = '',
    this.minChractersSearch = 1,
  });

  @override
  State<StatefulWidget> createState() => _Autocomplete2InputState();
}

class _Autocomplete2InputState extends State<AutocompleteInput> {
  List<DropdownMenuEntry<EntryAutocomplete>> dropdownMenuEntries = [];
  String entrySelected2 = '';

  @override
  void initState() {
    super.initState();
    final filteredEntries = widget.entries.take(10).toList();
    dropdownMenuEntries = filteredEntries.map<DropdownMenuEntry<EntryAutocomplete>>((entry) => buildItemMenuEntry(entry)).toList();
    entrySelected2 = widget.entrySelected;
    if (widget.controller != null) widget.controller!.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final searchText = widget.controller!.text.toLowerCase();
    if (mounted) {
      setState(() {
        entrySelected2 = '';
        final filteredEntries = widget.entries.where((entry) => entry.title.toLowerCase().contains(searchText)).toList();
        if (searchText.length >= widget.minChractersSearch) {
          dropdownMenuEntries = filteredEntries.map<DropdownMenuEntry<EntryAutocomplete>>((entry) => buildItemMenuEntry(entry)).toList();
        }
      });
    }
  }

  DropdownMenuEntry<EntryAutocomplete> buildItemMenuEntry(EntryAutocomplete entry) {
    return DropdownMenuEntry<EntryAutocomplete>(
      style: const ButtonStyle(
          padding: MaterialStatePropertyAll(EdgeInsets.all(8)),
          side: MaterialStatePropertyAll(BorderSide(color: Colors.grey, width: 0.3)),
          backgroundColor: MaterialStatePropertyAll(Colors.white)),
      value: entry,
      label: entry.title,
      leadingIcon: widget.isShowCodigo ? CircleAvatar(child: Text('${entry.codigo}')) : const SizedBox(),
      labelWidget: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(entry.title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300)),
          if (entry.subTitle.isNotEmpty) Text(entry.subTitle, style: const TextStyle(color: Colors.grey, fontSize: 10)),
          if (entry.details != null) SizedBox(height: 16, child: FittedBox(fit: BoxFit.contain, child: entry.details))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DropdownMenu<EntryAutocomplete>(
        controller: widget.controller,
        menuHeight: 400,
        requestFocusOnTap: true,
        enableFilter: widget.enabled,
        enableSearch: widget.enabled,
        enabled: widget.enabled,
        expandedInsets: EdgeInsets.zero,
        trailingIcon: const Icon(Icons.arrow_drop_down, size: 20),
        selectedTrailingIcon: const Icon(Icons.arrow_drop_up, size: 20),
        leadingIcon: const Icon(Icons.search),
        hintText: entrySelected2 != '' ? entrySelected2 : "Buscar ${widget.label} ...",
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
          widget.onPressed?.call(entry!);
          if (widget.controller != null) widget.controller!.text == entry!.title;
        },
        dropdownMenuEntries: dropdownMenuEntries,
      ),
    );
  }
}

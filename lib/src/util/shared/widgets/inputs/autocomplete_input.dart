import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';

class AutocompleteInput extends StatefulWidget {
  final List<EntryAutocomplete> entries;
  final String label;
  final TextEditingController controller;
  final Function(EntryAutocomplete result)? onPressed;
  final bool enabled;
  final bool isShowCodigo;
  final int minChractersSearch;
  final int? entryCodigoSelected;

  const AutocompleteInput({
    required this.entries,
    required this.label,
    required this.controller,
    this.onPressed,
    this.enabled = true,
    this.isShowCodigo = true,
    this.minChractersSearch = 1,
    this.entryCodigoSelected,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _Autocomplete2InputState();
}

class _Autocomplete2InputState extends State<AutocompleteInput> {
  List<DropdownMenuEntry<EntryAutocomplete>> dropdownMenuEntries = <DropdownMenuEntry<EntryAutocomplete>>[];
  EntryAutocomplete entryAutocompleteSelected = EntryAutocomplete(title: "");
  late List<EntryAutocomplete> filteredEntries;

  @override
  void initState() {
    super.initState();
    if (widget.entryCodigoSelected != null) {
      if (widget.entries.isNotEmpty) {
        entryAutocompleteSelected = widget.entries.firstWhere((EntryAutocomplete e) => e.codigo == widget.entryCodigoSelected);
        widget.controller.text = entryAutocompleteSelected.title;
      }
    }
    filteredEntries = widget.entries.take(8).toList();
    dropdownMenuEntries =
        filteredEntries.map<DropdownMenuEntry<EntryAutocomplete>>((EntryAutocomplete entry) => buildItemMenuEntry(entry)).toList();
    widget.controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final String searchText = widget.controller.text.toLowerCase();

    if (mounted) {
      setState(() {
        bool isMinCharacter = true;
        filteredEntries = widget.entries.where((EntryAutocomplete entry) {
          if (searchText.isNotEmpty && searchText.substring(0, 1) == ';') {
            final String searchNew = searchText.split(";")[1];
            isMinCharacter = false;
            return entry.subTitle.toLowerCase().contains(searchNew);
          }

          final RegExp regex = RegExp(r'^[0-9]+$'); // Expresión regular para verificar números
          if (regex.hasMatch(searchText)) {
            isMinCharacter = false;
            return entry.codigo.toString().contains(searchText);
          } else {
            return entry.title.toLowerCase().contains(searchText);
          }
        }).toList();
        if (searchText.length >= widget.minChractersSearch && isMinCharacter) {
          dropdownMenuEntries =
              filteredEntries.map<DropdownMenuEntry<EntryAutocomplete>>((EntryAutocomplete entry) => buildItemMenuEntry(entry)).toList();
        }
      });
    }
  }

  DropdownMenuEntry<EntryAutocomplete> buildItemMenuEntry(EntryAutocomplete entry) {
    return DropdownMenuEntry<EntryAutocomplete>(
      style: ButtonStyle(
        padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.all(8)),
        side: const WidgetStatePropertyAll<BorderSide>(BorderSide(color: Colors.grey, width: 0.3)),
        backgroundColor: WidgetStatePropertyAll<Color>(AppTheme.colorThemeSecundary),
      ),
      value: entry,
      label: entry.title,
      leadingIcon: widget.isShowCodigo ? CircleAvatar(child: Text('${entry.codigo}')) : const SizedBox(),
      labelWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(entry.title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300)),
          if (entry.subTitle.isNotEmpty) Text(entry.subTitle, style: const TextStyle(color: Colors.grey, fontSize: 10)),
          if (entry.details != null) SizedBox(height: 16, child: FittedBox(child: entry.details)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (BuildContext context, ThemeState state) {
          return DropdownMenu<EntryAutocomplete>(
            controller: widget.controller,
            requestFocusOnTap: true,
            menuHeight: 300,
            enableSearch: false,
            enabled: widget.enabled,
            expandedInsets: EdgeInsets.zero,
            trailingIcon: const Icon(Icons.keyboard_arrow_down),
            selectedTrailingIcon: const Icon(Icons.keyboard_arrow_up),
            leadingIcon: entryAutocompleteSelected.title.isNotEmpty
                ? BuildCampoCodigo(codigo: entryAutocompleteSelected.codigo)
                : const Icon(Icons.search),
            hintText: "Buscar ${widget.label} ...",
            textStyle: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.inverseSurface),
            inputDecorationTheme: const InputDecorationTheme(
              constraints: BoxConstraints(maxHeight: 38, minHeight: 38),
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
            onSelected: (EntryAutocomplete? entry) {
              setState(() => entryAutocompleteSelected = entry!);
              widget.onPressed?.call(entry!);
              widget.controller.text = entry!.title;
            },
            dropdownMenuEntries: dropdownMenuEntries,
          );
        },
      ),
    );
  }
}

class BuildCampoCodigo extends StatelessWidget {
  const BuildCampoCodigo({
    required this.codigo,
    super.key,
  });

  final int codigo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      width: 60 + codigo.toString().length * 6,
      child: Row(
        children: <Widget>[
          const SizedBox(width: 8),
          Icon(Icons.search, color: Theme.of(context).primaryColor),
          Chip(
            clipBehavior: Clip.antiAlias,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            labelPadding: const EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.zero,
            shape: const StadiumBorder(),
            side: BorderSide.none,
            elevation: 4,
            label: Text(
              codigo.toString(),
              style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

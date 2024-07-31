import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';

class AutocompleteInput2 extends StatefulWidget {
  final List<EntryAutocomplete> entries;
  final String label;
  final TextEditingController? controller;
  final Function(EntryAutocomplete result)? onPressed;
  final bool enabled;
  final bool isShowCodigo;
  final int minChractersSearch;
  final int? entryCodigoSelected;

  const AutocompleteInput2({
    required this.entries,
    required this.label,
    this.controller,
    this.onPressed,
    this.enabled = true,
    this.isShowCodigo = true,
    this.minChractersSearch = 1,
    this.entryCodigoSelected,
    super.key,
  });

  @override
  State<AutocompleteInput2> createState() => _Autocomplete2InputState();
}

class _Autocomplete2InputState extends State<AutocompleteInput2> {
  EntryAutocomplete? entryAutocompleteSelected;
  late List<EntryAutocomplete> filteredEntries;
  late FocusNode _focusNode;
  late TextEditingController? controller;
  late bool isError;
  late bool isClean;

  @override
  void initState() {
    super.initState();
    isError = false;
    isClean = false;
    _focusNode = FocusNode();
    controller = widget.controller ?? TextEditingController();

    if (widget.entryCodigoSelected != null) {
      if (widget.entries.isNotEmpty) {
        entryAutocompleteSelected = widget.entries.firstWhere((EntryAutocomplete e) => e.codigo == widget.entryCodigoSelected);
      }
    }
    filteredEntries = widget.entries.take(8).toList();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (BuildContext context, ThemeState state) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: isError ? 66 : 38,
            child: DropdownSearch<EntryAutocomplete>(
              selectedItem: entryAutocompleteSelected,
              asyncItems: (String? filter) => getData(filter!, widget.entries),
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (EntryAutocomplete? i) {
                if (i == null) {
                  Future<void>.microtask(() => setState(() {}));
                  isError = true;
                  return 'El Campos es Requerido';
                }
                return null;
              },
              clearButtonProps: ClearButtonProps(
                isVisible: true,
                onPressed: () {
                  entryAutocompleteSelected = null;
                  widget.onPressed!(EntryAutocomplete(title: ""));
                },
              ),
              popupProps: PopupPropsMultiSelection<EntryAutocomplete>.menu(
                showSelectedItems: true,
                isFilterOnline: true,
                itemBuilder: _customPopupItemBuilder,
                showSearchBox: true,
                searchFieldProps: TextFieldProps(
                  autofocus: true,
                  controller: controller,
                  style: TextStyle(color: AppTheme.colorTextTheme),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        controller!.clear();
                      },
                    ),
                  ),
                ),
              ),
              compareFn: (EntryAutocomplete item, EntryAutocomplete sItem) => item.title == sItem.title,
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  fillColor: Theme.of(context).colorScheme.surface,
                  filled: true,
                  prefixIcon: const Icon(Icons.filter_list),
                  constraints: const BoxConstraints(maxHeight: 38, minHeight: 38),
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    gapPadding: 100,
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.error,
                      width: 2,
                    ),
                  ),
                ),
              ),
              dropdownBuilder: (BuildContext context, EntryAutocomplete? selectedItem) {
                if (selectedItem != null) {
                  entryAutocompleteSelected = selectedItem;
                  widget.onPressed?.call(selectedItem);
                  Future<void>.microtask(
                    () => setState(() {
                      isError = false;
                    }),
                  );
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      child: Row(
                        children: <Widget>[
                          Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Text(
                                entryAutocompleteSelected!.codigo.toString(),
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          Text(entryAutocompleteSelected!.title),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Text("Seleccionar item");
                }
              },
            ),
          );
        },
      ),
    );
  }
}

Widget _customPopupItemBuilder(BuildContext context, EntryAutocomplete item, bool isSelected) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8),
    decoration: !isSelected
        ? BoxDecoration(border: Border.symmetric(horizontal: BorderSide(color: Theme.of(context).colorScheme.primaryContainer)))
        : BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(5),
            color: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.2),
          ),
    child: ListTile(
      selected: isSelected,
      title: Text(item.title, style: const TextStyle(fontSize: 12)),
      subtitle: item.subTitle != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(item.subTitle!, style: const TextStyle(fontSize: 10)),
                SizedBox(height: 16, child: FittedBox(child: item.details)),
              ],
            )
          : const SizedBox(),
      leading: CircleAvatar(
        child: Text(item.codigo.toString(), style: const TextStyle(fontSize: 12)),
      ),
    ),
  );
}

Future<List<EntryAutocomplete>> getData(String searchText, List<EntryAutocomplete> entries) async {
  final List<EntryAutocomplete> filteredEntries = entries.where((EntryAutocomplete entry) {
    if (searchText.isNotEmpty && searchText.substring(0, 1) == ';') {
      final String searchNew = searchText.split(";")[1];
      return entry.subTitle!.toLowerCase().contains(searchNew);
    }

    final RegExp regex = RegExp(r'^[0-9]+$');
    if (regex.hasMatch(searchText)) {
      return entry.codigo.toString().contains(searchText);
    } else {
      return entry.title.toLowerCase().contains(searchText);
    }
  }).toList();

  return filteredEntries;
}

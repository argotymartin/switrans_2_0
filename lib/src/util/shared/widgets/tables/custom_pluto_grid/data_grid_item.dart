import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';

enum Tipo { item, text, boolean, select, date }

class DataItemGrid {
  final Tipo type;
  final dynamic value;
  final bool edit;
  final List<String>? dataList;
  final List<EntryAutocomplete>? entryMenus;

  DataItemGrid({
    required this.type,
    required this.value,
    required this.edit,
    this.dataList,
    this.entryMenus,
  });
}

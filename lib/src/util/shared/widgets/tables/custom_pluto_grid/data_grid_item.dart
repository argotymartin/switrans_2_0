import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';

enum Tipo { item, text, boolean, select, date }

class DataItemGrid {
  final String title;
  final Tipo type;
  final dynamic value;
  final bool edit;
  final List<String>? dataList;
  final List<EntryAutocomplete>? entryMenus;
  final int? minLength;
  final int? maxLength;
  final TypeInput? typeInput;
  final double? width;

  DataItemGrid({
    required this.title,
    required this.type,
    required this.value,
    required this.edit,
    this.dataList,
    this.entryMenus,
    this.minLength,
    this.maxLength,
    this.typeInput,
    this.width,
  });
}

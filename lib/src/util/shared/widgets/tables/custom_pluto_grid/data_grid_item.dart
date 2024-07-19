enum Tipo { item, text, boolean, select, date }

class DataItemGrid {
  final Tipo type;
  final dynamic value;
  final bool edit;
  final List<String>? dataList;

  DataItemGrid({
    required this.type,
    required this.value,
    required this.edit,
    this.dataList,
  });
}

import 'package:switrans_2_0/src/util/shared/widgets/tables/custom_pluto_grid/pluto_grid_data_builder.dart';

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

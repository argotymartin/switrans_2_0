part of 'item_factura_bloc.dart';

sealed class ItemFacturaState extends Equatable {
  final List<ItemDocumento> itemDocumentos;
  final String centroCosto;
  const ItemFacturaState({this.itemDocumentos = const [], this.centroCosto = ""});
}

class ItemFacturaInitialState extends ItemFacturaState {
  const ItemFacturaInitialState();

  @override
  List<Object> get props => [];
}

class ItemFacturaLoadingState extends ItemFacturaState {
  const ItemFacturaLoadingState();

  @override
  List<Object> get props => [];
}

class ItemFacturaSuccesState extends ItemFacturaState {
  const ItemFacturaSuccesState({super.itemDocumentos, super.centroCosto});

  @override
  List<Object> get props => [itemDocumentos, centroCosto];
}

part of 'item_factura_bloc.dart';

sealed class ItemFacturaState extends Equatable {
  final List<PreFactura> preFacturas;
  const ItemFacturaState({this.preFacturas = const []});
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
  const ItemFacturaSuccesState({super.preFacturas});

  @override
  List<Object> get props => [super.preFacturas];
}

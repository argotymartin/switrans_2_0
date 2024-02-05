part of 'item_factura_bloc.dart';

sealed class ItemFacturaState extends Equatable {
  final List<Documento> remesas;
  const ItemFacturaState({this.remesas = const []});

  @override
  List<Object> get props => [];
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
  const ItemFacturaSuccesState({super.remesas});

  @override
  List<Object> get props => [];
}

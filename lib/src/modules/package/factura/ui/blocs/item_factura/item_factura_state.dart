part of 'item_factura_bloc.dart';

sealed class ItemFacturaState extends Equatable {
  final List<Documento> documentosTransporte;
  final List<Documento> documentosAdicionales;
  const ItemFacturaState({this.documentosTransporte = const [], this.documentosAdicionales = const []});
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
  const ItemFacturaSuccesState({super.documentosTransporte, super.documentosAdicionales});

  @override
  List<Object> get props => [super.documentosTransporte, super.documentosAdicionales];
}

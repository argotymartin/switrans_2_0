part of 'item_documento_bloc.dart';

sealed class ItemDocumentoState extends Equatable {
  final List<ItemDocumento> itemDocumentos;
  final String centroCosto;
  const ItemDocumentoState({this.itemDocumentos = const [], this.centroCosto = ""});
}

class ItemDocumentoInitialState extends ItemDocumentoState {
  const ItemDocumentoInitialState();

  @override
  List<Object> get props => [];
}

class ItemDocumentoLoadingState extends ItemDocumentoState {
  const ItemDocumentoLoadingState();

  @override
  List<Object> get props => [];
}

class ItemDocumentoSuccesState extends ItemDocumentoState {
  const ItemDocumentoSuccesState({super.itemDocumentos, super.centroCosto});

  @override
  List<Object> get props => [itemDocumentos, centroCosto];
}

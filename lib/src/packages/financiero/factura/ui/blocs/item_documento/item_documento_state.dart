part of 'item_documento_bloc.dart';

sealed class ItemDocumentoState extends Equatable {
  final List<ItemDocumento> itemDocumentos;
  const ItemDocumentoState({this.itemDocumentos = const []});
}

class ItemDocumentoInitialState extends ItemDocumentoState {
  const ItemDocumentoInitialState();

  @override
  List<Object> get props => [];
}

class ItemDocumentoLoadingState extends ItemDocumentoState {
  const ItemDocumentoLoadingState({super.itemDocumentos});

  @override
  List<Object> get props => [];
}

class ItemDocumentoSuccesState extends ItemDocumentoState {
  const ItemDocumentoSuccesState({super.itemDocumentos});

  @override
  List<Object> get props => [itemDocumentos];
}

part of 'item_documento_bloc.dart';

sealed class ItemDocumentoState extends Equatable {
  final List<ItemDocumento> itemDocumentos;
  const ItemDocumentoState({this.itemDocumentos = const <ItemDocumento>[]});
}

class ItemDocumentoInitialState extends ItemDocumentoState {
  const ItemDocumentoInitialState();

  @override
  List<Object> get props => <Object>[];
}

class ItemDocumentoLoadingState extends ItemDocumentoState {
  const ItemDocumentoLoadingState({super.itemDocumentos});

  @override
  List<Object> get props => <Object>[];
}

class ItemDocumentoSuccesState extends ItemDocumentoState {
  const ItemDocumentoSuccesState({super.itemDocumentos});

  @override
  List<Object> get props => <Object>[itemDocumentos];
}

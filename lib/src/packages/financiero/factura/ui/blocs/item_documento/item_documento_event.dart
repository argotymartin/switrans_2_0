part of 'item_documento_bloc.dart';

sealed class ItemDocumentoEvent extends Equatable {
  const ItemDocumentoEvent();

  @override
  List<Object> get props => <Object>[];
}

class GetItemDocumentoEvent extends ItemDocumentoEvent {
  const GetItemDocumentoEvent();
}

class ResetDocumentoEvent extends ItemDocumentoEvent {
  const ResetDocumentoEvent();
}

class AddItemServicioAdicionalFacturaEvent extends ItemDocumentoEvent {
  const AddItemServicioAdicionalFacturaEvent();
}

class AddItemTransporteFacturaEvent extends ItemDocumentoEvent {
  final Documento documento;
  const AddItemTransporteFacturaEvent({required this.documento});
}

class RemoveItemDocumentoEvent extends ItemDocumentoEvent {
  final Documento documento;
  const RemoveItemDocumentoEvent({required this.documento});
}

class ChangedItemDocumentoEvent extends ItemDocumentoEvent {
  final ItemDocumento itemDocumento;
  const ChangedItemDocumentoEvent({required this.itemDocumento});
}

class ChangedDelayItemDocumentoEvent extends ItemDocumentoEvent {
  final ItemDocumento itemDocumento;
  const ChangedDelayItemDocumentoEvent({required this.itemDocumento});
}

class RemoveItemByPositionFacturaEvent extends ItemDocumentoEvent {
  final int index;
  const RemoveItemByPositionFacturaEvent({required this.index});
}

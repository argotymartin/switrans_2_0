part of 'item_factura_bloc.dart';

sealed class ItemFacturaEvent extends Equatable {
  const ItemFacturaEvent();

  @override
  List<Object> get props => [];
}

class GetItemFacturaEvent extends ItemFacturaEvent {
  const GetItemFacturaEvent();
}

class AddItemServicioAdicionalFacturaEvent extends ItemFacturaEvent {
  const AddItemServicioAdicionalFacturaEvent();
}

class AddItemTransporteFacturaEvent extends ItemFacturaEvent {
  final Documento documento;
  const AddItemTransporteFacturaEvent({required this.documento});
}

class RemoveItemFacturaEvent extends ItemFacturaEvent {
  final Documento documento;
  const RemoveItemFacturaEvent({required this.documento});
}

class ChangedItemFacturaEvent extends ItemFacturaEvent {
  final ItemDocumento itemDocumento;
  const ChangedItemFacturaEvent({required this.itemDocumento});
}

class ChangedDelayItemFacturaEvent extends ItemFacturaEvent {
  final ItemDocumento itemDocumento;
  const ChangedDelayItemFacturaEvent({required this.itemDocumento});
}

class RemoveItemByPositionFacturaEvent extends ItemFacturaEvent {
  final int index;
  const RemoveItemByPositionFacturaEvent({required this.index});
}

class SelectCentroCostoItemFacturaEvent extends ItemFacturaEvent {
  final String centroCosto;
  const SelectCentroCostoItemFacturaEvent({required this.centroCosto});
}

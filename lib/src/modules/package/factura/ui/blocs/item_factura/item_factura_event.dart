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
  final PreFactura preFactura;
  const AddItemTransporteFacturaEvent({required this.preFactura});
}

class RemoveItemFacturaEvent extends ItemFacturaEvent {
  final PreFactura preFactura;
  const RemoveItemFacturaEvent({required this.preFactura});
}

class RemoveItemByPositionFacturaEvent extends ItemFacturaEvent {
  final int index;
  const RemoveItemByPositionFacturaEvent({required this.index});
}

class SelectCentroCostoItemFacturaEvent extends ItemFacturaEvent {
  final String centroCosto;
  const SelectCentroCostoItemFacturaEvent({required this.centroCosto});
}

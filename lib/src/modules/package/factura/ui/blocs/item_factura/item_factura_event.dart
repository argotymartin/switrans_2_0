part of 'item_factura_bloc.dart';

sealed class ItemFacturaEvent extends Equatable {
  const ItemFacturaEvent();

  @override
  List<Object> get props => [];
}

class GetItemFacturaEvent extends ItemFacturaEvent {
  const GetItemFacturaEvent();
}

class AddItemFacturaEvent extends ItemFacturaEvent {
  final PreFactura preFactura;
  const AddItemFacturaEvent({required this.preFactura});
}

class RemoveItemFacturaEvent extends ItemFacturaEvent {
  final PreFactura preFactura;
  const RemoveItemFacturaEvent({required this.preFactura});
}

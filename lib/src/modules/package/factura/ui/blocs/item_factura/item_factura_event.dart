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
  final Documento documento;
  const AddItemFacturaEvent({required this.documento});
}

class RemoveItemFacturaEvent extends ItemFacturaEvent {
  final Documento documento;
  const RemoveItemFacturaEvent({required this.documento});
}

class AddServicioAdicionalItemFacturaEvent extends ItemFacturaEvent {
  const AddServicioAdicionalItemFacturaEvent();
}

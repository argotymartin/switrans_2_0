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
  final Remesa remesa;
  const AddItemFacturaEvent({required this.remesa});
}

class RemoveItemFacturaEvent extends ItemFacturaEvent {
  final Remesa remesa;
  const RemoveItemFacturaEvent({required this.remesa});
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/entities/pre_factura.dart';

part 'item_factura_event.dart';
part 'item_factura_state.dart';

class ItemFacturaBloc extends Bloc<ItemFacturaEvent, ItemFacturaState> {
  ItemFacturaBloc() : super(const ItemFacturaInitialState()) {
    on<ItemFacturaEvent>((event, emit) {});
    on<AddItemFacturaEvent>((event, emit) {
      final List<PreFactura> preFacturas = List.from(state.preFacturas);
      if (!preFacturas.contains(event.preFactura)) {
        preFacturas.add(event.preFactura);
      }

      emit(const ItemFacturaLoadingState());
      emit(ItemFacturaSuccesState(preFacturas: preFacturas));
    });

    on<RemoveItemFacturaEvent>((event, emit) {
      final List<PreFactura> prefacturas = List.from(state.preFacturas)
        ..removeWhere((element) => element.documento == event.preFactura.documento);
      emit(const ItemFacturaLoadingState());
      emit(ItemFacturaSuccesState(preFacturas: prefacturas));
    });
  }
}

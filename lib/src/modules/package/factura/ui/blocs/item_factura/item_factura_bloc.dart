import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/entities/pre_factura.dart';
import 'package:switrans_2_0/src/modules/package/factura/ui/factura_ui.dart';

part 'item_factura_event.dart';
part 'item_factura_state.dart';

class ItemFacturaBloc extends Bloc<ItemFacturaEvent, ItemFacturaState> {
  final FacturaBloc facturaBloc;
  ItemFacturaBloc(this.facturaBloc) : super(const ItemFacturaInitialState()) {
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
      final List<PreFactura> prefacturas = List.from(state.preFacturas)..remove(event.preFactura);
      emit(const ItemFacturaLoadingState());
      emit(ItemFacturaSuccesState(preFacturas: prefacturas));
    });
  }
}

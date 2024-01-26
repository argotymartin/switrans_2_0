import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/entities/factuta_entities.dart';

part 'item_factura_event.dart';
part 'item_factura_state.dart';

class ItemFacturaBloc extends Bloc<ItemFacturaEvent, ItemFacturaState> {
  ItemFacturaBloc() : super(const ItemFacturaInitialState()) {
    on<ItemFacturaEvent>((event, emit) {});

    on<AddItemFacturaEvent>((event, emit) {
      final List<Remesa> remesasState = List.from(state.remesas);
      if (!remesasState.contains(event.remesa)) {
        remesasState.add(event.remesa);
      }
      emit(const ItemFacturaLoadingState());
      emit(ItemFacturaSuccesState(remesas: remesasState));
    });

    on<RemoveItemFacturaEvent>((event, emit) {
      final List<Remesa> remesasState = List.from(state.remesas)..remove(event.remesa);
      emit(const ItemFacturaLoadingState());
      emit(ItemFacturaSuccesState(remesas: remesasState));
    });
  }
}

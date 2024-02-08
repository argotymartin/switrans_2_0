import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/entities/factuta_entities.dart';
import 'package:switrans_2_0/src/modules/package/factura/ui/factura_ui.dart';

part 'item_factura_event.dart';
part 'item_factura_state.dart';

class ItemFacturaBloc extends Bloc<ItemFacturaEvent, ItemFacturaState> {
  final FacturaBloc facturaBloc;
  ItemFacturaBloc(this.facturaBloc) : super(const ItemFacturaInitialState()) {
    on<ItemFacturaEvent>((event, emit) {});

    on<AddItemFacturaEvent>((event, emit) {
      final List<Documento> documentosTransporte = List.from(state.documentosTransporte);
      if (!documentosTransporte.contains(event.documento)) {
        documentosTransporte.add(event.documento);
      }
      emit(const ItemFacturaLoadingState());
      emit(ItemFacturaSuccesState(documentosTransporte: documentosTransporte));
    });

    on<RemoveItemFacturaEvent>((event, emit) {
      final List<Documento> remesasState = List.from(state.documentosTransporte)..remove(event.documento);
      emit(const ItemFacturaLoadingState());
      emit(ItemFacturaSuccesState(documentosTransporte: remesasState));
    });

    on<AddServicioAdicionalItemFacturaEvent>((event, emit) {
      final List<Documento> documentosTransporte = List.from(state.documentosTransporte);

      //final List<Documento> remesasState = List.from(state.documentosTransporte)..remove(event.remesa);
      emit(const ItemFacturaLoadingState());
      emit(ItemFacturaSuccesState(
        documentosAdicionales: facturaBloc.state.documentos,
        documentosTransporte: documentosTransporte,
      ));
    });
  }
}

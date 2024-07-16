import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/data/models/item_documento_model.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';

part 'item_documento_event.dart';
part 'item_documento_state.dart';

class ItemDocumentoBloc extends Bloc<ItemDocumentoEvent, ItemDocumentoState> {
  ItemDocumentoBloc() : super(const ItemDocumentoInitialState()) {
    on<AddItemTransporteFacturaEvent>((AddItemTransporteFacturaEvent event, Emitter<ItemDocumentoState> emit) {
      final List<ItemDocumento> itemDocumentos = <ItemDocumento>[...state.itemDocumentos];
      final ItemDocumento prefactura = ItemDocumentoModel.toDocumetnoTR(event.documento);
      if (!itemDocumentos.contains(prefactura)) {
        itemDocumentos.add(prefactura);
      }

      emit(const ItemDocumentoLoadingState());
      emit(ItemDocumentoSuccesState(itemDocumentos: itemDocumentos));
      //_formBloc.animationController.forward();
    });

    on<AddItemServicioAdicionalFacturaEvent>((AddItemServicioAdicionalFacturaEvent event, Emitter<ItemDocumentoState> emit) async {
      final List<ItemDocumento> preFacturas = <ItemDocumento>[...state.itemDocumentos];
      final ItemDocumento preFactura = ItemDocumentoModel.init();
      if (!preFacturas.contains(preFactura)) {
        preFacturas.add(preFactura);
      }

      emit(const ItemDocumentoLoadingState());
      emit(ItemDocumentoSuccesState(itemDocumentos: preFacturas));
      // _formBloc.animationController.forward();
    });

    on<RemoveItemDocumentoEvent>((RemoveItemDocumentoEvent event, Emitter<ItemDocumentoState> emit) {
      final List<ItemDocumento> preFacturas = <ItemDocumento>[...state.itemDocumentos];
      final ItemDocumento prefactura = ItemDocumentoModel.toDocumetnoTR(event.documento);
      final List<ItemDocumento> newPrefacturas = preFacturas
        ..removeWhere((ItemDocumento element) => element.documento == prefactura.documento);
      emit(const ItemDocumentoLoadingState());
      emit(ItemDocumentoSuccesState(itemDocumentos: newPrefacturas));
    });

    on<RemoveItemByPositionFacturaEvent>((RemoveItemByPositionFacturaEvent event, Emitter<ItemDocumentoState> emit) async {
      final int index = event.index - 1;
      final List<ItemDocumento> itemDocumentos = <ItemDocumento>[...state.itemDocumentos];

      emit(const ItemDocumentoLoadingState());
      await Future<dynamic>.delayed(const Duration(milliseconds: 100));
      final List<ItemDocumento> newItemDocumentos = itemDocumentos..removeAt(index);
      emit(ItemDocumentoSuccesState(itemDocumentos: newItemDocumentos));
      //_formBloc.animationController.forward();
    });

    on<ChangedItemDocumentoEvent>((ChangedItemDocumentoEvent event, Emitter<ItemDocumentoState> emit) async {
      final List<ItemDocumento> itemDocumentos = <ItemDocumento>[...state.itemDocumentos];
      emit(const ItemDocumentoLoadingState());
      emit(ItemDocumentoSuccesState(itemDocumentos: itemDocumentos));
    });

    on<GetItemDocumentoEvent>((GetItemDocumentoEvent event, Emitter<ItemDocumentoState> emit) async {
      final List<ItemDocumento> itemDocumentos = <ItemDocumento>[...state.itemDocumentos];
      emit(const ItemDocumentoLoadingState());
      emit(ItemDocumentoSuccesState(itemDocumentos: itemDocumentos));
    });

    on<ResetDocumentoEvent>((ResetDocumentoEvent event, Emitter<ItemDocumentoState> emit) async {
      emit(const ItemDocumentoLoadingState());
      emit(const ItemDocumentoInitialState());
    });
  }
}

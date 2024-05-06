import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/data/models/item_documento_model.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/factura_ui.dart';

part 'item_documento_event.dart';
part 'item_documento_state.dart';

class ItemDocumentoBloc extends Bloc<ItemDocumentoEvent, ItemDocumentoState> {
  final FormFacturaBloc _formBloc;
  ItemDocumentoBloc(this._formBloc) : super(const ItemDocumentoInitialState()) {
    on<AddItemTransporteFacturaEvent>((event, emit) {
      final List<ItemDocumento> itemDocumentos = [...state.itemDocumentos];
      ItemDocumento prefactura = ItemDocumentoModel.toDocumetnoTR(event.documento);
      if (!itemDocumentos.contains(prefactura)) {
        itemDocumentos.add(prefactura);
      }

      emit(const ItemDocumentoLoadingState());
      emit(ItemDocumentoSuccesState(itemDocumentos: itemDocumentos));
      _formBloc.animationController.forward();
    });

    on<AddItemServicioAdicionalFacturaEvent>((event, emit) async {
      final List<ItemDocumento> preFacturas = [...state.itemDocumentos];
      ItemDocumento preFactura = ItemDocumentoModel.init();
      if (!preFacturas.contains(preFactura)) {
        preFacturas.add(preFactura);
      }

      emit(const ItemDocumentoLoadingState());
      emit(ItemDocumentoSuccesState(itemDocumentos: preFacturas));
      // _formBloc.animationController.forward();
    });

    on<RemoveItemDocumentoEvent>((event, emit) {
      final List<ItemDocumento> preFacturas = [...state.itemDocumentos];
      ItemDocumento prefactura = ItemDocumentoModel.toDocumetnoTR(event.documento);
      final newPrefacturas = preFacturas..removeWhere((element) => element.documento == prefactura.documento);
      emit(const ItemDocumentoLoadingState());
      emit(ItemDocumentoSuccesState(itemDocumentos: newPrefacturas));
    });

    on<RemoveItemByPositionFacturaEvent>((event, emit) async {
      int index = event.index - 1;
      final List<ItemDocumento> itemDocumentos = [...state.itemDocumentos];

      emit(const ItemDocumentoLoadingState());
      await Future.delayed(const Duration(milliseconds: 100));
      final newItemDocumentos = itemDocumentos..removeAt(index);
      emit(ItemDocumentoSuccesState(itemDocumentos: newItemDocumentos));
      //_formBloc.animationController.forward();
    });

    on<ChangedItemDocumentoEvent>((event, emit) async {
      final List<ItemDocumento> itemDocumentos = [...state.itemDocumentos];
      emit(const ItemDocumentoLoadingState());
      emit(ItemDocumentoSuccesState(itemDocumentos: itemDocumentos));
    });

    on<GetItemDocumentoEvent>((event, emit) async {
      final List<ItemDocumento> itemDocumentos = [...state.itemDocumentos];
      emit(const ItemDocumentoLoadingState());
      emit(ItemDocumentoSuccesState(itemDocumentos: itemDocumentos));
    });

    on<ResetDocumentoEvent>((event, emit) async {
      emit(const ItemDocumentoLoadingState());
      emit(const ItemDocumentoInitialState());
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/modules/package/factura/data/models/item_documento_model.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/entities/factura_entities.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/entities/item_documento.dart';
import 'package:switrans_2_0/src/modules/package/factura/ui/factura_ui.dart';

part 'item_factura_event.dart';
part 'item_factura_state.dart';

class ItemFacturaBloc extends Bloc<ItemFacturaEvent, ItemFacturaState> {
  final FormFacturaBloc _formBloc;
  ItemFacturaBloc(this._formBloc) : super(const ItemFacturaInitialState()) {
    on<AddItemTransporteFacturaEvent>((event, emit) {
      final List<ItemDocumento> itemDocumentos = [...state.itemDocumentos];
      String centroCosto = state.centroCosto;
      ItemDocumento prefactura = ItemDocumentoModel.toDocumetnoTR(event.documento);
      if (!itemDocumentos.contains(prefactura)) itemDocumentos.add(prefactura);

      emit(const ItemFacturaLoadingState());
      emit(ItemFacturaSuccesState(itemDocumentos: itemDocumentos, centroCosto: centroCosto));
      _formBloc.animationController.forward();
    });

    on<AddItemServicioAdicionalFacturaEvent>((event, emit) async {
      final List<ItemDocumento> preFacturas = [...state.itemDocumentos];
      String centroCosto = state.centroCosto;
      ItemDocumento preFactura = ItemDocumentoModel.init();
      preFactura.tipo = "SA";
      if (!preFacturas.contains(preFactura)) preFacturas.add(preFactura);

      emit(const ItemFacturaLoadingState());
      emit(ItemFacturaSuccesState(itemDocumentos: preFacturas, centroCosto: centroCosto));
      _formBloc.animationController.forward();
    });

    on<RemoveItemFacturaEvent>((event, emit) {
      final List<ItemDocumento> preFacturas = [...state.itemDocumentos];
      String centroCosto = state.centroCosto;
      ItemDocumento prefactura = ItemDocumentoModel.toDocumetnoTR(event.documento);
      final newPrefacturas = preFacturas..removeWhere((element) => element.documento == prefactura.documento);
      emit(const ItemFacturaLoadingState());
      emit(ItemFacturaSuccesState(itemDocumentos: newPrefacturas, centroCosto: centroCosto));
    });

    on<RemoveItemByPositionFacturaEvent>((event, emit) async {
      int index = event.index - 1;
      final List<ItemDocumento> itemDocumentos = [...state.itemDocumentos];

      String centroCosto = state.centroCosto;
      emit(const ItemFacturaLoadingState());
      await Future.delayed(const Duration(milliseconds: 100));
      final newItemDocumentos = itemDocumentos..removeAt(index);
      emit(ItemFacturaSuccesState(itemDocumentos: newItemDocumentos, centroCosto: centroCosto));
    });

    on<SelectCentroCostoItemFacturaEvent>((event, emit) {
      final List<ItemDocumento> itemDocumentos = [...state.itemDocumentos];
      emit(const ItemFacturaLoadingState());
      emit(ItemFacturaSuccesState(itemDocumentos: itemDocumentos, centroCosto: event.centroCosto));
    });

    on<ChangedItemFacturaEvent>((event, emit) async {
      final List<ItemDocumento> itemDocumentos = [...state.itemDocumentos];
      String centroCosto = state.centroCosto;
      emit(const ItemFacturaLoadingState());
      emit(ItemFacturaSuccesState(itemDocumentos: itemDocumentos, centroCosto: centroCosto));
    });

    on<ChangedDelayItemFacturaEvent>((event, emit) async {
      final List<ItemDocumento> itemDocumentos = [...state.itemDocumentos];
      String centroCosto = state.centroCosto;
      emit(const ItemFacturaLoadingState());
      await Future.delayed(const Duration(milliseconds: 20));
      emit(ItemFacturaSuccesState(itemDocumentos: itemDocumentos, centroCosto: centroCosto));
    });
  }
}

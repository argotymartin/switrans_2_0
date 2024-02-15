import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/modules/package/factura/data/models/pre_factura_model.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/entities/pre_factura.dart';
import 'package:switrans_2_0/src/modules/package/factura/ui/factura_ui.dart';

part 'item_factura_event.dart';
part 'item_factura_state.dart';

class ItemFacturaBloc extends Bloc<ItemFacturaEvent, ItemFacturaState> {
  final FormFacturaBloc _formBloc;
  ItemFacturaBloc(this._formBloc) : super(const ItemFacturaInitialState()) {
    final List<PreFactura> preFacturas = List.from(state.preFacturas);
    String centroCosto = state.centroCosto;
    on<ItemFacturaEvent>((event, emit) {});

    on<AddItemTransporteFacturaEvent>((event, emit) {
      PreFactura preFactura = event.preFactura;
      preFactura.tipo = "TR";
      if (!preFacturas.contains(event.preFactura)) preFacturas.add(event.preFactura);

      emit(const ItemFacturaLoadingState());
      emit(ItemFacturaSuccesState(preFacturas: preFacturas, centroCosto: centroCosto));
      _formBloc.animationController.forward();
    });

    on<AddItemServicioAdicionalFacturaEvent>((event, emit) async {
      PreFactura preFactura = PreFacturaModel.init();
      preFactura.tipo = "SA";
      if (!preFacturas.contains(preFactura)) preFacturas.add(preFactura);

      emit(const ItemFacturaLoadingState());
      emit(ItemFacturaSuccesState(preFacturas: preFacturas, centroCosto: centroCosto));
      //_formBloc.animationController.forward();
    });

    on<RemoveItemFacturaEvent>((event, emit) {
      final newPrefacturas = preFacturas..removeWhere((element) => element.documento == event.preFactura.documento);
      emit(const ItemFacturaLoadingState());
      emit(ItemFacturaSuccesState(preFacturas: newPrefacturas, centroCosto: centroCosto));
    });

    on<RemoveItemByPositionFacturaEvent>((event, emit) {
      preFacturas.removeAt(event.index);
      emit(const ItemFacturaLoadingState());
      emit(ItemFacturaSuccesState(preFacturas: preFacturas, centroCosto: centroCosto));
    });

    on<SelectCentroCostoItemFacturaEvent>((event, emit) {
      emit(const ItemFacturaLoadingState());
      emit(ItemFacturaSuccesState(preFacturas: preFacturas, centroCosto: event.centroCosto));
    });

    on<ChangedItemFacturaEvent>((event, emit) async {
      emit(const ItemFacturaLoadingState());
      emit(ItemFacturaSuccesState(preFacturas: preFacturas, centroCosto: centroCosto));
    });
  }
}

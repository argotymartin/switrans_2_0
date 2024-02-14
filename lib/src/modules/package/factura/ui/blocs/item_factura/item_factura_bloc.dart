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
    on<ItemFacturaEvent>((event, emit) {});

    on<AddItemTransporteFacturaEvent>((event, emit) {
      PreFactura preFactura = event.preFactura;
      preFactura.tipo = "TR";
      final List<PreFactura> preFacturas = List.from(state.preFacturas);
      if (!preFacturas.contains(event.preFactura)) preFacturas.add(event.preFactura);

      emit(const ItemFacturaLoadingState());
      emit(ItemFacturaSuccesState(preFacturas: preFacturas, centroCosto: state.centroCosto));
      _formBloc.animationController.forward();
    });

    on<AddItemServicioAdicionalFacturaEvent>((event, emit) {
      PreFactura preFactura = PreFacturaModel.init();
      preFactura.tipo = "SA";

      final List<PreFactura> preFacturas = List.from(state.preFacturas);
      if (!preFacturas.contains(preFactura)) preFacturas.add(preFactura);

      emit(const ItemFacturaLoadingState());
      emit(ItemFacturaSuccesState(preFacturas: preFacturas, centroCosto: state.centroCosto));
      _formBloc.animationController.forward();
    });

    on<RemoveItemFacturaEvent>((event, emit) async {
      final List<PreFactura> prefacturas = List.from(state.preFacturas)
        ..removeWhere((element) => element.documento == event.preFactura.documento);
      emit(const ItemFacturaLoadingState());
      await Future.delayed(const Duration(milliseconds: 100));
      emit(ItemFacturaSuccesState(preFacturas: prefacturas, centroCosto: state.centroCosto));
    });

    on<RemoveItemByPositionFacturaEvent>((event, emit) {
      final List<PreFactura> prefacturas = List.from(state.preFacturas);
      prefacturas.removeAt(event.index);
      emit(const ItemFacturaLoadingState());
      emit(ItemFacturaSuccesState(preFacturas: prefacturas, centroCosto: state.centroCosto));
    });

    on<SelectCentroCostoItemFacturaEvent>((event, emit) {
      final List<PreFactura> prefacturas = List.from(state.preFacturas);
      emit(const ItemFacturaLoadingState());
      emit(ItemFacturaSuccesState(preFacturas: prefacturas, centroCosto: event.centroCosto));
    });
  }
}

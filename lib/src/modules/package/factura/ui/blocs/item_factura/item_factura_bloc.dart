import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/modules/package/factura/data/models/pre_factura_model.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/entities/factuta_entities.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/entities/pre_factura.dart';
import 'package:switrans_2_0/src/modules/package/factura/ui/factura_ui.dart';

part 'item_factura_event.dart';
part 'item_factura_state.dart';

class ItemFacturaBloc extends Bloc<ItemFacturaEvent, ItemFacturaState> {
  final FormFacturaBloc _formBloc;
  ItemFacturaBloc(this._formBloc) : super(const ItemFacturaInitialState()) {
    on<ItemFacturaEvent>((event, emit) {});

    on<AddItemTransporteFacturaEvent>((event, emit) {
      final List<PreFactura> preFacturas = List.from(state.preFacturas);
      String centroCosto = state.centroCosto;
      PreFactura prefactura = PreFacturaModel.toDocumetnoTR(event.documento);
      if (!preFacturas.contains(prefactura)) preFacturas.add(prefactura);

      emit(const ItemFacturaLoadingState());
      emit(ItemFacturaSuccesState(preFacturas: preFacturas, centroCosto: centroCosto));
      _formBloc.animationController.forward();
    });

    on<AddItemServicioAdicionalFacturaEvent>((event, emit) async {
      final List<PreFactura> preFacturas = List.from(state.preFacturas);
      String centroCosto = state.centroCosto;
      PreFactura preFactura = PreFacturaModel.init();
      preFactura.tipo = "SA";
      if (!preFacturas.contains(preFactura)) preFacturas.add(preFactura);

      emit(const ItemFacturaLoadingState());
      emit(ItemFacturaSuccesState(preFacturas: preFacturas, centroCosto: centroCosto));
      //_formBloc.animationController.forward();
    });

    on<RemoveItemFacturaEvent>((event, emit) {
      final List<PreFactura> preFacturas = List.from(state.preFacturas);
      String centroCosto = state.centroCosto;
      PreFactura prefactura = PreFacturaModel.toDocumetnoTR(event.documento);
      final newPrefacturas = preFacturas..removeWhere((element) => element.documento == prefactura.documento);
      emit(const ItemFacturaLoadingState());
      emit(ItemFacturaSuccesState(preFacturas: newPrefacturas, centroCosto: centroCosto));
    });

    on<RemoveItemByPositionFacturaEvent>((event, emit) async {
      int index = event.index - 1;
      final List<PreFactura> preFacturas = List.from(state.preFacturas);

      String centroCosto = state.centroCosto;
      emit(const ItemFacturaLoadingState());
      await Future.delayed(const Duration(milliseconds: 100));
      final newPrefacturas = preFacturas..removeAt(index);
      emit(ItemFacturaSuccesState(preFacturas: newPrefacturas, centroCosto: centroCosto));
    });

    on<SelectCentroCostoItemFacturaEvent>((event, emit) {
      final List<PreFactura> preFacturas = List.from(state.preFacturas);
      emit(const ItemFacturaLoadingState());
      emit(ItemFacturaSuccesState(preFacturas: preFacturas, centroCosto: event.centroCosto));
    });

    on<ChangedItemFacturaEvent>((event, emit) async {
      final List<PreFactura> preFacturas = List.from(state.preFacturas);
      String centroCosto = state.centroCosto;
      emit(const ItemFacturaLoadingState());
      emit(ItemFacturaSuccesState(preFacturas: preFacturas, centroCosto: centroCosto));
    });

    on<ChangedDelayItemFacturaEvent>((event, emit) async {
      final List<PreFactura> preFacturas = [...state.preFacturas];
      String centroCosto = state.centroCosto;
      emit(const ItemFacturaLoadingState());
      //await Future.delayed(const Duration(milliseconds: 200));
      emit(ItemFacturaSuccesState(preFacturas: preFacturas, centroCosto: centroCosto));
    });
  }
}

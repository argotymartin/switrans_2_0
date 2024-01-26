import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/entities/factuta_entities.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/repositories/abstract_factura_repository.dart';

part 'filter_factura_event.dart';
part 'filter_factura_state.dart';

class FilterFacturaBloc extends Bloc<FilterFacturaEvent, FilterFacturaState> {
  final AbstractFacturaRepository _repository;
  FilterFacturaBloc(this._repository) : super(FiltersFacturaInitial()) {
    on<FilterFacturaEvent>((event, emit) {});

    on<ActiveteFilterFacturaEvent>((event, emit) async {
      emit(const FiltersFacturaLoadingState());
      final dataStateClientes = await _repository.getClientes();
      final dataStateEmpresas = await _repository.getEmpresasService();
      emit(FiltersFacturaInitialState(clientes: dataStateClientes.data!, empresas: dataStateEmpresas.data!));
    });

    on<PanelFilterFacturaEvent>((event, emit) {
      emit(const FiltersFacturaPanelOpenState(isPanelOpen: false));
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/entities/factuta_entities.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/repositories/abstract_factura_repository.dart';

part 'filters_factura_event.dart';
part 'filters_factura_state.dart';

class FiltersFacturaBloc extends Bloc<FiltersFacturaEvent, FiltersFacturaState> {
  final AbstractFacturaRepository _repository;
  FiltersFacturaBloc(this._repository) : super(FiltersFacturaInitial()) {
    on<FiltersFacturaEvent>((event, emit) {});

    on<ActiveteFiltersFacturaEvent>((event, emit) async {
      emit(const FiltersFacturaLoadingState());
      final dataStateClientes = await _repository.getClientes();
      final dataStateEmpresas = await _repository.getEmpresasService();
      emit(FiltersFacturaInitialState(clientes: dataStateClientes.data!, empresas: dataStateEmpresas.data!));
    });
  }
}

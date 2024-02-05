import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/entities/factuta_entities.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/repositories/abstract_factura_repository.dart';

part 'factura_event.dart';
part 'factura_state.dart';

class FacturaBloc extends Bloc<FacturaEvent, FacturaState> {
  final AbstractFacturaRepository _repository;
  FacturaBloc(this._repository) : super(FacturaInitial()) {
    on<FacturaEvent>((event, emit) {});
    on<ActiveteFacturaEvent>((event, emit) async {
      emit(const FacturaLoadingState());
      final resp = await _repository.getDocumentosService(event.request);
      emit(FacturaSuccesState(remesas: resp.data!));
    });
  }
}

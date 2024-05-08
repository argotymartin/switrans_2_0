import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/packages/maestro/tipo_impuesto/domain/entities/request/tipo_impuesto_request.dart';
import 'package:switrans_2_0/src/packages/maestro/tipo_impuesto/domain/entities/tipo_impuesto.dart';
import 'package:switrans_2_0/src/packages/maestro/tipo_impuesto/domain/repositories/abstract_tipo_impuesto_repository.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

part 'tipo_impuesto_event.dart';
part 'tipo_impuesto_state.dart';

class TipoImpuestoBloc extends Bloc<TipoImpuestoEvent, TipoImpuestoState> {
  final AbstractTipoImpuestoRepository _repository;
  TipoImpuestoBloc(this._repository) : super(const TipoImpuestoInitialState()) {
    on<SetImpuestoEvent>((SetImpuestoEvent event, Emitter<TipoImpuestoState> emit) async {
      emit(const TipoImpuestoLoadingState());
      final DataState<TipoImpuesto> resp = await _repository.setTipoImpuestoService(event.request);
      if (resp.data != null) {
        emit(TipoImpuestoSuccesState(tipoImpuesto: resp.data));
      } else {
        emit(TipoImpuestoExceptionState(exception: resp.error));
      }
    });

    on<GetImpuestoEvent>((GetImpuestoEvent event, Emitter<TipoImpuestoState> emit) async {
      emit(const TipoImpuestoLoadingState());
      final DataState<List<TipoImpuesto>> resp = await _repository.getTipoImpuestosService(event.request);
      if (resp.data != null) {
        emit(TipoImpuestoConsultedState(tipoImpuestos: resp.data!));
      } else {
        emit(TipoImpuestoExceptionState(exception: resp.error));
      }
    });

    on<ErrorFormTipoImpuestoEvent>((ErrorFormTipoImpuestoEvent event, Emitter<TipoImpuestoState> emit) async {
      emit(const TipoImpuestoLoadingState());
      emit(TipoImpuestoErrorFormState(error: event.error));
    });
  }
}

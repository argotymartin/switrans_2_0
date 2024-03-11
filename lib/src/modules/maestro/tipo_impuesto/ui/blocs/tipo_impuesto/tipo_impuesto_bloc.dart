import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/modules/maestro/tipo_impuesto/domain/entities/request/tipo_impuesto_request.dart';
import 'package:switrans_2_0/src/modules/maestro/tipo_impuesto/domain/entities/tipo_impuesto.dart';
import 'package:switrans_2_0/src/modules/maestro/tipo_impuesto/domain/repositories/abstract_tipo_impuesto_repository.dart';

part 'tipo_impuesto_event.dart';
part 'tipo_impuesto_state.dart';

class TipoImpuestoBloc extends Bloc<TipoImpuestoEvent, TipoImpuestoState> {
  final AbstractTipoImpuestoRepository _repository;
  TipoImpuestoBloc(this._repository) : super(const TipoImpuestoInitialState()) {
    on<SetImpuestoEvent>((event, emit) async {
      emit(const TipoImpuestoLoadingState());
      final resp = await _repository.setTipoImpuestoService(event.request);
      if (resp.data != null) {
        emit(TipoImpuestoSuccesState(tipoImpuesto: resp.data));
      } else {
        emit(TipoImpuestoExceptionState(exception: resp.error));
      }
    });

    on<GetImpuestoEvent>((event, emit) async {
      emit(const TipoImpuestoLoadingState());
      final resp = await _repository.getTipoImpuestosService(event.request);
      if (resp.data != null) {
        emit(TipoImpuestoConsultedState(tipoImpuestos: resp.data!));
      } else {
        emit(TipoImpuestoExceptionState(exception: resp.error));
      }
    });

    on<ErrorFormTipoImpuestoEvent>((event, emit) async {
      emit(const TipoImpuestoLoadingState());
      emit(TipoImpuestoErrorFormState(error: event.error));
    });
  }
}

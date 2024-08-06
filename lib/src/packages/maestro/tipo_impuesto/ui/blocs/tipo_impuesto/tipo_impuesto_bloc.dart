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
  TipoImpuestoRequest _request = TipoImpuestoRequest();
  TipoImpuestoBloc(this._repository) : super(const TipoImpuestoState().initial()) {
    on<InitializationTipoImpuestoEvent>(_onInitialization);
    on<SetImpuestoEvent>(_onSetImpuesto);
    on<GetImpuestoEvent>(_onGetImpuesto);
    on<UpdateImpuestoEvent>(_onUpdateImpuesto);
    on<ErrorFormTipoImpuestoEvent>(_onErrorFormTipoImpuesto);
    on<CleanFormTipoImpuestoEvent>(_onCleanFormTipoImpuesto);
  }

  Future<void> _onInitialization(InitializationTipoImpuestoEvent event, Emitter<TipoImpuestoState> emit) async {
    emit(state.copyWith(status: TipoImpuestoStatus.loading));
    final DataState<List<TipoImpuesto>> resp = await _repository.getTipoImpuestosService(_request);
    if (resp.data != null) {
      emit(state.copyWith(status: TipoImpuestoStatus.consulted, tipoImpuestos: resp.data!));
    } else {
      emit(state.copyWith(status: TipoImpuestoStatus.exception, exception: resp.error));
    }
  }

  Future<void> _onSetImpuesto(SetImpuestoEvent event, Emitter<TipoImpuestoState> emit) async {
    emit(state.copyWith(status: TipoImpuestoStatus.loading));
    final DataState<TipoImpuesto> resp = await _repository.setTipoImpuestoService(event.request);
    if (resp.data != null) {
      emit(state.copyWith(status: TipoImpuestoStatus.succes, tipoImpuesto: resp.data));
    } else {
      emit(state.copyWith(status: TipoImpuestoStatus.exception, exception: resp.error));
    }
  }

  Future<void> _onGetImpuesto(GetImpuestoEvent event, Emitter<TipoImpuestoState> emit) async {
    emit(state.copyWith(status: TipoImpuestoStatus.loading));
    final DataState<List<TipoImpuesto>> resp = await _repository.getTipoImpuestosService(request);
    if (resp.data != null) {
      emit(state.copyWith(status: TipoImpuestoStatus.consulted, tipoImpuestos: resp.data!));
    } else {
      emit(state.copyWith(status: TipoImpuestoStatus.exception, exception: resp.error));
    }
  }

  Future<void> _onUpdateImpuesto(UpdateImpuestoEvent event, Emitter<TipoImpuestoState> emit) async {
    emit(state.copyWith(status: TipoImpuestoStatus.loading));
    final List<DataState<TipoImpuesto>> dataStateList = await Future.wait(
      event.requestList.map((TipoImpuestoRequest request) => _repository.updateTipoImpuestoService(request)),
    );

    final List<TipoImpuesto> tipoImpuestos = <TipoImpuesto>[];
    final List<DioException> exceptions = <DioException>[];

    for (final DataState<TipoImpuesto> dataState in dataStateList) {
      if (dataState.data != null) {
        tipoImpuestos.add(dataState.data!);
      } else {
        exceptions.add(dataState.error!);
      }
    }
    if (tipoImpuestos.isNotEmpty) {
      emit(state.copyWith(status: TipoImpuestoStatus.succes, tipoImpuestos: tipoImpuestos));
    }
    if (exceptions.isNotEmpty) {
      for (final DioException exception in exceptions) {
        emit(state.copyWith(status: TipoImpuestoStatus.exception, exception: exception));
      }
    }
  }

  Future<void> _onErrorFormTipoImpuesto(ErrorFormTipoImpuestoEvent event, Emitter<TipoImpuestoState> emit) async {
    emit(state.copyWith(status: TipoImpuestoStatus.error, error: event.error));
  }

  Future<void> _onCleanFormTipoImpuesto(CleanFormTipoImpuestoEvent event, Emitter<TipoImpuestoState> emit) async {
    request.clean();
    emit(state.copyWith(status: TipoImpuestoStatus.initial, tipoImpuestos: const <TipoImpuesto>[], error: ''));
  }

  TipoImpuestoRequest get request => _request;
  set request(TipoImpuestoRequest value) => _request = value;
}

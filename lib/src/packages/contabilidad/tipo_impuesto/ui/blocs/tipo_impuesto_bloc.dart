import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/packages/contabilidad/tipo_impuesto/domain/domain.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';
import 'package:switrans_2_0/src/util/resources/entity_update.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';

part 'tipo_impuesto_event.dart';
part 'tipo_impuesto_state.dart';

class TipoImpuestoBloc extends Bloc<TipoImpuestoEvent, TipoImpuestoState> {
  final AbstractTipoImpuestoRepository _repository;
  TipoImpuestoRequest _request = TipoImpuestoRequest();

  TipoImpuestoBloc(this._repository) : super(const TipoImpuestoState().initial()) {
    on<InitialTipoImpuestoEvent>(_onInitialTipoImpuesto);
    on<GetTipoImpuestosEvent>(_onGetTipoImpuestos);
    on<SetTipoImpuestoEvent>(_onSetTipoImpuesto);
    on<UpdateTipoImpuestosEvent>(_onUpdateTipoImpuestos);
    on<ErrorFormTipoImpuestoEvent>(_onErrorFormTipoImpuesto);
    on<CleanFormTipoImpuestoEvent>(_onCleanFormTipoImpuesto);
  }

  Future<void> _onInitialTipoImpuesto(InitialTipoImpuestoEvent event, Emitter<TipoImpuestoState> emit) async {
    emit(state.copyWith(status: TipoImpuestoStatus.initial));
  }

  Future<void> _onGetTipoImpuestos(GetTipoImpuestosEvent event, Emitter<TipoImpuestoState> emit) async {
    emit(state.copyWith(status: TipoImpuestoStatus.loading));
    final DataState<List<TipoImpuesto>> response = await _repository.getTipoImpuestosService(event.request);
    if (response.data != null) {
      emit(state.copyWith(status: TipoImpuestoStatus.consulted, tipoImpuestos: response.data));
    } else {
      emit(state.copyWith(status: TipoImpuestoStatus.exception, exception: response.error));
    }
  }

  Future<void> _onSetTipoImpuesto(SetTipoImpuestoEvent event, Emitter<TipoImpuestoState> emit) async {
    emit(state.copyWith(status: TipoImpuestoStatus.loading));
    final DataState<TipoImpuesto> response = await _repository.setTipoImpuestoService(event.request);
    if (response.data != null) {
      emit(state.copyWith(status: TipoImpuestoStatus.succes, tipoImpuesto: response.data));
    } else {
      emit(state.copyWith(status: TipoImpuestoStatus.exception, exception: response.error));
    }
  }

  Future<void> _onUpdateTipoImpuestos(UpdateTipoImpuestosEvent event, Emitter<TipoImpuestoState> emit) async {
    emit(state.copyWith(status: TipoImpuestoStatus.loading));

    final List<DataState<TipoImpuesto>> dataStateList = await Future.wait(
      event.requestList.map((EntityUpdate<TipoImpuestoRequest> request) => _repository.updateTipoImpuestosService(request)),
    );

    final List<TipoImpuesto> tipoImpuestos = <TipoImpuesto>[];
    final List<DioException> exceptions = <DioException>[];

    for (final DataState<TipoImpuesto> dataState in dataStateList) {
      if (dataState.data != null) {
        tipoImpuestos.add(dataState.data!);
      } else if (dataState.error != null) {
        exceptions.add(dataState.error!);
      }
    }

    if (tipoImpuestos.isNotEmpty) {
      emit(state.copyWith(status: TipoImpuestoStatus.consulted, tipoImpuestos: tipoImpuestos));
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
    emit(state.copyWith(status: TipoImpuestoStatus.initial, tipoImpuestos: <TipoImpuesto>[], error: ""));
  }

  TipoImpuestoRequest get request => _request;
  set request(TipoImpuestoRequest value) => _request = value;
}

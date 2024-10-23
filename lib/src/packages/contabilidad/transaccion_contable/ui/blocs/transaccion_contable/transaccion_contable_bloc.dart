import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/packages/contabilidad/transaccion_contable/domain/domain.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';
import 'package:switrans_2_0/src/util/resources/entity_update.dart';
import 'package:switrans_2_0/src/util/shared/models/entry_autocomplete.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';

part 'transaccion_contable_event.dart';
part 'transaccion_contable_state.dart';

class TransaccionContableBloc extends Bloc<TransaccionContableEvent, TransaccionContableState> {
  final AbstractTransaccionContableRepository _repository;
  TransaccionContableRequest _request = TransaccionContableRequest();
  TransaccionContableBloc(this._repository) : super(const TransaccionContableState().initial()) {
    on<InitialTransaccionContableEvent>(_onInitialTransaccionContable);
    on<GetTransaccionContablesEvent>(_onGetTransaccionContables);
    on<SetTransaccionContableEvent>(_onSetTransaccionContable);
    on<UpdateTransaccionContablesEvent>(_onUpdateTransaccionContables);
    on<ErrorFormTransaccionContableEvent>(_onErrorFormTransaccionContable);
    on<CleanFormTransaccionContableEvent>(_onCleanFormTransaccionContable);
  }

  Future<void> _onInitialTransaccionContable(
    InitialTransaccionContableEvent event,
    Emitter<TransaccionContableState> emit,
  ) async {
    emit(state.copyWith(status: TransaccionContableStatus.loading));
    final DataState<List<TransaccionContableTipoImpuesto>> resp = await _repository.getTipoImpuestosService();
    if (resp.data != null) {
      final List<EntryAutocomplete> entriesTipoImpuesto =
          resp.data!.map((TransaccionContableTipoImpuesto t) => EntryAutocomplete(title: t.nombre, codigo: t.codigo)).toList();
      emit(state.copyWith(status: TransaccionContableStatus.initial, entriesTipoImpuestos: entriesTipoImpuesto));
    } else {
      emit(state.copyWith(status: TransaccionContableStatus.exception, exception: resp.error));
    }
  }

  Future<void> _onGetTransaccionContables(GetTransaccionContablesEvent event, Emitter<TransaccionContableState> emit) async {
    emit(state.copyWith(status: TransaccionContableStatus.loading));
    final DataState<List<TransaccionContable>> response = await _repository.getTransaccionContablesService(event.request);
    if (response.data != null) {
      emit(state.copyWith(status: TransaccionContableStatus.consulted, transaccionContables: response.data));
    } else {
      emit(state.copyWith(status: TransaccionContableStatus.exception, exception: response.error));
    }
  }

  Future<void> _onSetTransaccionContable(SetTransaccionContableEvent event, Emitter<TransaccionContableState> emit) async {
    emit(state.copyWith(status: TransaccionContableStatus.loading));
    final DataState<TransaccionContable> response = await _repository.setTransaccionContableService(event.request);
    if (response.data != null) {
      emit(state.copyWith(status: TransaccionContableStatus.succes, transaccionContable: response.data));
    } else {
      emit(state.copyWith(status: TransaccionContableStatus.exception, exception: response.error));
    }
  }

  Future<void> _onUpdateTransaccionContables(UpdateTransaccionContablesEvent event, Emitter<TransaccionContableState> emit) async {
    emit(state.copyWith(status: TransaccionContableStatus.loading));

    final List<DataState<TransaccionContable>> dataStateList = await Future.wait(
      event.requestList.map((EntityUpdate<TransaccionContableRequest> request) => _repository.updateTransaccionContableService(request)),
    );

    final List<TransaccionContable> transaccionContables = <TransaccionContable>[];
    final List<DioException> exceptions = <DioException>[];

    for (final DataState<TransaccionContable> dataState in dataStateList) {
      if (dataState.data != null) {
        transaccionContables.add(dataState.data!);
      } else if (dataState.error != null) {
        exceptions.add(dataState.error!);
      }
    }

    if (transaccionContables.isNotEmpty) {
      emit(state.copyWith(status: TransaccionContableStatus.consulted, transaccionContables: transaccionContables));
    }

    if (exceptions.isNotEmpty) {
      for (final DioException exception in exceptions) {
        emit(state.copyWith(status: TransaccionContableStatus.exception, exception: exception));
      }
    }
  }

  Future<void> _onErrorFormTransaccionContable(ErrorFormTransaccionContableEvent event, Emitter<TransaccionContableState> emit) async {
    emit(state.copyWith(status: TransaccionContableStatus.error, error: event.error));
  }

  Future<void> _onCleanFormTransaccionContable(CleanFormTransaccionContableEvent event, Emitter<TransaccionContableState> emit) async {
    request.clean();
    emit(state.copyWith(status: TransaccionContableStatus.initial, transaccionContables: <TransaccionContable>[], error: ""));
  }

  TransaccionContableRequest get request => _request;
  set request(TransaccionContableRequest value) => _request = value;
}

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/domain/entities/request/transaccion_contable_request.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/domain/entities/transaccion_contable.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/domain/entities/transaccion_contable_tipo_impuesto.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/domain/repositories/abstract_transaccion_contable_repository.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';
import 'package:switrans_2_0/src/util/shared/models/entry_autocomplete.dart';

part 'transaccion_contable_event.dart';
part 'transaccion_contable_state.dart';

class TransaccionContableBloc extends Bloc<TransaccionContableEvent, TransaccionContableState> {
  final AbstractTransaccionContableRepository _repository;
  TransaccionContableRequest _request = TransaccionContableRequest();

  TransaccionContableBloc(this._repository) : super(const TransaccionContableState().initial()) {
    on<InitializationTransaccionContableEvent>(_onInitializationTransaccionContable);
    on<GetTransaccionContableEvent>(_onGetTransaccionContable);
    on<SetTransaccionContableEvent>(_onSetTransaccionContable);
    on<UpdateTransaccionContableEvent>(_onUpdateTransaccionContable);
    on<ErrorFormTransaccionContableEvent>(_onErrorFormTransaccionContable);
    on<CleanFormTransaccionContableEvent>(_onCleanFormTransaccionContable);
  }

  Future<void> _onInitializationTransaccionContable(
    InitializationTransaccionContableEvent event,
    Emitter<TransaccionContableState> emit,
  ) async {
    emit(state.copyWith(status: TransaccionContableStatus.loading));
    final DataState<List<TransaccionContableTipoImpuesto>> resp = await _repository.getTipoImpuestosService();
    if (resp.data != null) {
      final List<EntryAutocomplete> entriesTipoImpuesto =
          resp.data!.map((TransaccionContableTipoImpuesto t) => EntryAutocomplete(title: t.nombre, codigo: t.codigo)).toList();
      emit(state.copyWith(status: TransaccionContableStatus.initial, entriesTipoImpuesto: entriesTipoImpuesto));
    } else {
      emit(state.copyWith(status: TransaccionContableStatus.exception, exception: resp.error));
    }
  }

  Future<void> _onGetTransaccionContable(GetTransaccionContableEvent event, Emitter<TransaccionContableState> emit) async {
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

  Future<void> _onUpdateTransaccionContable(UpdateTransaccionContableEvent event, Emitter<TransaccionContableState> emit) async {
    emit(state.copyWith(status: TransaccionContableStatus.loading));

    final List<DataState<TransaccionContable>> dataStateList = await Future.wait(
      event.requestList.map((TransaccionContableRequest request) => _repository.updateTransaccionContableService(request)),
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

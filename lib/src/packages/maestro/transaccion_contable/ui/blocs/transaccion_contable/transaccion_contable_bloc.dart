import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/domain/entities/request/transaccion_contable_request.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/domain/entities/transaccion_contable.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/domain/entities/transaccion_contable_tipo_impuesto.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/domain/repositories/abstract_transaccion_contable_repository.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

part 'transaccion_contable_event.dart';
part 'transaccion_contable_state.dart';

class TransaccionContableBloc extends Bloc<TransaccionContableEvent, TransaccionContableState> {
  final AbstractTransaccionContableRepository _repository;
  List<TransaccionContableTipoImpuesto> listImpuestos = <TransaccionContableTipoImpuesto>[];

  TransaccionContableBloc(this._repository) : super(const TransaccionContableInitialState()) {
    on<GetTransaccionContableEvent>((GetTransaccionContableEvent event, Emitter<TransaccionContableState> emit) async {
      emit(const TransaccionContableLoadingState());
      final DataState<List<TransaccionContable>> response = await _repository.getTransaccionesContablesService(event.request);
      if (response.data != null) {
        emit(TransaccionContableConsultedState(transaccionesContables: response.data!));
      } else {
        emit(TransaccionContableFailedState(exception: response.error!));
      }
    });

    on<SetTransaccionContableEvent>((SetTransaccionContableEvent event, Emitter<TransaccionContableState> emit) async {
      emit(const TransaccionContableLoadingState());
      final DataState<TransaccionContable> response = await _repository.createTransaccionesContablesService(event.request);
      if (response.data != null) {
        emit(TransaccionContableSuccessState(transaccionContable: response.data));
      } else {
        emit(TransaccionContableFailedState(exception: response.error!));
      }
    });

    on<UpdateTransaccionContableEvent>((UpdateTransaccionContableEvent event, Emitter<TransaccionContableState> emit) async {
      emit(const TransaccionContableLoadingState());
      final DataState<TransaccionContable> response = await _repository.updateTransaccionesContablesService(event.request);
      if (response.data != null) {
        emit(TransaccionContableSuccessState(transaccionContable: response.data));
      } else {
        emit(TransaccionContableFailedState(exception: response.error!));
      }
    });

    on<ErrorFormTransaccionContableEvent>((ErrorFormTransaccionContableEvent event, Emitter<TransaccionContableState> emit) {
      emit(const TransaccionContableLoadingState());
      emit(TransaccionContableErrorFormState(errorForm: event.error));
    });
  }

  Future<void> onGetImpuestos() async {
    if (listImpuestos.isEmpty) {
      final DataState<List<TransaccionContableTipoImpuesto>> resp = await _repository.getImpuestosService();
      listImpuestos = resp.data!;
    }
  }
}

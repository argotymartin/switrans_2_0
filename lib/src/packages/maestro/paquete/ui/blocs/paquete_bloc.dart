import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/domain/entities/paquete.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/domain/entities/request/paquete_request.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/domain/repositories/abstract_paquete_repository.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

part 'paquete_event.dart';
part 'paquete_state.dart';

class PaqueteBloc extends Bloc<PaqueteEvent, PaqueteState> {
  final AbstractPaqueteRepository _repository;
  List<Paquete> paquetes = <Paquete>[];

  PaqueteBloc(this._repository) : super(const PaqueteInitialState()) {
    on<SetPaqueteEvent>(_onSetPaquete);
    on<UpdatePaqueteEvent>(_onUpdatePaquete);
    on<GetPaqueteEvent>(_onGetPaquete);
    on<ErrorFormPaqueteEvent>(_onErrorFormPaquete);
  }

  Future<void> _onSetPaquete(SetPaqueteEvent event, Emitter<PaqueteState> emit) async {
    emit(const PaqueteLoadingState());
    final DataState<Paquete> response = await _repository.setPaqueteService(event.request);
    if (response.data != null) {
      emit(PaqueteSuccessState(paquete: response.data));
    } else {
      emit(PaqueteExceptionState(exception: response.error));
    }
  }

  Future<void> _onUpdatePaquete(UpdatePaqueteEvent event, Emitter<PaqueteState> emit) async {
    emit(const PaqueteLoadingState());
    final DataState<Paquete> response = await _repository.updatePaqueteService(event.request);
    if (response.data != null) {
      emit(PaqueteSuccessState(paquete: response.data));
    } else {
      emit(PaqueteExceptionState(exception: response.error));
    }
  }

  Future<void> _onGetPaquete(GetPaqueteEvent event, Emitter<PaqueteState> emit) async {
    emit(const PaqueteLoadingState());
    final DataState<List<Paquete>> response = await _repository.getPaquetesService(event.request);
    if (response.data != null) {
      emit(PaqueteConsultedState(paquetes: response.data!));
    } else {
      emit(PaqueteExceptionState(exception: response.error));
    }
  }

  Future<void> _onErrorFormPaquete(ErrorFormPaqueteEvent event, Emitter<PaqueteState> emit) async {
    emit(const PaqueteLoadingState());
    emit(PaqueteErrorFormState(error: event.exception));
  }
}

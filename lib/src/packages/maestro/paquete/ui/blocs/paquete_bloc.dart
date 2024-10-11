import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/domain/entities/paquete.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/domain/entities/request/paquete_request.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/domain/repositories/abstract_paquete_repository.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';

part 'paquete_event.dart';
part 'paquete_state.dart';

class PaqueteBloc extends Bloc<PaqueteEvent, PaqueteState> {
  final AbstractPaqueteRepository _repository;

  PaqueteRequest _request = PaqueteRequest();
  PaqueteBloc(this._repository) : super(const PaqueteState().initial()) {
    on<InitialPaqueteEvent>(_onInitialPaquete);
    on<GetPaqueteEvent>(_onGetPaquete);
    on<SetPaqueteEvent>(_onSetPaquete);
    on<UpdatePaqueteEvent>(_onUpdatePaquete);
    on<ErrorFormPaqueteEvent>(_onErrorFormPaquete);
  }

  Future<void> _onInitialPaquete(InitialPaqueteEvent event, Emitter<PaqueteState> emit) async {
    request.clean();
    emit(state.copyWith(status: PaqueteStatus.initial));
  }

  Future<void> _onGetPaquete(GetPaqueteEvent event, Emitter<PaqueteState> emit) async {
    emit(state.copyWith(status: PaqueteStatus.loading));
    request = event.request;
    final DataState<List<Paquete>> response = await _repository.getPaquetesService(event.request);
    if (response.data != null) {
      emit(state.copyWith(status: PaqueteStatus.consulted, paquetes: response.data));
    } else {
      emit(state.copyWith(status: PaqueteStatus.exception, exception: response.error));
    }
  }

  Future<void> _onSetPaquete(SetPaqueteEvent event, Emitter<PaqueteState> emit) async {
    emit(state.copyWith(status: PaqueteStatus.loading));
    final DataState<Paquete> response = await _repository.setPaqueteService(event.request);
    if (response.data != null) {
      emit(state.copyWith(status: PaqueteStatus.succes, paquete: response.data));
    } else {
      emit(state.copyWith(status: PaqueteStatus.exception, exception: response.error));
    }
  }

  Future<void> _onUpdatePaquete(UpdatePaqueteEvent event, Emitter<PaqueteState> emit) async {
    emit(state.copyWith(status: PaqueteStatus.loading));
    final List<DataState<Paquete>> dataStateList = await Future.wait(
      event.requestList.map((EntityUpdate<PaqueteRequest> request) => _repository.updatePaqueteService(request)),
    );

    final List<Paquete> paquetes = <Paquete>[];
    final List<DioException> exceptions = <DioException>[];

    for (final DataState<Paquete> dataState in dataStateList) {
      if (dataState.data != null) {
        paquetes.add(dataState.data!);
      } else if (dataState.error != null) {
        exceptions.add(dataState.error!);
      }
    }

    if (paquetes.isNotEmpty) {
      emit(state.copyWith(status: PaqueteStatus.consulted, paquetes: paquetes));
    }

    if (exceptions.isNotEmpty) {
      for (final DioException exception in exceptions) {
        emit(state.copyWith(status: PaqueteStatus.exception, exception: exception));
      }
    }
  }

  Future<void> _onErrorFormPaquete(ErrorFormPaqueteEvent event, Emitter<PaqueteState> emit) async {
    emit(state.copyWith(status: PaqueteStatus.error, error: event.error));
  }

  PaqueteRequest get request => _request;
  set request(PaqueteRequest value) => _request = value;
}

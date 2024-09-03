import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/packages/maestro/pais/domain/entities/pais.dart';
import 'package:switrans_2_0/src/packages/maestro/pais/domain/entities/request/pais_request.dart';
import 'package:switrans_2_0/src/packages/maestro/pais/domain/repositories/abstract_pais_repository.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

part 'pais_event.dart';
part 'pais_state.dart';

class PaisBloc extends Bloc<PaisEvent, PaisState> {
  final AbstractPaisRepository _repository;

  PaisRequest _request = PaisRequest();
  PaisBloc(this._repository) : super(const PaisState().initial()) {
    on<InitialPaisEvent>(_onInitialPais);
    on<GetPaisEvent>(_onGetPais);
    on<SetPaisEvent>(_onSetPais);
    on<UpdatePaisEvent>(_onUpdatePais);
    on<ErrorFormPaisEvent>(_onErrorFormPais);
  }

  Future<void> _onInitialPais(InitialPaisEvent event, Emitter<PaisState> emit) async {
    request.clean();
    emit(state.copyWith(status: PaisStatus.initial));
  }

  Future<void> _onGetPais(GetPaisEvent event, Emitter<PaisState> emit) async {
    emit(state.copyWith(status: PaisStatus.loading));
    final DataState<List<Pais>> response = await _repository.getPaisesService(request);
    if (response.data != null) {
      emit(state.copyWith(status: PaisStatus.consulted, paises: response.data));
    } else {
      emit(state.copyWith(status: PaisStatus.exception, exception: response.error));
    }
  }

  Future<void> _onSetPais(SetPaisEvent event, Emitter<PaisState> emit) async {
    emit(state.copyWith(status: PaisStatus.loading));
    final DataState<Pais> response = await _repository.setPaisService(event.request);
    if (response.data != null) {
      emit(state.copyWith(status: PaisStatus.succes, pais: response.data));
    } else {
      emit(state.copyWith(status: PaisStatus.exception, exception: response.error));
    }
  }

  Future<void> _onUpdatePais(UpdatePaisEvent event, Emitter<PaisState> emit) async {
    emit(state.copyWith(status: PaisStatus.loading));
    final List<DataState<Pais>> dataStateList = await Future.wait(
      event.requestList.map((PaisRequest request) => _repository.updatePaisService(request)),
    );

    final List<Pais> paiss = <Pais>[];
    final List<DioException> exceptions = <DioException>[];

    for (final DataState<Pais> dataState in dataStateList) {
      if (dataState.data != null) {
        paiss.add(dataState.data!);
      } else if (dataState.error != null) {
        exceptions.add(dataState.error!);
      }
    }

    if (paiss.isNotEmpty) {
      emit(state.copyWith(status: PaisStatus.consulted, paises: paiss));
    }

    if (exceptions.isNotEmpty) {
      for (final DioException exception in exceptions) {
        emit(state.copyWith(status: PaisStatus.exception, exception: exception));
      }
    }
  }

  Future<void> _onErrorFormPais(ErrorFormPaisEvent event, Emitter<PaisState> emit) async {
    emit(state.copyWith(status: PaisStatus.error, error: event.error));
  }

  PaisRequest get request => _request;
  set request(PaisRequest value) => _request = value;
}

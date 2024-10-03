import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/packages/maestro/departamento/domain/domain.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';

part 'departamento_event.dart';
part 'departamento_state.dart';

class DepartamentoBloc extends Bloc<DepartamentoEvent, DepartamentoState> {
  final AbstractDepartamentoRepository _repository;
  DepartamentoRequest _request = DepartamentoRequest();

  DepartamentoBloc(this._repository) : super(const DepartamentoState().initial()) {
    on<InitialDepartamentoEvent>(_onInitialDepartamento);
    on<GetDepartamentoEvent>(_onGetDepartamento);
    on<SetDepartamentoEvent>(_onSetDepartamento);
    on<UpdateDepartamentoEvent>(_onUpdateDepartamento);
    on<ErrorFormDepartamentoEvent>(_onErrorFormDepartamento);
    on<CleanFormDepartamentoEvent>(_onCleanFormDepartamento);
  }

  Future<void> _onInitialDepartamento(InitialDepartamentoEvent event, Emitter<DepartamentoState> emit) async {
    emit(state.copyWith(status: DepartamentoStatus.loading));
    final DataState<List<DepartamentoPais>> resp = await _repository.getPaisesService();
    if (resp.data != null) {
      final List<EntryAutocomplete> entriesPaises =
          resp.data!.map((DepartamentoPais e) => EntryAutocomplete(title: e.nombre, codigo: e.codigo)).toList();
      emit(state.copyWith(status: DepartamentoStatus.initial, entriesPaises: entriesPaises));
    } else {
      emit(state.copyWith(status: DepartamentoStatus.exception, exception: resp.error));
    }
  }

  Future<void> _onGetDepartamento(GetDepartamentoEvent event, Emitter<DepartamentoState> emit) async {
    emit(state.copyWith(status: DepartamentoStatus.loading));
    final DataState<List<Departamento>> response = await _repository.getDepartamentosService(event.request);
    if (response.data != null) {
      emit(state.copyWith(status: DepartamentoStatus.consulted, departamentos: response.data));
    } else {
      emit(state.copyWith(status: DepartamentoStatus.exception, exception: response.error));
    }
  }

  Future<void> _onSetDepartamento(SetDepartamentoEvent event, Emitter<DepartamentoState> emit) async {
    emit(state.copyWith(status: DepartamentoStatus.loading));
    final DataState<Departamento> response = await _repository.setDepartamentoService(event.request);
    if (response.data != null) {
      emit(state.copyWith(status: DepartamentoStatus.succes, departamento: response.data));
    } else {
      emit(state.copyWith(status: DepartamentoStatus.exception, exception: response.error));
    }
  }

  Future<void> _onUpdateDepartamento(UpdateDepartamentoEvent event, Emitter<DepartamentoState> emit) async {
    emit(state.copyWith(status: DepartamentoStatus.loading));

    final List<DataState<Departamento>> dataStateList = await Future.wait(
      event.requestList.map((DepartamentoRequest request) => _repository.updateDepartamentoService(request)),
    );

    final List<Departamento> departamentos = <Departamento>[];
    final List<DioException> exceptions = <DioException>[];

    for (final DataState<Departamento> dataState in dataStateList) {
      if (dataState.data != null) {
        departamentos.add(dataState.data!);
      } else if (dataState.error != null) {
        exceptions.add(dataState.error!);
      }
    }

    if (departamentos.isNotEmpty) {
      emit(state.copyWith(status: DepartamentoStatus.consulted, departamentos: departamentos));
    }

    if (exceptions.isNotEmpty) {
      for (final DioException exception in exceptions) {
        emit(state.copyWith(status: DepartamentoStatus.exception, exception: exception));
      }
    }
  }

  Future<void> _onErrorFormDepartamento(ErrorFormDepartamentoEvent event, Emitter<DepartamentoState> emit) async {
    emit(state.copyWith(status: DepartamentoStatus.error, error: event.error));
  }

  Future<void> _onCleanFormDepartamento(CleanFormDepartamentoEvent event, Emitter<DepartamentoState> emit) async {
    request.clean();
    emit(state.copyWith(status: DepartamentoStatus.initial, departamentos: <Departamento>[], error: ""));
  }

  DepartamentoRequest get request => _request;
  set request(DepartamentoRequest value) => _request = value;
}

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/packages/maestro/municipio/domain/domain.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';

part 'municipio_event.dart';
part 'municipio_state.dart';

class MunicipioBloc extends Bloc<MunicipioEvent, MunicipioState> {
  final AbstractMunicipioRepository _repository;
  MunicipioRequest _request = MunicipioRequest();

  MunicipioBloc(this._repository) : super(const MunicipioState().initial()) {
    on<InitialMunicipioEvent>(_onInitialMunicipio);
    on<GetMunicipioEvent>(_onGetMunicipio);
    on<SetMunicipioEvent>(_onSetMunicipio);
    on<UpdateMunicipioEvent>(_onUpdateMunicipio);
    on<ErrorFormMunicipioEvent>(_onErrorFormMunicipio);
    on<CleanFormMunicipioEvent>(_onCleanFormMunicipio);
  }

  Future<void> _onInitialMunicipio(InitialMunicipioEvent event, Emitter<MunicipioState> emit) async {
    emit(state.copyWith(status: MunicipioStatus.loading));
    final DataState<List<MunicipioDepartamento>> resp = await _repository.getDepartamentosService();
    if (resp.data != null) {
      final List<EntryAutocomplete> entriesDepartamentos =
          resp.data!.map((MunicipioDepartamento e) => EntryAutocomplete(title: e.nombre, codigo: e.codigo)).toList();
      emit(state.copyWith(status: MunicipioStatus.initial, entriesDepartamentos: entriesDepartamentos));
    } else {
      emit(state.copyWith(status: MunicipioStatus.exception, exception: resp.error));
    }
  }

  Future<void> _onGetMunicipio(GetMunicipioEvent event, Emitter<MunicipioState> emit) async {
    emit(state.copyWith(status: MunicipioStatus.loading));
    final DataState<List<Municipio>> response = await _repository.getMunicipiosService(request);
    if (response.data != null) {
      emit(state.copyWith(status: MunicipioStatus.consulted, municipios: response.data));
    } else {
      emit(state.copyWith(status: MunicipioStatus.exception, exception: response.error));
    }
  }

  Future<void> _onSetMunicipio(SetMunicipioEvent event, Emitter<MunicipioState> emit) async {
    emit(state.copyWith(status: MunicipioStatus.loading));
    final DataState<Municipio> response = await _repository.setMunicipioService(event.request);
    if (response.data != null) {
      emit(state.copyWith(status: MunicipioStatus.succes, municipio: response.data));
    } else {
      emit(state.copyWith(status: MunicipioStatus.exception, exception: response.error));
    }
  }

  Future<void> _onUpdateMunicipio(UpdateMunicipioEvent event, Emitter<MunicipioState> emit) async {
    emit(state.copyWith(status: MunicipioStatus.loading));

    final List<DataState<Municipio>> dataStateList = await Future.wait(
      event.requestList.map((MunicipioRequest request) => _repository.updateMunicipioService(request)),
    );

    final List<Municipio> municipios = <Municipio>[];
    final List<DioException> exceptions = <DioException>[];

    for (final DataState<Municipio> dataState in dataStateList) {
      if (dataState.data != null) {
        municipios.add(dataState.data!);
      } else if (dataState.error != null) {
        exceptions.add(dataState.error!);
      }
    }

    if (municipios.isNotEmpty) {
      emit(state.copyWith(status: MunicipioStatus.consulted, municipios: municipios));
    }

    if (exceptions.isNotEmpty) {
      for (final DioException exception in exceptions) {
        emit(state.copyWith(status: MunicipioStatus.exception, exception: exception));
      }
    }
  }

  Future<void> _onErrorFormMunicipio(ErrorFormMunicipioEvent event, Emitter<MunicipioState> emit) async {
    emit(state.copyWith(status: MunicipioStatus.error, error: event.error));
  }

  Future<void> _onCleanFormMunicipio(CleanFormMunicipioEvent event, Emitter<MunicipioState> emit) async {
    request.clean();
    emit(state.copyWith(status: MunicipioStatus.initial, municipios: <Municipio>[], error: ""));
  }

  MunicipioRequest get request => _request;
  set request(MunicipioRequest value) => _request = value;
}

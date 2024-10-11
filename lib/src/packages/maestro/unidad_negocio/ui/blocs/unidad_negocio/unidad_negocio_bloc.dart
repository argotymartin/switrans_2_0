import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/domain/entities/request/unidad_negocio_request.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/domain/entities/unidad_negocio.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/domain/entities/unidad_negocio_empresa.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/domain/repositories/abstract_unidad_negocio_repository.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';
import 'package:switrans_2_0/src/util/shared/models/entry_autocomplete.dart';

part 'unidad_negocio_event.dart';
part 'unidad_negocio_state.dart';

class UnidadNegocioBloc extends Bloc<UnidadNegocioEvent, UnidadNegocioState> {
  final AbstractUnidadNegocioRepository _repository;
  UnidadNegocioRequest _request = UnidadNegocioRequest();

  UnidadNegocioBloc(this._repository) : super(const UnidadNegocioState().initial()) {
    on<InitializationUnidadNegocioEvent>(_onInitializationUnidadNegocio);
    on<GetUnidadNegocioEvent>(_onGetUnidadNegocio);
    on<SetUnidadNegocioEvent>(_onSetUnidadNegocio);
    on<UpdateUnidadNegocioEvent>(_onUpdateUnidadNegocio);
    on<ErrorFormUnidadNegocioEvent>(_onErrorFormUnidadNegocio);
    on<CleanFormUnidadNegocioEvent>(_onCleanFormUnidadNegocio);
  }

  Future<void> _onInitializationUnidadNegocio(InitializationUnidadNegocioEvent event, Emitter<UnidadNegocioState> emit) async {
    emit(state.copyWith(status: UnidadNegocioStatus.loading));
    final DataState<List<UnidadNegocioEmpresa>> resp = await _repository.getEmpresasService();
    if (resp.data != null) {
      final List<EntryAutocomplete> entriesEmpresa =
          resp.data!.map((UnidadNegocioEmpresa e) => EntryAutocomplete(title: e.nombre, codigo: e.codigo)).toList();
      emit(state.copyWith(status: UnidadNegocioStatus.initial, entriesEmpresa: entriesEmpresa));
    } else {
      emit(state.copyWith(status: UnidadNegocioStatus.exception, exception: resp.error));
    }
  }

  Future<void> _onGetUnidadNegocio(GetUnidadNegocioEvent event, Emitter<UnidadNegocioState> emit) async {
    emit(state.copyWith(status: UnidadNegocioStatus.loading));
    final DataState<List<UnidadNegocio>> response = await _repository.getUnidadNegociosService(event.request);
    if (response.data != null) {
      emit(state.copyWith(status: UnidadNegocioStatus.consulted, unidadNegocios: response.data));
    } else {
      emit(state.copyWith(status: UnidadNegocioStatus.exception, exception: response.error));
    }
  }

  Future<void> _onSetUnidadNegocio(SetUnidadNegocioEvent event, Emitter<UnidadNegocioState> emit) async {
    emit(state.copyWith(status: UnidadNegocioStatus.loading));
    final DataState<UnidadNegocio> response = await _repository.setUnidadNegocioService(event.request);
    if (response.data != null) {
      emit(state.copyWith(status: UnidadNegocioStatus.succes, unidadNegocio: response.data));
    } else {
      emit(state.copyWith(status: UnidadNegocioStatus.exception, exception: response.error));
    }
  }

  Future<void> _onUpdateUnidadNegocio(UpdateUnidadNegocioEvent event, Emitter<UnidadNegocioState> emit) async {
    emit(state.copyWith(status: UnidadNegocioStatus.loading));

    final List<DataState<UnidadNegocio>> dataStateList = await Future.wait(
      event.requestList.map((EntityUpdate<UnidadNegocioRequest> request) => _repository.updateUnidadNegocioService(request)),
    );

    final List<UnidadNegocio> unidadNegocios = <UnidadNegocio>[];
    final List<DioException> exceptions = <DioException>[];

    for (final DataState<UnidadNegocio> dataState in dataStateList) {
      if (dataState.data != null) {
        unidadNegocios.add(dataState.data!);
      } else if (dataState.error != null) {
        exceptions.add(dataState.error!);
      }
    }

    if (unidadNegocios.isNotEmpty) {
      emit(state.copyWith(status: UnidadNegocioStatus.consulted, unidadNegocios: unidadNegocios));
    }

    if (exceptions.isNotEmpty) {
      for (final DioException exception in exceptions) {
        emit(state.copyWith(status: UnidadNegocioStatus.exception, exception: exception));
      }
    }
  }

  Future<void> _onErrorFormUnidadNegocio(ErrorFormUnidadNegocioEvent event, Emitter<UnidadNegocioState> emit) async {
    emit(state.copyWith(status: UnidadNegocioStatus.error, error: event.error));
  }

  Future<void> _onCleanFormUnidadNegocio(CleanFormUnidadNegocioEvent event, Emitter<UnidadNegocioState> emit) async {
    request.clean();
    emit(state.copyWith(status: UnidadNegocioStatus.initial, unidadNegocios: <UnidadNegocio>[], error: ""));
  }

  UnidadNegocioRequest get request => _request;
  set request(UnidadNegocioRequest value) => _request = value;
}

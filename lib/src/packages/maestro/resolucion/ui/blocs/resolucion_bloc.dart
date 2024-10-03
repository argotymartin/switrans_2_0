import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/packages/maestro/resolucion/domain/domain.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';
import 'package:switrans_2_0/src/util/shared/models/entry_autocomplete.dart';

part 'resolucion_event.dart';
part 'resolucion_state.dart';

class ResolucionBloc extends Bloc<ResolucionEvent, ResolucionState> {
  final AbstractResolucionRepository _resolucionRepository;
  ResolucionRequest _request = ResolucionRequest();

  ResolucionBloc(this._resolucionRepository) : super(const ResolucionState().initial()) {
    on<InitializationResolucionEvent>(_onInitialization);
    on<GetResolucionesEvent>(_onGetResoluciones);
    on<SetResolucionEvent>(_onSetResolucion);
    on<UpdateResolucionesEvent>(_onUpdateResoluciones);
    on<ErrorFormResolucionEvent>(_onErrorFormResolucion);
    on<CleanFormResolucionEvent>(_onCleanFormResolucion);
    on<SelectResolucionEmpresaEvent>(_onSelectResolucionEmpresa);
    on<CleanSelectResolucionEmpresaEvent>(_onCleanSelectResolucionEmpresa);
  }

  Future<void> _onInitialization(InitializationResolucionEvent event, Emitter<ResolucionState> emit) async {
    emit(state.copyWith(status: ResolucionStatus.loading, resolucionesCentroCosto: <EntryAutocomplete>[]));
    final DataState<List<ResolucionDocumento>> documentosResponse = await _resolucionRepository.getDocumentosService();
    final DataState<List<ResolucionEmpresa>> empresasResponse = await _resolucionRepository.getEmpresasService();
    if (empresasResponse.data != null || documentosResponse.data != null) {
      final List<EntryAutocomplete> entriesDocumentos =
          documentosResponse.data!.map((ResolucionDocumento t) => EntryAutocomplete(title: t.nombre, codigo: t.codigo)).toList();
      final List<EntryAutocomplete> entriesEmpresas = empresasResponse.data!
          .map((ResolucionEmpresa t) => EntryAutocomplete(title: t.nombre, codigo: t.codigo, subTitle: t.nit))
          .toList();
      emit(
        state.copyWith(
          resolucionesDocumentos: entriesDocumentos,
          resolucionesEmpresas: entriesEmpresas,
          status: ResolucionStatus.initial,
        ),
      );
    } else {
      emit(state.copyWith(status: ResolucionStatus.exception, exception: empresasResponse.error));
    }
  }

  Future<void> _onGetResoluciones(GetResolucionesEvent event, Emitter<ResolucionState> emit) async {
    emit(state.copyWith(status: ResolucionStatus.loading));
    final DataState<List<Resolucion>> response = await _resolucionRepository.getResolucionesService(event.request);
    if (response.data != null) {
      emit(state.copyWith(resoluciones: response.data, status: ResolucionStatus.consulted));
    } else {
      emit(state.copyWith(status: ResolucionStatus.exception, exception: response.error));
    }
  }

  Future<void> _onSetResolucion(SetResolucionEvent event, Emitter<ResolucionState> emit) async {
    emit(state.copyWith(status: ResolucionStatus.loading));
    final DataState<Resolucion> response = await _resolucionRepository.setResolucionService(_request);
    if (response.data != null) {
      emit(state.copyWith(resolucion: response.data, status: ResolucionStatus.success));
    } else {
      emit(state.copyWith(status: ResolucionStatus.exception, exception: response.error));
    }
  }

  Future<void> _onUpdateResoluciones(UpdateResolucionesEvent event, Emitter<ResolucionState> emit) async {
    emit(state.copyWith(status: ResolucionStatus.loading));
    final List<DataState<Resolucion>> dataStateList = await Future.wait(
      event.requestList.map((ResolucionRequest resolucion) async => await _resolucionRepository.updateResolucionService(resolucion)),
    );
    final List<Resolucion> resoluciones = <Resolucion>[];
    final List<DioException> exceptions = <DioException>[];
    for (final DataState<Resolucion> dataState in dataStateList) {
      if (dataState.data != null) {
        resoluciones.add(dataState.data!);
      } else if (dataState.error != null) {
        exceptions.add(dataState.error!);
      }
    }
    if (resoluciones.isNotEmpty) {
      emit(state.copyWith(status: ResolucionStatus.consulted, resoluciones: resoluciones));
    }
    if (exceptions.isNotEmpty) {
      for (final DioException exception in exceptions) {
        emit(state.copyWith(status: ResolucionStatus.exception, exception: exception));
      }
    }
  }

  Future<void> _onErrorFormResolucion(ErrorFormResolucionEvent event, Emitter<ResolucionState> emit) async {
    emit(state.copyWith(error: event.error));
  }

  Future<void> _onCleanFormResolucion(CleanFormResolucionEvent event, Emitter<ResolucionState> emit) async {
    request.clean();
    emit(
      state.copyWith(
        status: ResolucionStatus.initial,
        error: "",
        resoluciones: <Resolucion>[],
      ),
    );
  }

  Future<void> _onSelectResolucionEmpresa(SelectResolucionEmpresaEvent event, Emitter<ResolucionState> emit) async {
    emit(state.copyWith(status: ResolucionStatus.loading));
    final DataState<List<ResolucionCentroCosto>> centroCostosResponse =
        await _resolucionRepository.getCentroCostoService(event.resolucionEmpresa);
    if (centroCostosResponse.data != null) {
      final List<EntryAutocomplete> entriesCentroCostos =
          centroCostosResponse.data!.map((ResolucionCentroCosto t) => EntryAutocomplete(title: t.nombre, codigo: t.codigo)).toList();
      emit(state.copyWith(resolucionesCentroCosto: entriesCentroCostos, status: ResolucionStatus.initial));
    } else {
      emit(state.copyWith(status: ResolucionStatus.exception, exception: centroCostosResponse.error));
    }
  }

  Future<void> _onCleanSelectResolucionEmpresa(CleanSelectResolucionEmpresaEvent event, Emitter<ResolucionState> emit) async {
    emit(state.copyWith(status: ResolucionStatus.initial, resolucionesCentroCosto: <EntryAutocomplete>[]));
  }

  ResolucionRequest get request => _request;
  set request(ResolucionRequest value) => _request = value;
}

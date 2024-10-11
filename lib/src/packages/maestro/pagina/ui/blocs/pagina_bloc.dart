import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/domain/entities/pagina.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/domain/entities/pagina_modulo.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/domain/entities/request/pagina_request.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/domain/repositories/abstract_pagina_repository.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';

part 'pagina_event.dart';
part 'pagina_state.dart';

class PaginaBloc extends Bloc<PaginaEvent, PaginaState> {
  final AbstractPaginaRepository _repository;
  PaginaRequest _request = PaginaRequest();
  PaginaBloc(this._repository) : super(const PaginaState().initial()) {
    on<InitialPaginaEvent>(_onInitialPaginaEvent);
    on<GetPaginaEvent>(_onGetPagina);
    on<SetPaginaEvent>(_onSetPagina);
    on<UpdatePaginaEvent>(_onUpdatePagina);
    on<ErrorFormPaginaEvent>(_onErrorFormPagina);
    on<CleanFormPaginaEvent>(_onCleanFormModulo);
  }

  Future<void> _onInitialPaginaEvent(InitialPaginaEvent event, Emitter<PaginaState> emit) async {
    emit(state.copyWith(status: PaginaStatus.loading));
    final DataState<List<PaginaModulo>> resp = await _repository.getModulosService();
    if (resp.data != null) {
      final List<EntryAutocomplete> entriesModulos =
          resp.data!.map((PaginaModulo e) => EntryAutocomplete(title: e.nombre, codigo: e.codigo)).toList();
      emit(state.copyWith(status: PaginaStatus.initial, entriesModulos: entriesModulos));
    } else {
      emit(state.copyWith(status: PaginaStatus.exception, exception: resp.error));
    }
  }

  Future<void> _onGetPagina(GetPaginaEvent event, Emitter<PaginaState> emit) async {
    emit(state.copyWith(status: PaginaStatus.loading));
    final DataState<List<Pagina>> response = await _repository.getPaginasService(event.request);
    if (response.data != null) {
      emit(state.copyWith(status: PaginaStatus.consulted, paginas: response.data));
    } else {
      emit(state.copyWith(status: PaginaStatus.exception, exception: response.error));
    }
  }

  Future<void> _onSetPagina(SetPaginaEvent event, Emitter<PaginaState> emit) async {
    emit(state.copyWith(status: PaginaStatus.loading));
    final DataState<Pagina> response = await _repository.setPaginaService(event.request);
    if (response.data != null) {
      emit(state.copyWith(status: PaginaStatus.succes, pagina: response.data));
    } else {
      emit(state.copyWith(status: PaginaStatus.exception, exception: response.error));
    }
  }

  Future<void> _onUpdatePagina(UpdatePaginaEvent event, Emitter<PaginaState> emit) async {
    emit(state.copyWith(status: PaginaStatus.loading));

    final List<DataState<Pagina>> dataStateList = await Future.wait(
      event.requestList.map((EntityUpdate<PaginaRequest> request) => _repository.updatePaginaService(request)),
    );

    final List<Pagina> paginas = <Pagina>[];
    final List<DioException> exceptions = <DioException>[];

    for (final DataState<Pagina> dataState in dataStateList) {
      if (dataState.data != null) {
        paginas.add(dataState.data!);
      } else if (dataState.error != null) {
        exceptions.add(dataState.error!);
      }
    }

    if (paginas.isNotEmpty) {
      emit(state.copyWith(status: PaginaStatus.consulted, paginas: paginas));
    }

    if (exceptions.isNotEmpty) {
      for (final DioException exception in exceptions) {
        emit(state.copyWith(status: PaginaStatus.exception, exception: exception));
      }
    }
  }

  Future<void> _onErrorFormPagina(ErrorFormPaginaEvent event, Emitter<PaginaState> emit) async {
    emit(state.copyWith(status: PaginaStatus.error, error: event.error));
  }

  Future<void> _onCleanFormModulo(CleanFormPaginaEvent event, Emitter<PaginaState> emit) async {
    request.clean();
    emit(state.copyWith(status: PaginaStatus.initial, paginas: <Pagina>[], error: ""));
  }

  PaginaRequest get request => _request;
  set request(PaginaRequest value) => _request = value;
}

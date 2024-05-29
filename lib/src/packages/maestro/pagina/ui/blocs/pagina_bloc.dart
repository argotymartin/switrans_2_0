import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/domain/entities/pagina.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/domain/entities/pagina_modulo.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/domain/entities/request/pagina_request.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/domain/repositories/abstract_pagina_repository.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

part 'pagina_event.dart';
part 'pagina_state.dart';

class PaginaBloc extends Bloc<PaginaEvent, PaginaState> {
  final AbstractPaginaRepository _repository;
  List<PaginaModulo> modulos = <PaginaModulo>[];

  PaginaBloc(this._repository) : super(const PaginaInitialState()) {
    on<SetPaginaEvent>(_onSetPagina);
    on<UpdatePaginaEvent>(_onUpdatePagina);
    on<GetPaginaEvent>(_onGetPagina);
    on<ErrorFormPaginaEvent>(_onErrorFormPagina);
  }

  Future<void> _onSetPagina(SetPaginaEvent event, Emitter<PaginaState> emit) async {
    emit(const PaginaLoadingState());
    final DataState<Pagina> response = await _repository.setPaginaService(event.request);
    if (response.data != null) {
      emit(PaginaSuccessState(pagina: response.data));
    } else {
      emit(PaginaExceptionState(exception: response.error));
    }
  }

  Future<void> _onUpdatePagina(UpdatePaginaEvent event, Emitter<PaginaState> emit) async {
    emit(const PaginaLoadingState());
    final DataState<Pagina> response = await _repository.updatePaginaService(event.request);
    if (response.data != null) {
      emit(PaginaSuccessState(pagina: response.data));
    } else {
      emit(PaginaExceptionState(exception: response.error));
    }
  }

  Future<void> _onGetPagina(GetPaginaEvent event, Emitter<PaginaState> emit) async {
    emit(const PaginaLoadingState());
    final DataState<List<Pagina>> response = await _repository.getPaginasService(event.request);
    if (response.data != null) {
      emit(PaginaConsultedState(paginas: response.data!));
    } else {
      emit(PaginaExceptionState(exception: response.error));
    }
  }

  Future<void> _onErrorFormPagina(ErrorFormPaginaEvent event, Emitter<PaginaState> emit) async {
    emit(const PaginaLoadingState());
    emit(PaginaErrorFormState(error: event.exception));
  }

  Future<void> onGetModulos() async {
    if (modulos.isEmpty) {
      final DataState<List<PaginaModulo>> resp = await _repository.getModulosService();
      modulos = resp.data!;
    }
  }
}

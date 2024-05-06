import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/domain/entities/request/unidad_negocio_request.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/domain/entities/unidad_negocio.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/domain/entities/unidad_negocio_empresa.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/domain/repositories/abstract_unidad_negocio_repository.dart';

part 'unidad_negocio_event.dart';
part 'unidad_negocio_state.dart';

class UnidadNegocioBloc extends Bloc<UnidadNegocioEvent, UnidadNegocioState> {
  final AbstractUnidadNegocioRepository _repository;
  List<UnidadNegocioEmpresa> empresas = [];

  UnidadNegocioBloc(this._repository) : super(const UnidadNegocioInitialState()) {
    on<GetUnidadNegocioEvent>((event, emit) async {
      emit(const UnidadNegocioLoadingState());
      final response = await _repository.getUnidadNegocioService(event.request);
      if (response.data != null) {
        emit(UnidadNegocioConsultedState(unidadNegocioList: response.data!));
      } else {
        emit(UnidadNegocioFailedState(exception: response.error!));
      }
    });

    on<SetUnidadNegocioEvent>((event, emit) async {
      emit(const UnidadNegocioLoadingState());
      final response = await _repository.createUnidadNegocioService(event.request);
      if (response.data != null) {
        emit(UnidadNegocioSuccessState(unidadNegocio: response.data));
      } else {
        emit(UnidadNegocioFailedState(exception: response.error!));
      }
    });

    on<UpdateUnidadNegocioEvent>((event, emit) async {
      emit(const UnidadNegocioLoadingState());
      final response = await _repository.updateUnidadNegocioService(event.request);
      if (response.data != null) {
        emit(UnidadNegocioSuccessState(unidadNegocio: response.data));
      } else {
        emit(UnidadNegocioFailedState(exception: response.error!));
      }
    });

    on<ErrorFormUnidadNegocioEvent>((event, emit) {
      emit(const UnidadNegocioLoadingState());
      emit(UnidadNegocioErrorFormState(errorForm: event.error));
    });
  }
  Future<void> onGetEmpresas() async {
    if (empresas.isEmpty) {
      final resp = await _repository.getEmpresasService();
      empresas = resp.data!;
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/request/modulo_request.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/modulo.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/repositories/abstract_modulo_repository.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/modulo_paquete.dart';

part 'modulo_event.dart';
part 'modulo_state.dart';

class ModuloBloc extends Bloc<ModuloEvent, ModuloState> {
  final AbstractModuloRepository _repository;
  List<ModuloPaquete> paquetes = [];

  ModuloBloc(this._repository) : super(const ModuloInitialState()) {
    on<SetModuloEvent>(_onSetModulo);
    on<UpdateModuloEvent>(_onUpdateModulo);
    on<GetModuloEvent>(_onGetModulo);
    on<ErrorFormModuloEvent>(_onErrorFormModulo);
  }

  void _onSetModulo(SetModuloEvent event, Emitter<ModuloState> emit) async {
    emit(const ModuloLoadingState());
    final response = await _repository.setModuloService(event.request);
    if (response.data != null) {
      emit(ModuloSuccessState(modulo: response.data));
    } else {
      emit(ModuloExceptionState(exception: response.error));
    }
  }

  void _onUpdateModulo(UpdateModuloEvent event, Emitter<ModuloState> emit) async {
    emit(const ModuloLoadingState());
    final response = await _repository.updateModuloService(event.request);
    if (response.data != null) {
      emit(ModuloSuccessState(modulo: response.data));
    } else {
      emit(ModuloExceptionState(exception: response.error));
    }
  }

  void _onGetModulo(GetModuloEvent event, Emitter<ModuloState> emit) async {
    emit(const ModuloLoadingState());
    final response = await _repository.getModulosService(event.request);
    if (response.data != null) {
      emit(ModuloConsultedState(modulos: response.data!));
    } else {
      emit(ModuloExceptionState(exception: response.error));
    }
  }


  void _onErrorFormModulo(ErrorFormModuloEvent event, Emitter<ModuloState> emit) async {
    emit(const ModuloLoadingState());
    emit(ModuloErrorFormState(error: event.exception));
  }

  Future<void> onGetPaquetes() async {
    if (paquetes.isEmpty) {
      final resp = await _repository.getPaquetesService();
      paquetes = resp.data!;
    }
  }

}
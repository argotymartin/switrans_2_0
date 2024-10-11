import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/modulo.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/modulo_paquete.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/request/modulo_request.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/repositories/abstract_modulo_repository.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';

part 'modulo_event.dart';
part 'modulo_state.dart';

class ModuloBloc extends Bloc<ModuloEvent, ModuloState> {
  final AbstractModuloRepository _repository;
  ModuloRequest _request = ModuloRequest();

  ModuloBloc(this._repository) : super(const ModuloState().initial()) {
    on<InitializationModuloEvent>(_onInitializationModulo);
    on<GetModuloEvent>(_onGetModulo);
    on<SetModuloEvent>(_onSetModulo);
    on<UpdateModuloEvent>(_onUpdateModulo);
    on<ErrorFormModuloEvent>(_onErrorFormModulo);
    on<CleanFormModuloEvent>(_onCleanFormModulo);
  }

  Future<void> _onInitializationModulo(InitializationModuloEvent event, Emitter<ModuloState> emit) async {
    emit(state.copyWith(status: ModuloStatus.loading));
    final DataState<List<ModuloPaquete>> resp = await _repository.getPaquetesService();
    if (resp.data != null) {
      final List<EntryAutocomplete> entriesPaquete =
          resp.data!.map((ModuloPaquete e) => EntryAutocomplete(title: e.nombre, codigo: e.codigo)).toList();
      emit(state.copyWith(status: ModuloStatus.initial, entriesPaquete: entriesPaquete));
    } else {
      emit(state.copyWith(status: ModuloStatus.exception, exception: resp.error));
    }
  }

  Future<void> _onGetModulo(GetModuloEvent event, Emitter<ModuloState> emit) async {
    emit(state.copyWith(status: ModuloStatus.loading));
    final DataState<List<Modulo>> response = await _repository.getModulosService(event.request);
    if (response.data != null) {
      emit(state.copyWith(status: ModuloStatus.consulted, modulos: response.data));
    } else {
      emit(state.copyWith(status: ModuloStatus.exception, exception: response.error));
    }
  }

  Future<void> _onSetModulo(SetModuloEvent event, Emitter<ModuloState> emit) async {
    emit(state.copyWith(status: ModuloStatus.loading));
    final DataState<Modulo> response = await _repository.setModuloService(event.request);
    if (response.data != null) {
      emit(state.copyWith(status: ModuloStatus.succes, modulo: response.data));
    } else {
      emit(state.copyWith(status: ModuloStatus.exception, exception: response.error));
    }
  }

  Future<void> _onUpdateModulo(UpdateModuloEvent event, Emitter<ModuloState> emit) async {
    emit(state.copyWith(status: ModuloStatus.loading));

    final List<DataState<Modulo>> dataStateList = await Future.wait(
      event.requestList.map((EntityUpdate<ModuloRequest> request) => _repository.updateModuloService(request)),
    );

    final List<Modulo> modulos = <Modulo>[];
    final List<DioException> exceptions = <DioException>[];

    for (final DataState<Modulo> dataState in dataStateList) {
      if (dataState.data != null) {
        modulos.add(dataState.data!);
      } else if (dataState.error != null) {
        exceptions.add(dataState.error!);
      }
    }

    if (modulos.isNotEmpty) {
      emit(state.copyWith(status: ModuloStatus.consulted, modulos: modulos));
    }

    if (exceptions.isNotEmpty) {
      for (final DioException exception in exceptions) {
        emit(state.copyWith(status: ModuloStatus.exception, exception: exception));
      }
    }
  }

  Future<void> _onErrorFormModulo(ErrorFormModuloEvent event, Emitter<ModuloState> emit) async {
    emit(state.copyWith(status: ModuloStatus.error, error: event.error));
  }

  Future<void> _onCleanFormModulo(CleanFormModuloEvent event, Emitter<ModuloState> emit) async {
    request.clean();
    emit(state.copyWith(status: ModuloStatus.initial, modulos: <Modulo>[], error: ""));
  }

  ModuloRequest get request => _request;
  set request(ModuloRequest value) => _request = value;
}

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/modulo.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/paquete.dart';
import 'package:switrans_2_0/src/globals/menu/domain/repositories/abstract_modulo_repository.dart';
part 'modulo_event.dart';
part 'modulo_state.dart';

class ModuloBloc extends Bloc<ModuloEvent, ModuloState> {
  final AbstractModuloRepository _moduloRepository;
  ModuloBloc(this._moduloRepository) : super(ModuloInitial()) {
    on<ModuloEvent>((event, emit) {});
    on<ActiveteModuloEvent>((event, emit) async {
      emit(const ModuloLoadingState());
      final dataState = await _moduloRepository.getModulos();
      emit(ModuloSuccesState(paquetes: dataState.data!));
    });

    on<ChangedModuloEvent>((event, emit) async {
      final List<Paquete> paquetes = state.paquetes.map((paquete) {
        paquete.isSelected = (paquete == event.paquete) ? true : false;
        paquete.modulos = paquete.modulos.map((modulo) {
          modulo.isSelected = (modulo == event.modulo) ? true : false;
          return modulo;
        }).toList();
        return paquete;
      }).toList();
      emit(const ModuloLoadingState());
      emit(ModuloSuccesState(paquetes: paquetes));
    });
  }
}

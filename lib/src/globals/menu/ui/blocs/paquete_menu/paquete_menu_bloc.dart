import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/modulo_menu.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/pagina_menu.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/paquete_menu.dart';
import 'package:switrans_2_0/src/globals/menu/domain/repositories/abstract_paquete_menu_repository.dart';
part 'paquete_menu_event.dart';
part 'paquete_menu_state.dart';

class PaquetesMenuBloc extends Bloc<ModuloEvent, ModuloState> {
  final AbstractPaqueteMenuRepository _moduloRepository;
  PaquetesMenuBloc(this._moduloRepository) : super(ModuloInitial()) {
    on<ModuloEvent>((event, emit) {});
    on<ActiveteModuloEvent>((event, emit) async {
      emit(const ModuloLoadingState());
      final dataState = await _moduloRepository.getModulos();
      emit(ModuloSuccesState(paquetes: dataState.data!));
    });

    on<ChangedModuloEvent>((event, emit) {
      final List<PaqueteMenu> paquetes = state.paquetes.map((paquete) {
        paquete.isSelected = (paquete == event.paquete) ? true : false;
        paquete.modulos = paquete.modulos.map((modulo) {
          modulo.isSelected = (modulo == event.modulo) ? true : false;
          modulo.paginas = modulo.paginas.map((pagina) {
            pagina.isSelected = (pagina == event.pagina) ? true : false;
            return pagina;
          }).toList();
          return modulo;
        }).toList();
        return paquete;
      }).toList();

      emit(const ModuloLoadingState());
      emit(ModuloSuccesState(paquetes: paquetes));
    });
  }
}

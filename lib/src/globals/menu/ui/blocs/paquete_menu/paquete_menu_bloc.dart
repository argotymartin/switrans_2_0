import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/modulo_menu.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/pagina_menu.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/paquete_menu.dart';
import 'package:switrans_2_0/src/globals/menu/domain/repositories/abstract_paquete_menu_repository.dart';
part 'paquete_menu_event.dart';
part 'paquete_menu_state.dart';

class PaqueteMenuBloc extends Bloc<PaqueteMenuEvent, PaqueteMenuState> {
  final AbstractPaqueteMenuRepository _moduloRepository;
  PaqueteMenuBloc(this._moduloRepository) : super(PaqueteMenuInitial()) {
    on<PaqueteMenuEvent>((event, emit) {});
    on<ActivetePaqueteMenuEvent>((event, emit) async {
      emit(const PaqueteMenuLoadingState());
      final dataState = await _moduloRepository.getModulos();
      emit(PaqueteMenuSuccesState(paquetes: dataState.data!));
    });

    on<SelectedPaqueteMenuEvent>((event, emit) {
      emit(const PaqueteMenuLoadingState());
      emit(PaqueteMenuSuccesState(paquetes: event.paquetes));
    });
  }

  void onPaqueteSelected(PaqueteMenu paqueteMenu, bool isSelected) {
    List<PaqueteMenu> paquetes = state.paquetes.map((paquete) {
      paquete.isSelected = (paquete == paqueteMenu) ? isSelected : false;
      return paquete;
    }).toList();

    add(SelectedPaqueteMenuEvent(paquetes));
  }

  void onModuloSelected(ModuloMenu moduloMenu, bool isSelected) {
    final List<PaqueteMenu> paquetes = state.paquetes.map((paquete) {
      paquete.modulos = paquete.modulos.map((modulo) {
        modulo.isSelected = (modulo == moduloMenu) ? isSelected : false;
        return modulo;
      }).toList();
      return paquete;
    }).toList();

    add(SelectedPaqueteMenuEvent(paquetes));
  }

  String onPaginaSelected(PaginaMenu paginaMenu, bool isSelected) {
    String path = '';
    final List<PaqueteMenu> paquetes = state.paquetes.map((paquete) {
      paquete.modulos = paquete.modulos.map((modulo) {
        modulo.paginas = modulo.paginas.map((pagina) {
          pagina.isSelected = (pagina == paginaMenu) ? isSelected : false;
          if (pagina == paginaMenu) path = '${paquete.path}${modulo.path}${pagina.path}';
          return pagina;
        }).toList();
        return modulo;
      }).toList();
      return paquete;
    }).toList();

    add(SelectedPaqueteMenuEvent(paquetes));
    return path;
  }
}

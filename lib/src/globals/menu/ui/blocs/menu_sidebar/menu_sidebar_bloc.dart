import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/globals/menu/data/models/paquete_menu_model.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/modulo_menu.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/pagina_menu.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/paquete_menu.dart';
import 'package:switrans_2_0/src/globals/menu/domain/repositories/abstract_menu_sidebar_repository.dart';
part 'menu_sidebar_event.dart';
part 'menu_sidebar_state.dart';

class MenuSidebarBloc extends Bloc<MenuSidebarEvent, MenuSidebarState> {
  final AbstractMenuSidebarRepository _moduloRepository;
  MenuSidebarBloc(this._moduloRepository) : super(const MenuSidebarInitialState()) {
    List<PaqueteMenu> paquetes2 = [];
    on<ActiveteMenuSidebarEvent>((event, emit) async {
      emit(const MenuSidebarLoadingState());
      final dataState = await _moduloRepository.getModulos();
      paquetes2 = dataState.data!;
      emit(MenuSidebarSuccesState(paquetes: paquetes2));
    });

    on<SelectedMenuSidebarEvent>((event, emit) {
      emit(const MenuSidebarLoadingState());
      emit(MenuSidebarSuccesState(paquetes: event.paquetes));
    });

    on<SearchMenuSidebarEvent>((event, emit) {
      emit(const MenuSidebarLoadingState());

      if (event.query.isEmpty) {
        emit(MenuSidebarSuccesState(paquetes: paquetes2));
        return;
      }

      final String encodedPackages = jsonEncode(paquetes2);
      final List<PaqueteMenu> filteredPackages =
          jsonDecode(encodedPackages).map<PaqueteMenu>((dynamic packageJson) => PaqueteMenuModel.fromJson(packageJson)).toList();

      for (var paquete in filteredPackages) {
        paquete.modulos = paquete.modulos.where((modulo) => modulo.texto.toLowerCase().contains(event.query.toLowerCase())).toList();
        paquete.isSelected = true;
      }
      final paquetesfilter = filteredPackages.where((element) => element.modulos.isNotEmpty).toList();

      emit(MenuSidebarSuccesState(paquetes: paquetesfilter));
    });
  }

  void onPaqueteSelected(PaqueteMenu paqueteMenu, bool isSelected) {
    List<PaqueteMenu> paquetes = state.paquetes.map((paquete) {
      paquete.isSelected = (paquete == paqueteMenu) ? isSelected : false;
      return paquete;
    }).toList();

    add(SelectedMenuSidebarEvent(paquetes));
  }

  void onModuloSelected(ModuloMenu moduloMenu, bool isSelected) {
    final List<PaqueteMenu> paquetes = state.paquetes.map((paquete) {
      paquete.modulos = paquete.modulos.map((modulo) {
        modulo.isSelected = (modulo == moduloMenu) ? isSelected : false;
        return modulo;
      }).toList();
      return paquete;
    }).toList();

    add(SelectedMenuSidebarEvent(paquetes));
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

    add(SelectedMenuSidebarEvent(paquetes));
    return path;
  }
}

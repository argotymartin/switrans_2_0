import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/globals/menu/data/models/paquete_menu_model.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/modulo_menu.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/pagina_menu.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/paquete_menu.dart';
import 'package:switrans_2_0/src/globals/menu/domain/repositories/abstract_menu_sidebar_repository.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';
part 'menu_sidebar_event.dart';
part 'menu_sidebar_state.dart';

class MenuSidebarBloc extends Bloc<MenuSidebarEvent, MenuSidebarState> {
  final AbstractMenuSidebarRepository _moduloRepository;
  MenuSidebarBloc(this._moduloRepository) : super(const MenuSidebarInitialState()) {
    List<PaqueteMenu> paquetes2 = <PaqueteMenu>[];
    on<ActiveteMenuSidebarEvent>((ActiveteMenuSidebarEvent event, Emitter<MenuSidebarState> emit) async {
      emit(const MenuSidebarLoadingState());
      final DataState<List<PaqueteMenu>> dataState = await _moduloRepository.getModulos();
      if (dataState.data != null && dataState is DataSuccess) {
        paquetes2 = dataState.data!;
        emit(MenuSidebarSuccesState(paquetes: paquetes2));
      } else {
        emit(MenuSidebarErrorState(error: dataState.error!));
      }
    });

    on<SelectedMenuSidebarEvent>((SelectedMenuSidebarEvent event, Emitter<MenuSidebarState> emit) {
      emit(const MenuSidebarLoadingState());
      emit(MenuSidebarSuccesState(paquetes: event.paquetes));
    });

    on<SearchMenuSidebarEvent>((SearchMenuSidebarEvent event, Emitter<MenuSidebarState> emit) {
      emit(const MenuSidebarLoadingState());

      if (event.query.isEmpty) {
        emit(MenuSidebarSuccesState(paquetes: paquetes2));
        return;
      }

      final String encodedPackages = jsonEncode(paquetes2);
      final List<PaqueteMenu> filteredPackages =
          jsonDecode(encodedPackages).map<PaqueteMenu>((dynamic packageJson) => PaqueteMenuModel.fromJson(packageJson)).toList();

      for (final PaqueteMenu paquete in filteredPackages) {
        paquete.modulos =
            paquete.modulos.where((ModuloMenu modulo) => modulo.texto.toLowerCase().contains(event.query.toLowerCase())).toList();
        paquete.isSelected = true;
      }
      final List<PaqueteMenu> paquetesfilter = filteredPackages.where((PaqueteMenu element) => element.modulos.isNotEmpty).toList();

      emit(MenuSidebarSuccesState(paquetes: paquetesfilter));
    });
  }

  void onPaqueteSelected({required PaqueteMenu paqueteMenu, required bool isSelected}) {
    final List<PaqueteMenu> paquetes = state.paquetes.map((PaqueteMenu paquete) {
      if (paquete == paqueteMenu) {
        paquete.isSelected = isSelected;
      } else {
        paquete.isSelected = false;
      }
      return paquete;
    }).toList();

    add(SelectedMenuSidebarEvent(paquetes));
  }

  void onModuloSelected({
    required ModuloMenu moduloMenu,
    required bool isSelected,
  }) {
    final List<PaqueteMenu> paquetes = state.paquetes.map((PaqueteMenu paquete) {
      paquete.modulos = paquete.modulos.map((ModuloMenu modulo) {
        if (modulo == moduloMenu) {
          modulo.isSelected = isSelected;
        } else {
          modulo.isSelected = false;
        }
        return modulo;
      }).toList();
      return paquete;
    }).toList();

    add(SelectedMenuSidebarEvent(paquetes));
  }

  String onPaginaSelected({
    required PaginaMenu paginaMenu,
    required bool isSelected,
  }) {
    String path = '';
    final List<PaqueteMenu> paquetes = state.paquetes.map((PaqueteMenu paquete) {
      paquete.modulos = paquete.modulos.map((ModuloMenu modulo) {
        modulo.paginas = modulo.paginas.map((PaginaMenu pagina) {
          if (pagina == paginaMenu) {
            pagina.isSelected = isSelected;
          } else {
            pagina.isSelected = false;
          }
          if (pagina == paginaMenu) {
            path = '${paquete.path}${modulo.path}${pagina.path}/';
          }
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

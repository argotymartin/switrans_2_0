import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/config/share_preferences/preferences.dart';
import 'package:switrans_2_0/src/globals/menu/data/models/paquete_menu_model.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/modulo_menu.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/pagina_menu.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/paquete_menu.dart';
import 'package:switrans_2_0/src/globals/menu/domain/repositories/abstract_menu_sidebar_repository.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final AbstractMenuSidebarRepository _moduloRepository;

  MenuBloc(this._moduloRepository) : super(const MenuState().initial()) {
    on<ActivateMenuEvent>(_onActivateMenuEvent);
    on<SelectedPaqueteMenuEvent>(_onSelectedPaqueteMenuEvent);
    on<SelectedModuloMenuEvent>(_onSelectedModuloMenuEvent);
    on<SelectedPaginaMenuEvent>(_onSelectedPaginaMenuEvent);
    on<SearchMenuEvent>(_onSearchMenuEvent);
    on<BlockedMenuEvent>((BlockedMenuEvent event, Emitter<MenuState> emit) {
      emit(state.copyWith(status: MenuStatus.loading));
      emit(state.copyWith(status: MenuStatus.succes, isBlocked: event.isBlocked));
    });

    on<ExpandedMenuEvent>((ExpandedMenuEvent event, Emitter<MenuState> emit) {
      emit(state.copyWith(status: MenuStatus.loading));
      emit(state.copyWith(status: MenuStatus.succes, isOpenMenu: event.isExpanded));
    });

    on<MinimizedMenuEvent>((MinimizedMenuEvent event, Emitter<MenuState> emit) {
      emit(state.copyWith(status: MenuStatus.loading));
      emit(state.copyWith(status: MenuStatus.succes, isMinimize: event.isMinimized));
    });
  }

  Future<void> _onActivateMenuEvent(ActivateMenuEvent event, Emitter<MenuState> emit) async {
    emit(state.copyWith(status: MenuStatus.loading));
    final DataState<List<PaqueteMenu>> dataState = await _moduloRepository.getModulos();
    if (dataState.data != null && dataState is DataSuccess) {
      Preferences.paquetes = jsonEncode(dataState.data);
      emit(state.copyWith(status: MenuStatus.succes, paquetes: dataState.data));
    } else {
      emit(state.copyWith(status: MenuStatus.error, error: dataState.error));
    }
  }

  Future<void> _onSelectedPaqueteMenuEvent(SelectedPaqueteMenuEvent event, Emitter<MenuState> emit) async {
    emit(state.copyWith(status: MenuStatus.loading));
    emit(state.copyWith(status: MenuStatus.succes, paqueteMenu: event.paqueteMenu));
  }

  Future<void> _onSelectedModuloMenuEvent(SelectedModuloMenuEvent event, Emitter<MenuState> emit) async {
    emit(state.copyWith(status: MenuStatus.loading));
    emit(state.copyWith(status: MenuStatus.succes, moduloMenu: event.moduloMenu));
  }

  Future<void> _onSelectedPaginaMenuEvent(SelectedPaginaMenuEvent event, Emitter<MenuState> emit) async {
    emit(state.copyWith(status: MenuStatus.loading));
    emit(state.copyWith(status: MenuStatus.succes, paginaMenu: event.paginaMenu));
  }

  Future<void> _onSearchMenuEvent(SearchMenuEvent event, Emitter<MenuState> emit) async {
    final dynamic encodedPackages = jsonDecode(Preferences.paquetes);
    final List<PaqueteMenu> filteredPackages =
        encodedPackages.map<PaqueteMenu>((dynamic packageJson) => PaqueteMenuModel.fromJson(packageJson)).toList();
    emit(state.copyWith(status: MenuStatus.loading));
    if (event.query.isEmpty) {
      emit(state.copyWith(status: MenuStatus.succes, paquetes: filteredPackages));
      return;
    }

    for (final PaqueteMenu paquete in filteredPackages) {
      paquete.isSelected = true;
      paquete.modulos =
          paquete.modulos.where((ModuloMenu modulo) => modulo.texto.toLowerCase().contains(event.query.toLowerCase())).toList();
    }
    final List<PaqueteMenu> paquetesfilter = filteredPackages.where((PaqueteMenu element) => element.modulos.isNotEmpty).toList();

    emit(state.copyWith(status: MenuStatus.succes, paquetes: paquetesfilter));
  }
}

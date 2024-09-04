part of 'menu_bloc.dart';

sealed class MenuEvent extends Equatable {
  const MenuEvent();

  @override
  List<Object> get props => <Object>[];
}

class ActivateMenuEvent extends MenuEvent {
  const ActivateMenuEvent();
}

class SelectedPaginaMenuEvent extends MenuEvent {
  final PaginaMenu paginaMenu;
  const SelectedPaginaMenuEvent(this.paginaMenu);
}

class SelectedModuloMenuEvent extends MenuEvent {
  final ModuloMenu moduloMenu;
  const SelectedModuloMenuEvent(this.moduloMenu);
}

class SelectedPaqueteMenuEvent extends MenuEvent {
  final PaqueteMenu paqueteMenu;
  const SelectedPaqueteMenuEvent(this.paqueteMenu);
}

class SearchMenuEvent extends MenuEvent {
  final String query;
  const SearchMenuEvent(this.query);
}

class BlockedMenuEvent extends MenuEvent {
  final bool isBlocked;
  const BlockedMenuEvent(this.isBlocked);
}

class ExpandedMenuEvent extends MenuEvent {
  final bool isExpanded;
  const ExpandedMenuEvent(this.isExpanded);
}

class MinimizedMenuEvent extends MenuEvent {
  final bool isMinimized;
  const MinimizedMenuEvent(this.isMinimized);
}

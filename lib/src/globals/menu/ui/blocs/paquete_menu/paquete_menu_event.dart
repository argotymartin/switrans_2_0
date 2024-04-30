part of 'paquete_menu_bloc.dart';

sealed class PaqueteMenuEvent extends Equatable {
  const PaqueteMenuEvent();

  @override
  List<Object> get props => [];
}

class GetPaqueteMenuEvent extends PaqueteMenuEvent {
  const GetPaqueteMenuEvent();
}

class ActivetePaqueteMenuEvent extends PaqueteMenuEvent {
  const ActivetePaqueteMenuEvent();
}

class ChangedPaqueteMenuEvent extends PaqueteMenuEvent {
  final PaqueteMenu paquete;
  final ModuloMenu modulo;
  final PaginaMenu pagina;
  const ChangedPaqueteMenuEvent(this.paquete, this.modulo, this.pagina);
}

class SelectedPaqueteMenuEvent extends PaqueteMenuEvent {
  final List<PaqueteMenu> paquetes;
  const SelectedPaqueteMenuEvent(this.paquetes);
}

class SelectedModuloMenuEvent extends PaqueteMenuEvent {
  final List<PaginaMenu> paqueteMenu;
  const SelectedModuloMenuEvent(this.paqueteMenu);
}

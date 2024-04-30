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

class SelectedPaqueteMenuEvent extends PaqueteMenuEvent {
  final List<PaqueteMenu> paquetes;
  const SelectedPaqueteMenuEvent(this.paquetes);
}

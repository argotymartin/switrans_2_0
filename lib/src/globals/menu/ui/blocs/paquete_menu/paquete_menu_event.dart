part of 'paquete_menu_bloc.dart';

sealed class ModuloEvent extends Equatable {
  const ModuloEvent();

  @override
  List<Object> get props => [];
}

class GetModuloEvent extends ModuloEvent {
  const GetModuloEvent();
}

class ActiveteModuloEvent extends ModuloEvent {
  const ActiveteModuloEvent();
}

class ChangedModuloEvent extends ModuloEvent {
  final PaqueteMenu paquete;
  final ModuloMenu modulo;
  final PaginaMenu pagina;
  const ChangedModuloEvent(this.paquete, this.modulo, this.pagina);
}

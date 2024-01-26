part of 'modulo_bloc.dart';

sealed class ModuloEvent extends Equatable {
  const ModuloEvent();

  @override
  List<Object> get props => [];
}

class GetModuloEvent extends ModuloEvent {}

class ActiveteModuloEvent extends ModuloEvent {
  const ActiveteModuloEvent();
}

class ChangedModuloEvent extends ModuloEvent {
  final Modulo modulo;
  final Pagina pagina;
  const ChangedModuloEvent(this.modulo, this.pagina);
}

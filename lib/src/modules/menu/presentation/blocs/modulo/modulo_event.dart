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

class SelectedModuloEvent extends ModuloEvent {
  const SelectedModuloEvent();
}

part of  'modulo_bloc.dart';

sealed class ModuloEvent extends Equatable {
  const ModuloEvent();
  @override
  List<Object> get props => [];
}

class SetModuloEvent extends ModuloEvent {
   final ModuloRequest request;
   const SetModuloEvent(this.request);
}

class UpdateModuloEvent extends ModuloEvent {
  final ModuloRequest request;
  const UpdateModuloEvent(this.request);
}

class GetModuloEvent extends ModuloEvent {
  final ModuloRequest request;
  const GetModuloEvent(this.request);
}

class ActiveteModuloEvent extends ModuloEvent {
  const ActiveteModuloEvent();
}

class ErrorFormModuloEvent extends ModuloEvent {
  final String exception;
  const ErrorFormModuloEvent(this.exception);
}

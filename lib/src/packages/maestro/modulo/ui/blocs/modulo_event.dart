part of 'modulo_bloc.dart';

abstract class ModuloEvent extends Equatable {
  const ModuloEvent();
  @override
  List<Object> get props => <Object>[];
}

class SetModuloEvent extends ModuloEvent {
  final ModuloRequest request;
  const SetModuloEvent(this.request);
}

class InitializationModuloEvent extends ModuloEvent {
  const InitializationModuloEvent();
}

class UpdateModuloEvent extends ModuloEvent {
  final List<ModuloRequest> requestList;
  const UpdateModuloEvent(this.requestList);
}

class GetModuloEvent extends ModuloEvent {
  final ModuloRequest request;
  const GetModuloEvent(this.request);
}

class ErrorFormModuloEvent extends ModuloEvent {
  final String error;
  const ErrorFormModuloEvent(this.error);
}

class CleanFormModuloEvent extends ModuloEvent {
  const CleanFormModuloEvent();
}

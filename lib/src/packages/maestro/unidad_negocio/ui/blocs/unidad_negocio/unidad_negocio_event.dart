part of 'unidad_negocio_bloc.dart';

abstract class UnidadNegocioEvent extends Equatable {
  const UnidadNegocioEvent();
  @override
  List<Object> get props => <Object>[];
}

class SetUnidadNegocioEvent extends UnidadNegocioEvent {
  final UnidadNegocioRequest request;
  const SetUnidadNegocioEvent(this.request);
}

class InitializationUnidadNegocioEvent extends UnidadNegocioEvent {
  const InitializationUnidadNegocioEvent();
}

class UpdateUnidadNegocioEvent extends UnidadNegocioEvent {
  final List<UnidadNegocioRequest> requestList;
  const UpdateUnidadNegocioEvent(this.requestList);
}

class GetUnidadNegocioEvent extends UnidadNegocioEvent {
  const GetUnidadNegocioEvent();
}

class ErrorFormUnidadNegocioEvent extends UnidadNegocioEvent {
  final String error;
  const ErrorFormUnidadNegocioEvent(this.error);
}

class CleanFormUnidadNegocioEvent extends UnidadNegocioEvent {
  const CleanFormUnidadNegocioEvent();
}
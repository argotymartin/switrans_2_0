part of 'unidad_negocio_bloc.dart';

abstract class UnidadNegocioEvent extends Equatable {
  const UnidadNegocioEvent();
  @override
  List<Object> get props => <Object>[];
}

class InitialUnidadNegocioEvent extends UnidadNegocioEvent {
  const InitialUnidadNegocioEvent();
}

class GetUnidadNegociosEvent extends UnidadNegocioEvent {
  final UnidadNegocioRequest request;
  const GetUnidadNegociosEvent(this.request);
}

class SetUnidadNegocioEvent extends UnidadNegocioEvent {
  final UnidadNegocioRequest request;
  const SetUnidadNegocioEvent(this.request);
}

class UpdateUnidadNegociosEvent extends UnidadNegocioEvent {
  final List<EntityUpdate<UnidadNegocioRequest>> requestList;
  const UpdateUnidadNegociosEvent(this.requestList);
}

class ErrorFormUnidadNegocioEvent extends UnidadNegocioEvent {
  final String error;
  const ErrorFormUnidadNegocioEvent(this.error);
}

class CleanFormUnidadNegocioEvent extends UnidadNegocioEvent {
  const CleanFormUnidadNegocioEvent();
}

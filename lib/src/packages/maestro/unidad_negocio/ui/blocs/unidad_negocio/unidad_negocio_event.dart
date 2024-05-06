part of 'unidad_negocio_bloc.dart';

abstract class UnidadNegocioEvent extends Equatable {
  const UnidadNegocioEvent();

  @override
  List<Object> get props => [];
}

class GetUnidadNegocioEvent extends UnidadNegocioEvent {
  final UnidadNegocioRequest request;
  const GetUnidadNegocioEvent(this.request);
}

class SetUnidadNegocioEvent extends UnidadNegocioEvent {
  final UnidadNegocioRequest request;
  const SetUnidadNegocioEvent(this.request);
}

class UpdateUnidadNegocioEvent extends UnidadNegocioEvent {
  final UnidadNegocioRequest request;
  const UpdateUnidadNegocioEvent(this.request);
}

class ErrorFormUnidadNegocioEvent extends UnidadNegocioEvent {
  final String error;
  const ErrorFormUnidadNegocioEvent(this.error);
}



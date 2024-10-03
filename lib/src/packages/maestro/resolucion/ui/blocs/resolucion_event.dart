part of 'resolucion_bloc.dart';

abstract class ResolucionEvent extends Equatable {
  const ResolucionEvent();
  @override
  List<Object> get props => <Object>[];
}

class InitializationResolucionEvent extends ResolucionEvent {
  const InitializationResolucionEvent();
}

class GetResolucionesEvent extends ResolucionEvent {
  final ResolucionRequest request;
  const GetResolucionesEvent(this.request);
}

class SetResolucionEvent extends ResolucionEvent {
  final ResolucionRequest request;
  const SetResolucionEvent(this.request);
}

class UpdateResolucionesEvent extends ResolucionEvent {
  final List<ResolucionRequest> requestList;
  const UpdateResolucionesEvent(this.requestList);
}

class ErrorFormResolucionEvent extends ResolucionEvent {
  final String error;
  const ErrorFormResolucionEvent(this.error);
}

class CleanFormResolucionEvent extends ResolucionEvent {
  const CleanFormResolucionEvent();
}

class SelectResolucionEmpresaEvent extends ResolucionEvent {
  final ResolucionEmpresa resolucionEmpresa;
  const SelectResolucionEmpresaEvent(this.resolucionEmpresa);
}

class CleanSelectResolucionEmpresaEvent extends ResolucionEvent {
  const CleanSelectResolucionEmpresaEvent();
}

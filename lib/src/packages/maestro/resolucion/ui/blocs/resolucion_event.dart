part of 'resolucion_bloc.dart';

abstract class ResolucionEvent extends Equatable {
  final ResolucionEmpresa? requestEmpresa;
  final ResolucionRequest? request;
  final List<ResolucionRequest>? requestList;
  final String? error;

  const ResolucionEvent({this.request, this.error, this.requestList, this.requestEmpresa});
  @override
  List<Object> get props => <Object>[];
}

class InitializationResolucionEvent extends ResolucionEvent {
  const InitializationResolucionEvent();
}

class GetResolucionesEvent extends ResolucionEvent {
  const GetResolucionesEvent({super.request});
}

class SetResolucionEvent extends ResolucionEvent {
  const SetResolucionEvent({super.request});
}

class UpdateResolucionesEvent extends ResolucionEvent {
  const UpdateResolucionesEvent({super.requestList});
}

class ErrorFormResolucionEvent extends ResolucionEvent {
  const ErrorFormResolucionEvent({super.error});
}

class CleanFormResolucionEvent extends ResolucionEvent {
  const CleanFormResolucionEvent();
}

class SelectResolucionEmpresaEvent extends ResolucionEvent {
  const SelectResolucionEmpresaEvent({super.requestEmpresa});
}

class CleanSelectResolucionEmpresaEvent extends ResolucionEvent {
  const CleanSelectResolucionEmpresaEvent();
}

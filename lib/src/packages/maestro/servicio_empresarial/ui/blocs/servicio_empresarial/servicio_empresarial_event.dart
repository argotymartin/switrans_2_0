part of 'servicio_empresarial_bloc.dart';

sealed class ServicioEmpresarialEvent extends Equatable {
  const ServicioEmpresarialEvent();

  @override
  List<Object> get props => <Object>[];
}

class InitializationServicioEmpresarialEvent extends ServicioEmpresarialEvent {
  const InitializationServicioEmpresarialEvent();
}

class GetServicioEmpresarialEvent extends ServicioEmpresarialEvent {
  const GetServicioEmpresarialEvent();
}

class UpdateServicioEmpresarialEvent extends ServicioEmpresarialEvent {
  final List<ServicioEmpresarialRequest> requestList;
  const UpdateServicioEmpresarialEvent(this.requestList);
}

class SetServicioEmpresarialEvent extends ServicioEmpresarialEvent {
  final ServicioEmpresarialRequest request;
  const SetServicioEmpresarialEvent(this.request);
}

class ErrorFormServicioEmpresarialEvent extends ServicioEmpresarialEvent {
  final String error;
  const ErrorFormServicioEmpresarialEvent(this.error);
}

class CleanFormServicioEmpresarialEvent extends ServicioEmpresarialEvent {
  const CleanFormServicioEmpresarialEvent();
}

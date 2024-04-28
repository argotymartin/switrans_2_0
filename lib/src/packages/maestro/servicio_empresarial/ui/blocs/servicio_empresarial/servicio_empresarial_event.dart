part of 'servicio_empresarial_bloc.dart';

sealed class ServicioEmpresarialEvent extends Equatable {
  const ServicioEmpresarialEvent();

  @override
  List<Object> get props => [];
}

class GetServicioEmpresarialEvent extends ServicioEmpresarialEvent {
  final ServicioEmpresarialRequest request;
  const GetServicioEmpresarialEvent(this.request);
}

class UpdateServicioEmpresarialEvent extends ServicioEmpresarialEvent {
  final ServicioEmpresarialRequest request;
  const UpdateServicioEmpresarialEvent(this.request);
}

class SetServicioEmpresarialEvent extends ServicioEmpresarialEvent {
  final ServicioEmpresarialRequest request;
  const SetServicioEmpresarialEvent(this.request);
}

class ErrorFormServicioEmpresarialEvent extends ServicioEmpresarialEvent {
  final String error;
  const ErrorFormServicioEmpresarialEvent(this.error);
}

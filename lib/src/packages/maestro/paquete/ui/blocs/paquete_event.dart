part of 'paquete_bloc.dart';

sealed class PaqueteEvent extends Equatable {
  const PaqueteEvent();
  @override
  List<Object> get props => <Object>[];
}

class SetPaqueteEvent extends PaqueteEvent {
  final PaqueteRequest request;
  const SetPaqueteEvent(this.request);
}

class UpdatePaqueteEvent extends PaqueteEvent {
  final PaqueteRequest request;
  const UpdatePaqueteEvent(this.request);
}

class GetPaqueteEvent extends PaqueteEvent {
  final PaqueteRequest request;
  const GetPaqueteEvent(this.request);
}

class ActivetePaqueteEvent extends PaqueteEvent {
  const ActivetePaqueteEvent();
}

class ErrorFormPaqueteEvent extends PaqueteEvent {
  final String exception;
  const ErrorFormPaqueteEvent(this.exception);
}

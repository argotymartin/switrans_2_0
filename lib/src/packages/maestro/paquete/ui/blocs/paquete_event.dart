part of 'paquete_bloc.dart';

sealed class PaqueteEvent extends Equatable {
  const PaqueteEvent();
  @override
  List<Object> get props => <Object>[];
}

class InitialPaqueteEvent extends PaqueteEvent {
  const InitialPaqueteEvent();
}

class SetPaqueteEvent extends PaqueteEvent {
  final PaqueteRequest request;
  const SetPaqueteEvent(this.request);
}

class UpdatePaqueteEvent extends PaqueteEvent {
  final List<PaqueteRequest> requestList;
  const UpdatePaqueteEvent(this.requestList);
}

class GetPaqueteEvent extends PaqueteEvent {
  final PaqueteRequest request;
  const GetPaqueteEvent(this.request);
}

class ActivetePaqueteEvent extends PaqueteEvent {
  const ActivetePaqueteEvent();
}

class ErrorFormPaqueteEvent extends PaqueteEvent {
  final String error;
  const ErrorFormPaqueteEvent(this.error);
}

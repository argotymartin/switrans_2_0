part of 'pais_bloc.dart';

abstract class PaisEvent extends Equatable {
  const PaisEvent();
  @override
  List<Object> get props => <Object>[];
}

class InitialPaisEvent extends PaisEvent {
  const InitialPaisEvent();
}

class GetPaisesEvent extends PaisEvent {
  const GetPaisesEvent();
}

class SetPaisEvent extends PaisEvent {
  final PaisRequest request;
  const SetPaisEvent(this.request);
}

class UpdatePaisEvent extends PaisEvent {
  final List<PaisRequest> requestList;
  const UpdatePaisEvent(this.requestList);
}

class ActivetePaisEvent extends PaisEvent {
  const ActivetePaisEvent();
}

class ErrorFormPaisEvent extends PaisEvent {
  final String error;
  const ErrorFormPaisEvent(this.error);
}

class CleanFormPaisEvent extends PaisEvent {
  const CleanFormPaisEvent();
}

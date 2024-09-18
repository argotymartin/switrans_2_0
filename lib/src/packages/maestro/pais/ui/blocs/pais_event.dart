part of 'pais_bloc.dart';

sealed class PaisEvent extends Equatable {
  const PaisEvent();
  @override
  List<Object> get props => <Object>[];
}

class InitialPaisEvent extends PaisEvent {
  const InitialPaisEvent();
}

class SetPaisEvent extends PaisEvent {
  final PaisRequest request;
  const SetPaisEvent(this.request);
}

class UpdatePaisEvent extends PaisEvent {
  final List<PaisRequest> requestList;
  const UpdatePaisEvent(this.requestList);
}

class GetPaisEvent extends PaisEvent {
  const GetPaisEvent();
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

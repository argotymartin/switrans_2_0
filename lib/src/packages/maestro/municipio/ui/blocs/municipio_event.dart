part of 'municipio_bloc.dart';

abstract class MunicipioEvent extends Equatable {
  const MunicipioEvent();
  @override
  List<Object> get props => <Object>[];
}

class InitialMunicipioEvent extends MunicipioEvent {
  const InitialMunicipioEvent();
}

class GetMunicipiosEvent extends MunicipioEvent {
  final MunicipioRequest request;
  const GetMunicipiosEvent(this.request);
}

class SetMunicipioEvent extends MunicipioEvent {
  final MunicipioRequest request;
  const SetMunicipioEvent(this.request);
}

class UpdateMunicipioEvent extends MunicipioEvent {
  final List<MunicipioRequest> requestList;
  const UpdateMunicipioEvent(this.requestList);
}

class ErrorFormMunicipioEvent extends MunicipioEvent {
  final String error;
  const ErrorFormMunicipioEvent(this.error);
}

class CleanFormMunicipioEvent extends MunicipioEvent {
  const CleanFormMunicipioEvent();
}

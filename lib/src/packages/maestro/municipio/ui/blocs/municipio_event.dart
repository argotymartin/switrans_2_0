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

class UpdateMunicipiosEvent extends MunicipioEvent {
  final List<EntityUpdate<MunicipioRequest>> requestList;
  const UpdateMunicipiosEvent(this.requestList);
}

class ErrorFormMunicipioEvent extends MunicipioEvent {
  final String error;
  const ErrorFormMunicipioEvent(this.error);
}

class CleanFormMunicipioEvent extends MunicipioEvent {
  const CleanFormMunicipioEvent();
}

class SelectMunicipioPaisEvent extends MunicipioEvent {
  final MunicipioPais municipioPais;
  const SelectMunicipioPaisEvent(this.municipioPais);
}

class CleanSelectMunicipioPaisEvent extends MunicipioEvent {
  const CleanSelectMunicipioPaisEvent();
}

class UpdateNombreEvent extends MunicipioEvent {
  final String nombre;
  const UpdateNombreEvent(this.nombre);
}

part of 'departamento_bloc.dart';

abstract class DepartamentoEvent extends Equatable {
  const DepartamentoEvent();
  @override
  List<Object> get props => <Object>[];
}

class InitialDepartamentoEvent extends DepartamentoEvent {
  const InitialDepartamentoEvent();
}

class GetDepartamentoEvent extends DepartamentoEvent {
  final DepartamentoRequest request;
  const GetDepartamentoEvent(this.request);
}

class SetDepartamentoEvent extends DepartamentoEvent {
  final DepartamentoRequest request;
  const SetDepartamentoEvent(this.request);
}

class UpdateDepartamentoEvent extends DepartamentoEvent {
  final List<EntityUpdate<DepartamentoRequest>> requestList;
  const UpdateDepartamentoEvent(this.requestList);
}

class ErrorFormDepartamentoEvent extends DepartamentoEvent {
  final String error;
  const ErrorFormDepartamentoEvent(this.error);
}

class CleanFormDepartamentoEvent extends DepartamentoEvent {
  const CleanFormDepartamentoEvent();
}

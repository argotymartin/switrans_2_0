part of 'departamento_bloc.dart';

abstract class DepartamentoEvent extends Equatable {
  const DepartamentoEvent();
  @override
  List<Object> get props => <Object>[];
}

class SetDepartamentoEvent extends DepartamentoEvent {
  final DepartamentoRequest request;
  const SetDepartamentoEvent(this.request);
}

class InitialDepartamentoEvent extends DepartamentoEvent {
  const InitialDepartamentoEvent();
}

class UpdateDepartamentoEvent extends DepartamentoEvent {
  final List<DepartamentoRequest> requestList;
  const UpdateDepartamentoEvent(this.requestList);
}

class GetDepartamentoEvent extends DepartamentoEvent {
  const GetDepartamentoEvent();
}

class ErrorFormDepartamentoEvent extends DepartamentoEvent {
  final String error;
  const ErrorFormDepartamentoEvent(this.error);
}

class CleanFormDepartamentoEvent extends DepartamentoEvent {
  const CleanFormDepartamentoEvent();
}

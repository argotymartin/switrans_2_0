part of 'pagina_bloc.dart';

abstract class PaginaEvent extends Equatable {
  const PaginaEvent();
  @override
  List<Object> get props => <Object>[];
}

class InitialPaginaEvent extends PaginaEvent {
  const InitialPaginaEvent();
}

class GetPaginaEvent extends PaginaEvent {
  final PaginaRequest request;
  const GetPaginaEvent(this.request);
}

class SetPaginaEvent extends PaginaEvent {
  final PaginaRequest request;
  const SetPaginaEvent(this.request);
}

class UpdatePaginaEvent extends PaginaEvent {
  final List<EntityUpdate<PaginaRequest>> requestList;
  const UpdatePaginaEvent(this.requestList);
}

class ErrorFormPaginaEvent extends PaginaEvent {
  final String error;
  const ErrorFormPaginaEvent(this.error);
}

class CleanFormPaginaEvent extends PaginaEvent {
  const CleanFormPaginaEvent();
}

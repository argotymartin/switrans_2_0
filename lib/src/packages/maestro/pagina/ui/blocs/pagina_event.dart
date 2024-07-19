part of 'pagina_bloc.dart';

abstract class PaginaEvent extends Equatable {
  const PaginaEvent();
  @override
  List<Object> get props => <Object>[];
}

class SetPaginaEvent extends PaginaEvent {
  final PaginaRequest request;
  const SetPaginaEvent(this.request);
}

class UpdatePaginaEvent extends PaginaEvent {
  final PaginaRequest request;
  const UpdatePaginaEvent(this.request);
}

class GetPaginaEvent extends PaginaEvent {
  final PaginaRequest request;
  const GetPaginaEvent(this.request);
}

class ActivetePaginaEvent extends PaginaEvent {
  const ActivetePaginaEvent();
}

class ErrorFormPaginaEvent extends PaginaEvent {
  final String exception;
  const ErrorFormPaginaEvent(this.exception);
}

class InitialPaginaEvent extends PaginaEvent {
  const InitialPaginaEvent();
}

part of 'accion_documento_bloc.dart';

sealed class AccionDocumentoEvent extends Equatable {
  const AccionDocumentoEvent();

  @override
  List<Object> get props => <Object>[];
}

class InitializationAccionDocumentoEvent extends AccionDocumentoEvent {
  const InitializationAccionDocumentoEvent();
}

class SetAccionDocumentoEvent extends AccionDocumentoEvent {
  final AccionDocumentoRequest request;
  const SetAccionDocumentoEvent(this.request);
}

class UpdateAccionDocumentoEvent extends AccionDocumentoEvent {
  final List<AccionDocumentoRequest> requestList;
  const UpdateAccionDocumentoEvent(this.requestList);
}

class GetAccionDocumentoEvent extends AccionDocumentoEvent {
  final AccionDocumentoRequest request;
  const GetAccionDocumentoEvent(this.request);
}

class ErrorFormAccionDocumentoEvent extends AccionDocumentoEvent {
  final String error;
  const ErrorFormAccionDocumentoEvent(this.error);
}

class CleanFormAccionDocumentoEvent extends AccionDocumentoEvent {
  const CleanFormAccionDocumentoEvent();
}

part of 'accion_documento_bloc.dart';

abstract class AccionDocumentoEvent extends Equatable {
  const AccionDocumentoEvent();
  @override
  List<Object> get props => <Object>[];
}

class InitialAccionDocumentoEvent extends AccionDocumentoEvent {
  const InitialAccionDocumentoEvent();
}

class GetAccionDocumentosEvent extends AccionDocumentoEvent {
  final AccionDocumentoRequest request;
  const GetAccionDocumentosEvent(this.request);
}

class SetAccionDocumentoEvent extends AccionDocumentoEvent {
  final AccionDocumentoRequest request;
  const SetAccionDocumentoEvent(this.request);
}

class UpdateAccionDocumentosEvent extends AccionDocumentoEvent {
  final List<EntityUpdate<AccionDocumentoRequest>> requestList;
  const UpdateAccionDocumentosEvent(this.requestList);
}

class ErrorFormAccionDocumentoEvent extends AccionDocumentoEvent {
  final String error;
  const ErrorFormAccionDocumentoEvent(this.error);
}

class CleanFormAccionDocumentoEvent extends AccionDocumentoEvent {
  const CleanFormAccionDocumentoEvent();
}

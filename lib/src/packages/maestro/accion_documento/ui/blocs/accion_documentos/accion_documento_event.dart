part of 'accion_documento_bloc.dart';

sealed class AccionDocumentoEvent extends Equatable {
  const AccionDocumentoEvent();

  @override
  List<Object> get props => [];
}

class SetAccionDocumentoEvent extends AccionDocumentoEvent {
  final AccionDocumentoRequest request;
  const SetAccionDocumentoEvent(this.request);
}

class GetAccionDocumentoEvent extends AccionDocumentoEvent {
  final AccionDocumentoRequest request;
  const GetAccionDocumentoEvent(this.request);
}

class ActiveteAccionDocumentoEvent extends AccionDocumentoEvent {
  const ActiveteAccionDocumentoEvent();
}

class ErrorFormAccionDocumentoEvent extends AccionDocumentoEvent {
  final String error;
  const ErrorFormAccionDocumentoEvent(this.error);
}

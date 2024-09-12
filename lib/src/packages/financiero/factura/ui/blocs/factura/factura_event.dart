part of 'factura_bloc.dart';

abstract class FacturaEvent extends Equatable {
  const FacturaEvent();

  @override
  List<Object> get props => <Object>[];
}

class GetInitialFormFacturaEvent extends FacturaEvent {
  const GetInitialFormFacturaEvent();
}

class ErrorFacturaEvent extends FacturaEvent {
  final String error;
  const ErrorFacturaEvent(this.error);
}

class GetDocumentosFacturaEvent extends FacturaEvent {
  final FormFacturaRequest request;
  const GetDocumentosFacturaEvent(this.request);
}

class SuccesFacturaEvent extends FacturaEvent {
  const SuccesFacturaEvent();
}

class AddDocumentoFacturaEvent extends FacturaEvent {
  final Documento documento;
  const AddDocumentoFacturaEvent(this.documento);
}

class RemoveDocumentoFacturaEvent extends FacturaEvent {
  final Documento documento;
  const RemoveDocumentoFacturaEvent(this.documento);
}

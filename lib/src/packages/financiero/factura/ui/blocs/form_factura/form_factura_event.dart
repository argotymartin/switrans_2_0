part of 'form_factura_bloc.dart';

abstract class FormFacturaEvent extends Equatable {
  const FormFacturaEvent();

  @override
  List<Object> get props => <Object>[];
}

class GetFormFacturaEvent extends FormFacturaEvent {
  const GetFormFacturaEvent();
}

class ErrorFormFacturaEvent extends FormFacturaEvent {
  final String error;
  const ErrorFormFacturaEvent(this.error);
}

class DocumentosFormFacturaEvent extends FormFacturaEvent {
  final FormFacturaRequest request;
  const DocumentosFormFacturaEvent(this.request);
}

class SuccesFormFacturaEvent extends FormFacturaEvent {
  const SuccesFormFacturaEvent();
}

class AddDocumentoFormFacturaEvent extends FormFacturaEvent {
  final Documento documento;
  const AddDocumentoFormFacturaEvent(this.documento);
}

class RemoveDocumentoFormFacturaEvent extends FormFacturaEvent {
  final Documento documento;
  const RemoveDocumentoFormFacturaEvent(this.documento);
}

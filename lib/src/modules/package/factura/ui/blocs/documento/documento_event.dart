part of 'documento_bloc.dart';

sealed class DocumentoEvent extends Equatable {
  const DocumentoEvent();

  @override
  List<Object> get props => [];
}

class GetFacturaEvent extends DocumentoEvent {
  const GetFacturaEvent();
}

class GetDocumentoEvent extends DocumentoEvent {
  const GetDocumentoEvent();
}

class ChangedDocumentoEvent extends DocumentoEvent {
  final List<Documento> documentos;
  const ChangedDocumentoEvent(this.documentos);
}

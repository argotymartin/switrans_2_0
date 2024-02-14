part of 'factura_bloc.dart';

sealed class FacturaEvent extends Equatable {
  const FacturaEvent();

  @override
  List<Object> get props => [];
}

class GetFacturaEvent extends FacturaEvent {
  const GetFacturaEvent();
}

class GetDocumentosFacturaEvent extends FacturaEvent {
  final FacturaRequest request;
  const GetDocumentosFacturaEvent(this.request);
}

class ChangedFacturaEvent extends FacturaEvent {
  final List<Documento> documentos;
  const ChangedFacturaEvent(this.documentos);
}

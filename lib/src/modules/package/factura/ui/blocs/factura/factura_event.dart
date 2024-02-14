part of 'factura_bloc.dart';

sealed class FacturaEvent extends Equatable {
  const FacturaEvent();

  @override
  List<Object> get props => [];
}

class GetFacturaEvent extends FacturaEvent {
  const GetFacturaEvent();
}

class ChangedFacturaEvent extends FacturaEvent {
  final List<Documento> documentos;
  const ChangedFacturaEvent(this.documentos);
}

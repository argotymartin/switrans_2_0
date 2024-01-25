part of 'factura_bloc.dart';

sealed class FacturaEvent extends Equatable {
  const FacturaEvent();

  @override
  List<Object> get props => [];
}

class GetFacturaEvent extends FacturaEvent {
  const GetFacturaEvent();
}

class ActiveteFacturaEvent extends FacturaEvent {
  final String cliente;
  const ActiveteFacturaEvent(this.cliente);
}

class ActiveteClienteEvent extends FacturaEvent {
  final String cliente;
  const ActiveteClienteEvent(this.cliente);
}

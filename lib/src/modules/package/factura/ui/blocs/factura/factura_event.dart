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
  final FacturaRequest request;
  const ActiveteFacturaEvent(this.request);
}

part of 'tipo_impuesto_bloc.dart';

sealed class TipoImpuestoEvent extends Equatable {
  const TipoImpuestoEvent();

  @override
  List<Object> get props => [];
}

class SetImpuestoEvent extends TipoImpuestoEvent {
  final TipoImpuestoRequest request;
  const SetImpuestoEvent(this.request);
}

class GetImpuestoEvent extends TipoImpuestoEvent {
  final TipoImpuestoRequest request;
  const GetImpuestoEvent(this.request);
}

class ActiveteTipoImpuestoEvent extends TipoImpuestoEvent {
  const ActiveteTipoImpuestoEvent();
}

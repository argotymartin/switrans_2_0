part of 'tipo_impuesto_bloc.dart';

abstract class TipoImpuestoEvent extends Equatable {
  const TipoImpuestoEvent();
  @override
  List<Object> get props => <Object>[];
}

class InitialTipoImpuestoEvent extends TipoImpuestoEvent {
  const InitialTipoImpuestoEvent();
}

class GetTipoImpuestosEvent extends TipoImpuestoEvent {
  final TipoImpuestoRequest request;
  const GetTipoImpuestosEvent(this.request);
}

class SetTipoImpuestoEvent extends TipoImpuestoEvent {
  final TipoImpuestoRequest request;
  const SetTipoImpuestoEvent(this.request);
}

class UpdateTipoImpuestosEvent extends TipoImpuestoEvent {
  final List<EntityUpdate<TipoImpuestoRequest>> requestList;
  const UpdateTipoImpuestosEvent(this.requestList);
}

class ErrorFormTipoImpuestoEvent extends TipoImpuestoEvent {
  final String error;
  const ErrorFormTipoImpuestoEvent(this.error);
}

class CleanFormTipoImpuestoEvent extends TipoImpuestoEvent {
  const CleanFormTipoImpuestoEvent();
}

part of 'tipo_impuesto_bloc.dart';

sealed class TipoImpuestoEvent extends Equatable {
  const TipoImpuestoEvent();

  @override
  List<Object> get props => <Object>[];
}

class InitializationTipoImpuestoEvent extends TipoImpuestoEvent {
  const InitializationTipoImpuestoEvent();
}

class SetImpuestoEvent extends TipoImpuestoEvent {
  final TipoImpuestoRequest request;
  const SetImpuestoEvent(this.request);
}

class GetImpuestoEvent extends TipoImpuestoEvent {
  final TipoImpuestoRequest request;
  const GetImpuestoEvent(this.request);
}

class UpdateImpuestoEvent extends TipoImpuestoEvent {
  final List<EntityUpdate<TipoImpuestoRequest>> requestList;
  const UpdateImpuestoEvent(this.requestList);
}

class CleanFormTipoImpuestoEvent extends TipoImpuestoEvent {
  const CleanFormTipoImpuestoEvent();
}

class ActiveteTipoImpuestoEvent extends TipoImpuestoEvent {
  const ActiveteTipoImpuestoEvent();
}

class ErrorFormTipoImpuestoEvent extends TipoImpuestoEvent {
  final String error;
  const ErrorFormTipoImpuestoEvent(this.error);
}

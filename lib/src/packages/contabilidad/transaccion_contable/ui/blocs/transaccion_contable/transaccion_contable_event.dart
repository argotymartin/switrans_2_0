part of 'transaccion_contable_bloc.dart';

abstract class TransaccionContableEvent extends Equatable {
  const TransaccionContableEvent();
  @override
  List<Object> get props => <Object>[];
}

class SetTransaccionContableEvent extends TransaccionContableEvent {
  final TransaccionContableRequest request;
  const SetTransaccionContableEvent(this.request);
}

class InitialTransaccionContableEvent extends TransaccionContableEvent {
  const InitialTransaccionContableEvent();
}

class UpdateTransaccionContablesEvent extends TransaccionContableEvent {
  final List<EntityUpdate<TransaccionContableRequest>> requestList;
  const UpdateTransaccionContablesEvent(this.requestList);
}

class GetTransaccionContablesEvent extends TransaccionContableEvent {
  final TransaccionContableRequest request;
  const GetTransaccionContablesEvent(this.request);
}

class ErrorFormTransaccionContableEvent extends TransaccionContableEvent {
  final String error;
  const ErrorFormTransaccionContableEvent(this.error);
}

class CleanFormTransaccionContableEvent extends TransaccionContableEvent {
  const CleanFormTransaccionContableEvent();
}

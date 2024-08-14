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

class InitializationTransaccionContableEvent extends TransaccionContableEvent {
  const InitializationTransaccionContableEvent();
}

class UpdateTransaccionContableEvent extends TransaccionContableEvent {
  final List<TransaccionContableRequest> requestList;
  const UpdateTransaccionContableEvent(this.requestList);
}

class GetTransaccionContableEvent extends TransaccionContableEvent {
  const GetTransaccionContableEvent();
}

class ErrorFormTransaccionContableEvent extends TransaccionContableEvent {
  final String error;
  const ErrorFormTransaccionContableEvent(this.error);
}

class CleanFormTransaccionContableEvent extends TransaccionContableEvent {
  const CleanFormTransaccionContableEvent();
}

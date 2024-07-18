part of 'transaccion_contable_bloc.dart';

abstract class TransaccionContableEvent extends Equatable {
  const TransaccionContableEvent();

  @override
  List<Object> get props => <Object>[];
}

class GetTransaccionContableEvent extends TransaccionContableEvent {
  final TransaccionContableRequest request;
  const GetTransaccionContableEvent(this.request);
}
class SetTransaccionContableEvent extends TransaccionContableEvent {
  final TransaccionContableRequest request;
  const SetTransaccionContableEvent(this.request);
}

class UpdateTransaccionContableEvent extends TransaccionContableEvent {
  final TransaccionContableRequest request;
  const UpdateTransaccionContableEvent(this.request);
}

class ErrorFormTransaccionContableEvent extends TransaccionContableEvent {
  final String error;
  const ErrorFormTransaccionContableEvent(this.error);
}

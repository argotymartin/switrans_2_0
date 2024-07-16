part of 'transaccion_contable_bloc.dart';

abstract class TransaccionContableState extends Equatable {
  final TransaccionContable? transaccionContable;
  final List<TransaccionContable> transaccionesContables;
  final String? errorForm;
  final DioException? exception;

  const TransaccionContableState({this.transaccionContable, this.transaccionesContables = const <TransaccionContable>[], this.errorForm, this.exception});

  @override
  List<Object?> get props => <Object?>[];
}

class TransaccionContableInitialState extends TransaccionContableState {
  const TransaccionContableInitialState();

  @override
  List<Object> get props => <Object>[];
}

class TransaccionContableLoadingState extends TransaccionContableState {
  const TransaccionContableLoadingState();

  @override
  List<Object?> get props => <Object?>[];
}

class TransaccionContableSuccessState extends TransaccionContableState {
  const TransaccionContableSuccessState({super.transaccionContable});

  @override
  List<Object?> get props => <Object?>[transaccionContable!];
}

class TransaccionContableConsultedState extends TransaccionContableState {
  const TransaccionContableConsultedState({super.transaccionesContables});

  @override
  List<Object?> get props => <Object?>[transaccionesContables];
}

class TransaccionContableFailedState extends TransaccionContableState {
  const TransaccionContableFailedState({super.exception});

  @override
  List<Object?> get props => <Object?>[exception!];
}

class TransaccionContableErrorFormState extends TransaccionContableState {
  const TransaccionContableErrorFormState({super.errorForm});

  @override
  List<Object?> get props => <Object?>[errorForm!];
}

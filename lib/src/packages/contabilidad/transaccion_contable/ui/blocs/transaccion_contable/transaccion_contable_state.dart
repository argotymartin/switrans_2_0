part of 'transaccion_contable_bloc.dart';

enum TransaccionContableStatus { initial, loading, succes, error, consulted, exception }

class TransaccionContableState extends Equatable {
  final TransaccionContableStatus? status;
  final TransaccionContable? transaccionContable;
  final List<TransaccionContable> transaccionContables;
  final List<EntryAutocomplete> entriesTipoImpuestos;
  final DioException? exception;
  final String? error;

  const TransaccionContableState({
    this.status,
    this.transaccionContable,
    this.transaccionContables = const <TransaccionContable>[],
    this.entriesTipoImpuestos = const <EntryAutocomplete>[],
    this.exception,
    this.error,
  });

  TransaccionContableState initial() => const TransaccionContableState(status: TransaccionContableStatus.initial);

  TransaccionContableState copyWith({
    TransaccionContableStatus? status,
    TransaccionContable? transaccionContable,
    List<TransaccionContable>? transaccionContables,
    List<EntryAutocomplete>? entriesTipoImpuestos,
    DioException? exception,
    String? error,
  }) =>
      TransaccionContableState(
        status: status ?? this.status,
        transaccionContable: transaccionContable ?? this.transaccionContable,
        exception: exception ?? this.exception,
        transaccionContables: transaccionContables ?? this.transaccionContables,
        entriesTipoImpuestos: entriesTipoImpuestos ?? this.entriesTipoImpuestos,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => <Object?>[status, transaccionContable, transaccionContables, entriesTipoImpuestos, exception, error];
}

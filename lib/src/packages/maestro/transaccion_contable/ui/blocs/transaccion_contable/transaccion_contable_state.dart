part of 'transaccion_contable_bloc.dart';

enum TransaccionContableStatus { initial, loading, succes, error, consulted, exception }

class TransaccionContableState extends Equatable {
  final TransaccionContableStatus? status;
  final TransaccionContable? transaccionContable;
  final List<TransaccionContable> transaccionContables;
  final List<EntryAutocomplete> entriesTipoImpuesto;
  final DioException? exception;
  final String? error;

  const TransaccionContableState({
    this.status,
    this.transaccionContable,
    this.exception,
    this.transaccionContables = const <TransaccionContable>[],
    this.entriesTipoImpuesto = const <EntryAutocomplete>[],
    this.error,
  });

  TransaccionContableState initial() => const TransaccionContableState(status: TransaccionContableStatus.initial);

  TransaccionContableState copyWith({
    TransaccionContableStatus? status,
    TransaccionContable? transaccionContable,
    List<TransaccionContable>? transaccionContables,
    List<EntryAutocomplete>? entriesTipoImpuesto,
    DioException? exception,
    String? error,
  }) =>
      TransaccionContableState(
        status: status ?? this.status,
        transaccionContable: transaccionContable ?? this.transaccionContable,
        exception: exception ?? this.exception,
        transaccionContables: transaccionContables ?? this.transaccionContables,
        entriesTipoImpuesto: entriesTipoImpuesto ?? this.entriesTipoImpuesto,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => <Object?>[transaccionContable, transaccionContables, entriesTipoImpuesto, exception, error, status];
}

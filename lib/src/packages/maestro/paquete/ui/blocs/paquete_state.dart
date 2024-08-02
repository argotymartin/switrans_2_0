part of 'paquete_bloc.dart';

enum PaqueteStatus { initial, loading, succes, error, consulted, exception }

class PaqueteState extends Equatable {
  final PaqueteStatus? status;
  final Paquete? paquete;
  final List<Paquete> paquetes;
  final DioException? exception;
  final String? error;
  const PaqueteState({
    this.status,
    this.paquete,
    this.exception,
    this.paquetes = const <Paquete>[],
    this.error,
  });

  PaqueteState initial() => const PaqueteState(status: PaqueteStatus.initial);

  PaqueteState copyWith({
    PaqueteStatus? status,
    Paquete? paquete,
    List<Paquete>? paquetes,
    DioException? exception,
    String? error,
  }) =>
      PaqueteState(
        status: status ?? this.status,
        paquete: paquete ?? this.paquete,
        exception: exception ?? this.exception,
        paquetes: paquetes ?? this.paquetes,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => <Object?>[status, paquete, exception, paquetes, error];
}

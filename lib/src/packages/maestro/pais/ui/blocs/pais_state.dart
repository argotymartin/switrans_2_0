part of 'pais_bloc.dart';

enum PaisStatus { initial, loading, succes, error, consulted, exception }

class PaisState extends Equatable {
  final PaisStatus? status;
  final Pais? pais;
  final List<Pais> paises;
  final DioException? exception;
  final String? error;
  const PaisState({
    this.status,
    this.pais,
    this.exception,
    this.paises = const <Pais>[],
    this.error,
  });

  PaisState initial() => const PaisState(status: PaisStatus.initial);

  PaisState copyWith({
    PaisStatus? status,
    Pais? pais,
    List<Pais>? paises,
    DioException? exception,
    String? error,
  }) =>
      PaisState(
        status: status ?? this.status,
        pais: pais ?? this.pais,
        exception: exception ?? this.exception,
        paises: paises ?? this.paises,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => <Object?>[status, pais, exception, paises, error];
}

part of 'tipo_impuesto_bloc.dart';

enum TipoImpuestoStatus { initial, loading, succes, error, consulted, exception }

class TipoImpuestoState extends Equatable {
  final TipoImpuestoStatus? status;
  final TipoImpuesto? tipoImpuesto;
  final List<TipoImpuesto> tipoImpuestos;
  final DioException? exception;
  final String error;
  const TipoImpuestoState({
    this.status,
    this.tipoImpuesto,
    this.tipoImpuestos = const <TipoImpuesto>[],
    this.exception,
    this.error = "",
  });
  TipoImpuestoState initial() => const TipoImpuestoState(status: TipoImpuestoStatus.initial);

  TipoImpuestoState copyWith({
    TipoImpuestoStatus? status,
    TipoImpuesto? tipoImpuesto,
    List<TipoImpuesto>? tipoImpuestos,
    DioException? exception,
    String? error,
  }) =>
      TipoImpuestoState(
        status: status ?? this.status,
        tipoImpuesto: tipoImpuesto ?? this.tipoImpuesto,
        tipoImpuestos: tipoImpuestos ?? this.tipoImpuestos,
        exception: exception ?? this.exception,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => <Object?>[status, tipoImpuesto, tipoImpuestos, exception, error];
}

part of 'tipo_impuesto_bloc.dart';

enum TipoImpuestoStatus { initial, loading, succes, consulted, error, exception }

class TipoImpuestoState extends Equatable {
  final TipoImpuestoStatus? status;
  final TipoImpuesto? tipoImpuesto;
  final List<TipoImpuesto> tipoImpuestos;
  final DioException? exception;
  final String? error;
  const TipoImpuestoState({this.status, this.tipoImpuesto, this.exception, this.tipoImpuestos = const <TipoImpuesto>[], this.error});

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
        exception: exception ?? this.exception,
        tipoImpuestos: tipoImpuestos ?? this.tipoImpuestos,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => <Object?>[ status, tipoImpuesto, exception, tipoImpuestos, error];
}

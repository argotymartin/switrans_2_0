part of 'servicio_empresarial_bloc.dart';

enum ServicioEmpresarialStatus {
  initial,
  loading,
  succes,
  consulted,
  error,
  exception,
}

class ServicioEmpresarialState extends Equatable {
  final ServicioEmpresarialStatus? status;
  final List<ServicioEmpresarial> serviciosEmpresariales;
  final ServicioEmpresarial? servicioEmpresarial;
  final DioException? exception;
  final String? error;

  const ServicioEmpresarialState({
    this.status,
    this.serviciosEmpresariales = const <ServicioEmpresarial>[],
    this.exception,
    this.error = '',
    this.servicioEmpresarial,
  });

  ServicioEmpresarialState initial() => const ServicioEmpresarialState(status: ServicioEmpresarialStatus.initial);

  ServicioEmpresarialState copyWith({
    ServicioEmpresarialStatus? status,
    List<ServicioEmpresarial>? serviciosEmpresariales,
    String? error,
    DioException? exception,
    ServicioEmpresarial? servicioEmpresarial,
  }) =>
      ServicioEmpresarialState(
        status: status ?? this.status,
        error: error ?? this.error,
        exception: exception ?? this.exception,
        serviciosEmpresariales: serviciosEmpresariales ?? this.serviciosEmpresariales,
        servicioEmpresarial: servicioEmpresarial ?? this.servicioEmpresarial,
      );

  @override
  List<Object?> get props => <Object?>[serviciosEmpresariales, status, error, servicioEmpresarial];
}

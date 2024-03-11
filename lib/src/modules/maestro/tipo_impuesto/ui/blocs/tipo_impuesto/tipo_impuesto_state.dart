part of 'tipo_impuesto_bloc.dart';

sealed class TipoImpuestoState extends Equatable {
  final TipoImpuesto? tipoImpuesto;
  final List<TipoImpuesto> tipoImpuestos;
  final DioException? exception;
  final String? error;
  const TipoImpuestoState({this.tipoImpuesto, this.exception, this.tipoImpuestos = const [], this.error});
}

class TipoImpuestoInitialState extends TipoImpuestoState {
  const TipoImpuestoInitialState();

  @override
  List<Object> get props => [];
}

class TipoImpuestoLoadingState extends TipoImpuestoState {
  const TipoImpuestoLoadingState();

  @override
  List<Object> get props => [];
}

class TipoImpuestoSuccesState extends TipoImpuestoState {
  const TipoImpuestoSuccesState({super.tipoImpuesto});

  @override
  List<Object> get props => [tipoImpuesto!];
}

class TipoImpuestoConsultedState extends TipoImpuestoState {
  const TipoImpuestoConsultedState({super.tipoImpuestos});

  @override
  List<Object> get props => [tipoImpuestos];
}

class TipoImpuestoExceptionState extends TipoImpuestoState {
  const TipoImpuestoExceptionState({super.exception});
  @override
  List<Object> get props => [exception!];
}

class TipoImpuestoErrorFormState extends TipoImpuestoState {
  const TipoImpuestoErrorFormState({super.error});
  @override
  List<Object> get props => [error!];
}

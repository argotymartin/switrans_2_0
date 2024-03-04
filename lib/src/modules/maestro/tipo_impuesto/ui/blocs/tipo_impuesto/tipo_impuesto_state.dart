part of 'tipo_impuesto_bloc.dart';

sealed class TipoImpuestoState extends Equatable {
  final TipoImpuesto? tipoImpuesto;
  final DioException? exception;
  const TipoImpuestoState({this.tipoImpuesto, this.exception});

  @override
  List<Object> get props => [];
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
  List<Object> get props => [];
}

class TipoImpuestoErrorState extends TipoImpuestoState {
  const TipoImpuestoErrorState({super.exception});
  @override
  List<Object> get props => [exception!];
}

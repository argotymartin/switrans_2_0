part of 'unidad_negocio_bloc.dart';

abstract class UnidadNegocioState extends Equatable {
  final UnidadNegocio? unidadNegocio;
  final List<UnidadNegocio> unidadNegocioList;
  final String? errorForm;
  final DioException? exception;

  const UnidadNegocioState({this.unidadNegocio, this.unidadNegocioList = const <UnidadNegocio>[], this.errorForm, this.exception});

  @override
  List<Object?> get props => <Object?>[];
}

class UnidadNegocioInitialState extends UnidadNegocioState {
  const UnidadNegocioInitialState();

  @override
  List<Object?> get props => <Object?>[];
}

class UnidadNegocioLoadingState extends UnidadNegocioState {
  const UnidadNegocioLoadingState();

  @override
  List<Object?> get props => <Object?>[];
}

class UnidadNegocioSuccessState extends UnidadNegocioState {
  const UnidadNegocioSuccessState({super.unidadNegocio});

  @override
  List<Object?> get props => <Object?>[unidadNegocio!];
}

class UnidadNegocioConsultedState extends UnidadNegocioState {
  const UnidadNegocioConsultedState({super.unidadNegocioList});

  @override
  List<Object?> get props => <Object?>[unidadNegocioList];
}

class UnidadNegocioFailedState extends UnidadNegocioState {
  const UnidadNegocioFailedState({super.exception});

  @override
  List<Object?> get props => <Object?>[exception!];
}

class UnidadNegocioErrorFormState extends UnidadNegocioState {
  const UnidadNegocioErrorFormState({super.errorForm});

  @override
  List<Object?> get props => <Object?>[errorForm!];
}

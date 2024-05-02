part of 'modulo_bloc.dart';

sealed class ModuloState extends Equatable {
  final Modulo? modulo;
  final List<Modulo> modulos;
  final List<ModuloPaquete> paquetes;
  final DioException? exception;
  final String error;
  const ModuloState({
    this.modulo,
    this.exception,
    this.modulos = const [],
    this.paquetes = const [],
    this.error = "",
  });
}

class ModuloInitialState extends ModuloState {
  const ModuloInitialState();
  @override
  List<Object?> get props => [];
}

class FormModuloDataState extends ModuloState {
  const FormModuloDataState({super.modulos, super.paquetes, super.error});
  @override
  List<Object?> get props => [modulos, paquetes];
}

class ModuloLoadingState extends ModuloState {
  const ModuloLoadingState();
  @override
  List<Object?> get props => [];
}

class FormModuloRequestState extends ModuloState {
  const FormModuloRequestState({super.modulo, super.paquetes, super.error});

  @override
  List<Object?> get props => [modulo, paquetes, error];
}

class ModuloSuccessState extends ModuloState {
  const ModuloSuccessState({super.modulo, super.paquetes, super.error});
  @override
  List<Object?> get props => [modulo, paquetes, error];
}

class ModuloConsultedState extends ModuloState {
  const ModuloConsultedState({super.modulos});
  @override
  List<Object?> get props => [modulos];
}

class ModuloExceptionState extends ModuloState {
  const ModuloExceptionState({super.exception});
  @override
  List<DioException?> get props => [exception];
}

class ModuloErrorFormState extends ModuloState {
  const ModuloErrorFormState({super.error});
  @override
  List<Object?> get props => [error];
}
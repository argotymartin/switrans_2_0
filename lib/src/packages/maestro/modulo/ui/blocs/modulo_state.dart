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
    this.modulos = const <Modulo>[],
    this.paquetes = const <ModuloPaquete>[],
    this.error = "",
  });
}

class ModuloInitialState extends ModuloState {
  const ModuloInitialState();
  @override
  List<Object?> get props => <Object?>[];
}

class FormModuloDataState extends ModuloState {
  const FormModuloDataState({super.modulos, super.paquetes, super.error});
  @override
  List<Object?> get props => <Object?>[modulos, paquetes];
}

class ModuloLoadingState extends ModuloState {
  const ModuloLoadingState();
  @override
  List<Object?> get props => <Object?>[];
}

class FormModuloRequestState extends ModuloState {
  const FormModuloRequestState({super.modulo, super.paquetes, super.error});

  @override
  List<Object?> get props => <Object?>[modulo, paquetes, error];
}

class ModuloSuccessState extends ModuloState {
  const ModuloSuccessState({super.modulo, super.paquetes, super.error});
  @override
  List<Object?> get props => <Object?>[modulo, paquetes, error];
}

class ModuloConsultedState extends ModuloState {
  const ModuloConsultedState({super.modulos});
  @override
  List<Object?> get props => <Object?>[modulos];
}

class ModuloExceptionState extends ModuloState {
  const ModuloExceptionState({super.exception});
  @override
  List<DioException?> get props => <DioException?>[exception];
}

class ModuloErrorFormState extends ModuloState {
  const ModuloErrorFormState({super.error});
  @override
  List<Object?> get props => <Object?>[error];
}

part of 'paquete_bloc.dart';

sealed class PaqueteState extends Equatable {
  final Paquete? paquete;
  final List<Paquete> paquetes;
  final DioException? exception;
  final String error;
  const PaqueteState({
    this.paquete,
    this.exception,
    this.paquetes = const <Paquete>[],
    this.error = "",
  });
}

class PaqueteInitialState extends PaqueteState {
  const PaqueteInitialState();
  @override
  List<Object?> get props => <Object?>[];
}

class FormPaqueteDataState extends PaqueteState {
  const FormPaqueteDataState({super.paquetes, super.error});
  @override
  List<Object?> get props => <Object?>[paquetes];
}

class PaqueteLoadingState extends PaqueteState {
  const PaqueteLoadingState();
  @override
  List<Object?> get props => <Object?>[];
}

class FormPaqueteRequestState extends PaqueteState {
  const FormPaqueteRequestState({super.paquete, super.error});
  @override
  List<Object?> get props => <Object?>[paquete, error];
}

class PaqueteSuccessState extends PaqueteState {
  const PaqueteSuccessState({super.paquete, super.error});
  @override
  List<Object?> get props => <Object?>[paquete, error];
}

class PaqueteConsultedState extends PaqueteState {
  const PaqueteConsultedState({super.paquetes});
  @override
  List<Object?> get props => <Object?>[paquetes];
}

class PaqueteExceptionState extends PaqueteState {
  const PaqueteExceptionState({super.exception});
  @override
  List<DioException?> get props => <DioException?>[exception];
}

class PaqueteErrorFormState extends PaqueteState {
  const PaqueteErrorFormState({super.error});
  @override
  List<Object?> get props => <Object?>[error];
}

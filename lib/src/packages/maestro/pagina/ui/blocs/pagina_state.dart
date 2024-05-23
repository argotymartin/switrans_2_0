part of 'pagina_bloc.dart';

sealed class PaginaState extends Equatable {
  final Pagina? pagina;
  final List<Pagina> paginas;
  final DioException? exception;
  final String error;
  const PaginaState({
    this.pagina,
    this.exception,
    this.paginas = const <Pagina>[],
    this.error = "",
  });
}

class PaginaInitialState extends PaginaState {
  const PaginaInitialState();
  @override
  List<Object?> get props => <Object?>[];
}

class FormPaginaDataState extends PaginaState {
  const FormPaginaDataState({super.paginas, super.error});
  @override
  List<Object?> get props => <Object?>[paginas];
}

class PaginaLoadingState extends PaginaState {
  const PaginaLoadingState();
  @override
  List<Object?> get props => <Object?>[];
}

class FormPaginaRequestState extends PaginaState {
  const FormPaginaRequestState({super.pagina, super.error});
  @override
  List<Object?> get props => <Object?>[pagina, error];
}

class PaginaSuccessState extends PaginaState {
  const PaginaSuccessState({super.pagina, super.error});
  @override
  List<Object?> get props => <Object?>[pagina, error];
}

class PaginaConsultedState extends PaginaState {
  const PaginaConsultedState({super.paginas});
  @override
  List<Object?> get props => <Object?>[paginas];
}

class PaginaExceptionState extends PaginaState {
  const PaginaExceptionState({super.exception});
  @override
  List<DioException?> get props => <DioException?>[exception];
}

class PaginaErrorFormState extends PaginaState {
  const PaginaErrorFormState({super.error});
  @override
  List<Object?> get props => <Object?>[error];
}

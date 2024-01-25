part of 'modulo_bloc.dart';

sealed class ModuloState extends Equatable {
  final List<Modulo> modulos;
  const ModuloState({this.modulos = const []});

  @override
  List<Object> get props => [];
}

final class ModuloInitial extends ModuloState {}

class ModuloInitialState extends ModuloState {
  const ModuloInitialState();

  @override
  List<Object> get props => [];
}

class ModuloLoadingState extends ModuloState {
  const ModuloLoadingState();

  @override
  List<Object> get props => [];
}

class ModuloSuccesState extends ModuloState {
  const ModuloSuccesState({super.modulos});

  @override
  List<Object> get props => [];
}

class ModuloErrorState extends ModuloState {
  final DioException error;

  const ModuloErrorState({required this.error});
  @override
  List<Object> get props => [error];
}

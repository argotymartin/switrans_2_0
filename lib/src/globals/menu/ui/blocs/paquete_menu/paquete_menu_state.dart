part of 'paquete_menu_bloc.dart';

sealed class PaqueteMenuState extends Equatable {
  final List<PaqueteMenu> paquetes;
  const PaqueteMenuState({this.paquetes = const []});

  @override
  List<Object> get props => [];
}

final class PaqueteMenuInitial extends PaqueteMenuState {}

class PaqueteMenuInitialState extends PaqueteMenuState {
  const PaqueteMenuInitialState();

  @override
  List<Object> get props => [];
}

class PaqueteMenuLoadingState extends PaqueteMenuState {
  const PaqueteMenuLoadingState();

  @override
  List<Object> get props => [];
}

class PaqueteMenuSuccesState extends PaqueteMenuState {
  const PaqueteMenuSuccesState({super.paquetes});

  @override
  List<Object> get props => [];
}

class PaqueteMenuErrorState extends PaqueteMenuState {
  final DioException error;

  const PaqueteMenuErrorState({required this.error});
  @override
  List<Object> get props => [error];
}

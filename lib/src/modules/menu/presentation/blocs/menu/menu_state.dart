part of 'menu_bloc.dart';

sealed class MenuState extends Equatable {
  const MenuState();

  @override
  List<Object> get props => [];
}

final class MenuInitial extends MenuState {}

class MenuInitialState extends MenuState {
  const MenuInitialState();

  @override
  List<Object> get props => [];
}

class MenuLoadingState extends MenuState {
  const MenuLoadingState();

  @override
  List<Object> get props => [];
}

class MenuSuccesState extends MenuState {
  const MenuSuccesState();

  @override
  List<Object> get props => [];
}

class MenuErrorState extends MenuState {
  final DioException error;

  const MenuErrorState({required this.error});
  @override
  List<Object> get props => [error];
}

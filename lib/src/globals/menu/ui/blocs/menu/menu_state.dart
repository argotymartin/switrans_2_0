part of 'menu_bloc.dart';

sealed class MenuState extends Equatable {
  final bool isOpenMenu;
  final bool isMinimize;
  final bool isBlocked;
  const MenuState({this.isOpenMenu = true, this.isMinimize = false, this.isBlocked = false});

  @override
  List<Object> get props => [];
}

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
  const MenuSuccesState({super.isOpenMenu, super.isMinimize, super.isBlocked});

  @override
  List<Object> get props => [isOpenMenu, isMinimize, isBlocked];
}

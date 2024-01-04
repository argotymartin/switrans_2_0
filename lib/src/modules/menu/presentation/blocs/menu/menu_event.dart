part of 'menu_bloc.dart';

sealed class MenuEvent extends Equatable {
  const MenuEvent();

  @override
  List<Object> get props => [];
}

class GetMenuEvent extends MenuEvent {
  const GetMenuEvent();
}

class ActiveteMenuEvent extends MenuEvent {
  const ActiveteMenuEvent();
}

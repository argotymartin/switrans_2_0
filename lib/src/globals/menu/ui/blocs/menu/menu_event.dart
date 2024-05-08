part of 'menu_bloc.dart';

sealed class MenuEvent extends Equatable {
  const MenuEvent();

  @override
  List<Object> get props => <Object>[];
}

class BlockedMenuEvent extends MenuEvent {
  const BlockedMenuEvent();
}

class ExpandedMenuEvent extends MenuEvent {
  const ExpandedMenuEvent();
}

class MinimizedMenuEvent extends MenuEvent {
  const MinimizedMenuEvent();
}

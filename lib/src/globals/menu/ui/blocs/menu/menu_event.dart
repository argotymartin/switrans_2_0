part of 'menu_bloc.dart';

sealed class MenuEvent extends Equatable {
  const MenuEvent();

  @override
  List<Object> get props => <Object>[];
}

class BlockedMenuEvent extends MenuEvent {
  final bool isBlocked;
  const BlockedMenuEvent(this.isBlocked);
}

class ExpandedMenuEvent extends MenuEvent {
  final bool isExpanded;
  const ExpandedMenuEvent(this.isExpanded);
}

class MinimizedMenuEvent extends MenuEvent {
  final bool isMinimized;
  const MinimizedMenuEvent(this.isMinimized);
}

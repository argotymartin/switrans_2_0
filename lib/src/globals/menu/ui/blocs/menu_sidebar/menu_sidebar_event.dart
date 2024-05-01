part of 'menu_sidebar_bloc.dart';

sealed class MenuSidebarEvent extends Equatable {
  const MenuSidebarEvent();

  @override
  List<Object> get props => [];
}

class GetMenuSidebarEvent extends MenuSidebarEvent {
  const GetMenuSidebarEvent();
}

class ActiveteMenuSidebarEvent extends MenuSidebarEvent {
  const ActiveteMenuSidebarEvent();
}

class SelectedMenuSidebarEvent extends MenuSidebarEvent {
  final List<PaqueteMenu> paquetes;
  const SelectedMenuSidebarEvent(this.paquetes);
}

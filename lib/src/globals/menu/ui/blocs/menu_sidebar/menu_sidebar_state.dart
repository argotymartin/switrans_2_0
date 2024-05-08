part of 'menu_sidebar_bloc.dart';

sealed class MenuSidebarState extends Equatable {
  final List<PaqueteMenu> paquetes;
  const MenuSidebarState({this.paquetes = const <PaqueteMenu>[]});

  @override
  List<Object> get props => <Object>[];
}

final class MenuSidebarInitial extends MenuSidebarState {}

class MenuSidebarInitialState extends MenuSidebarState {
  const MenuSidebarInitialState();

  @override
  List<Object> get props => <Object>[];
}

class MenuSidebarLoadingState extends MenuSidebarState {
  const MenuSidebarLoadingState();

  @override
  List<Object> get props => <Object>[];
}

class MenuSidebarSuccesState extends MenuSidebarState {
  const MenuSidebarSuccesState({super.paquetes});

  @override
  List<Object> get props => <Object>[];
}

class MenuSidebarErrorState extends MenuSidebarState {
  final DioException error;

  const MenuSidebarErrorState({required this.error});
  @override
  List<Object> get props => <Object>[error];
}

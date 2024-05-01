part of 'menu_sidebar_bloc.dart';

sealed class MenuSidebarState extends Equatable {
  final List<PaqueteMenu> paquetes;
  const MenuSidebarState({this.paquetes = const []});

  @override
  List<Object> get props => [];
}

final class MenuSidebarInitial extends MenuSidebarState {}

class MenuSidebarInitialState extends MenuSidebarState {
  const MenuSidebarInitialState();

  @override
  List<Object> get props => [];
}

class MenuSidebarLoadingState extends MenuSidebarState {
  const MenuSidebarLoadingState();

  @override
  List<Object> get props => [];
}

class MenuSidebarSuccesState extends MenuSidebarState {
  const MenuSidebarSuccesState({super.paquetes});

  @override
  List<Object> get props => [];
}

class MenuSidebarErrorState extends MenuSidebarState {
  final DioException error;

  const MenuSidebarErrorState({required this.error});
  @override
  List<Object> get props => [error];
}

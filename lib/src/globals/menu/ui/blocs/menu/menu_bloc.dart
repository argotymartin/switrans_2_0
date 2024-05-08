import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(const MenuInitialState()) {
    on<BlockedMenuEvent>((BlockedMenuEvent event, Emitter<MenuState> emit) {
      final bool isBlocked = !state.isBlocked;
      final bool isOpenMenu = state.isOpenMenu;
      final bool isMinimize = state.isMinimize;
      emit(const MenuLoadingState());
      emit(MenuSuccesState(isOpenMenu: isOpenMenu, isMinimize: isMinimize, isBlocked: isBlocked));
    });

    on<ExpandedMenuEvent>((ExpandedMenuEvent event, Emitter<MenuState> emit) {
      final bool isOpenMenu = !state.isOpenMenu;
      final bool isBlocked = state.isBlocked;
      final bool isMinimize = state.isMinimize;
      emit(const MenuLoadingState());
      emit(MenuSuccesState(isOpenMenu: isOpenMenu, isMinimize: isMinimize, isBlocked: isBlocked));
    });

    on<MinimizedMenuEvent>((MinimizedMenuEvent event, Emitter<MenuState> emit) {
      final bool isMinimize = !state.isMinimize;
      final bool isBlocked = state.isBlocked;
      final bool isOpenMenu = state.isOpenMenu;
      emit(const MenuLoadingState());
      emit(MenuSuccesState(isOpenMenu: isOpenMenu, isMinimize: isMinimize, isBlocked: isBlocked));
    });
  }
}

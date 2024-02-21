import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(const MenuInitialState()) {
    on<BlockedMenuEvent>((event, emit) {
      final isBlocked = !state.isBlocked;
      final isOpenMenu = state.isOpenMenu;
      final isMinimize = state.isMinimize;
      emit(const MenuLoadingState());
      emit(MenuSuccesState(isOpenMenu: isOpenMenu, isMinimize: isMinimize, isBlocked: isBlocked));
    });

    on<ExpandedMenuEvent>((event, emit) {
      final isOpenMenu = !state.isOpenMenu;
      final isBlocked = state.isBlocked;
      final isMinimize = state.isMinimize;
      emit(const MenuLoadingState());
      emit(MenuSuccesState(isOpenMenu: isOpenMenu, isMinimize: isMinimize, isBlocked: isBlocked));
    });

    on<MinimizedMenuEvent>((event, emit) {
      final isMinimize = !state.isMinimize;
      final isBlocked = state.isBlocked;
      final isOpenMenu = state.isOpenMenu;
      emit(const MenuLoadingState());
      emit(MenuSuccesState(isOpenMenu: isOpenMenu, isMinimize: isMinimize, isBlocked: isBlocked));
    });
  }
}

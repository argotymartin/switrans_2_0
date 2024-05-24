import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(const MenuInitialState()) {
    on<BlockedMenuEvent>((BlockedMenuEvent event, Emitter<MenuState> emit) {
      emit(const MenuLoadingState());
      emit(MenuSuccesState(isOpenMenu: false, isBlocked: event.isBlocked));
    });

    on<ExpandedMenuEvent>((ExpandedMenuEvent event, Emitter<MenuState> emit) {
      emit(const MenuLoadingState());
      emit(MenuSuccesState(isOpenMenu: event.isExpanded));
    });

    on<MinimizedMenuEvent>((MinimizedMenuEvent event, Emitter<MenuState> emit) {
      emit(const MenuLoadingState());
      emit(MenuSuccesState(isOpenMenu: false, isMinimize: event.isMinimized));
    });
  }
}

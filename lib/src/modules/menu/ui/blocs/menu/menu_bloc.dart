import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(MenuInitial()) {
    on<MenuEvent>((event, emit) {});
    on<ActiveteMenuEvent>((event, emit) {
      emit(const MenuLoadingState());
      emit(MenuSuccesState(isOpenMenu: event.isOpenMenu, isMinimize: event.isMinimize));
    });
  }
}

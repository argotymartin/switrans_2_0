import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());

  void toggleMode() {
    emit(ThemeDark(isDarkmode: state.isDarkmode));
  }

  void onChangeColorTheme(Color color) {
    emit(ThemeDark(isDarkmode: state.isDarkmode, color: color));
  }
}

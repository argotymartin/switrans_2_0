import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/config/share_preferences/preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final Color color;
  final bool isDarkMode;
  ThemeCubit({required this.color, required this.isDarkMode}) : super(ThemeInitial(color: color, isDarkmode: isDarkMode));

  void toggleMode() {
    emit(ThemeDark(isDarkmode: state.isDarkmode));
  }

  void onChangeColorTheme(Color color) {
    Preferences.color = color.value;
    emit(ThemeDark(isDarkmode: state.isDarkmode, color: color));
  }
}

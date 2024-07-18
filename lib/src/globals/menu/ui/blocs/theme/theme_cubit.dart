import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/config/share_preferences/preferences.dart';

part 'theme_state.dart';

enum ThemeMode { dark, ligth, color }

class ThemeCubit extends Cubit<ThemeState> {
  final Color color;
  final int themeMode;
  ThemeCubit({required this.color, required this.themeMode}) : super(ThemeInitial(color: color, themeMode: 1));

  void onChangeColorTheme(Color color) {
    Preferences.color = color.value;
    emit(ThemeChangedState(themeMode: state.themeMode, color: color));
  }

  void onChangeThemeMode(int theme) {
    Preferences.themeMode = theme;
    emit(ThemeChangedState(themeMode: theme, color: state.color));
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:switrans_2_0/src/config/share_preferences/preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  Color? themePrimarycolor;
  Color? themeSecundarycolor;
  ThemeCubit() : super(ThemeInitial(color: Color(Preferences.color), themeMode: Preferences.themeMode));

  void onChangeColorTheme(Color color) {
    Preferences.color = color.value;
    emit(ThemeChangedState(themeMode: state.themeMode, color: color));
  }

  void onChangeThemeMode(int theme) {
    Preferences.themeMode = theme;
    emit(ThemeChangedState(themeMode: theme, color: state.color));
  }
}

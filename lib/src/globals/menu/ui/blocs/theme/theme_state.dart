part of 'theme_cubit.dart';

sealed class ThemeState extends Equatable {
  final bool isDarkmode;
  final Color color;
  const ThemeState({this.isDarkmode = false, this.color = Colors.indigo});
}

final class ThemeInitial extends ThemeState {
  @override
  List<Object> get props => [];
}

final class ThemeDark extends ThemeState {
  const ThemeDark({super.isDarkmode, super.color});

  @override
  List<Object> get props => [isDarkmode, color];
}

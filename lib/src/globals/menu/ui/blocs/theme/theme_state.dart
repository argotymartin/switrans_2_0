part of 'theme_cubit.dart';

sealed class ThemeState extends Equatable {
  final bool isDarkmode;
  const ThemeState({this.isDarkmode = false});

  @override
  List<Object> get props => [isDarkmode];
}

final class ThemeInitial extends ThemeState {}

final class ThemeDark extends ThemeState {
  const ThemeDark({super.isDarkmode});
}

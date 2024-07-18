part of 'theme_cubit.dart';

sealed class ThemeState extends Equatable {
  final bool? isDarkmode;
  final Color? color;
  const ThemeState({this.isDarkmode, this.color});
}

final class ThemeInitial extends ThemeState {
  const ThemeInitial({super.isDarkmode, super.color});

  @override
  List<Object> get props => <Object>[isDarkmode!, color!];
}

final class ThemeDark extends ThemeState {
  const ThemeDark({super.isDarkmode, super.color});

  @override
  List<Object> get props => <Object>[isDarkmode!, color!];
}

part of 'theme_cubit.dart';

sealed class ThemeState extends Equatable {
  final int? themeMode;
  final Color? color;
  const ThemeState({this.themeMode, this.color});
}

final class ThemeInitial extends ThemeState {
  const ThemeInitial({super.themeMode, super.color});

  @override
  List<Object> get props => <Object>[themeMode!, color!];
}

final class ThemeChangedState extends ThemeState {
  const ThemeChangedState({super.themeMode, super.color});

  @override
  List<Object> get props => <Object>[themeMode!, color!];
}

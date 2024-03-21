part of 'theme_bloc.dart';

@immutable
sealed class ThemeEvent {}

class ChangeTheme extends ThemeEvent {
  final bool isDark;

  ChangeTheme({required this.isDark});
}

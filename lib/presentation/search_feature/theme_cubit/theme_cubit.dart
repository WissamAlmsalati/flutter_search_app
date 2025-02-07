import 'package:bloc/bloc.dart';

class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(false); // Initially light mode

  void toggleTheme(bool isDark) => emit(isDark);

  void toggle() => emit(!state);
}


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/config/theme/app_theme.dart';

// Provider => Listado de colores inmutable
final colorListProvider = Provider((ref) => colorList);

// StateProvider es para mantener una pieza del estado, Un simple boolean
final isDarkModeProvider = StateProvider<bool>((ref) => false);

// StateProvider es para mantener una pieza del estado, Un simple int
final selectedColorProvider = StateProvider<int>((ref) => 0);

// Un objecto de tipo AppTheme (custom)
final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, AppTheme>(
  (ref) => ThemeNotifier(),
);

// Controller o Notifier
class ThemeNotifier extends StateNotifier<AppTheme> {

  // STATE => Estado = new AppTheme();
  ThemeNotifier(): super(AppTheme());

  void toggleDarkMode() {
    // El nuevo state, va a hacer una copia del state actual, 
    //pero el isDarkMode va a tener el valor opuesto del estado actual
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }

  void changeColorIndex(int colorIndex) {
    state = state.copyWith(selectedColor: colorIndex);
  }

}
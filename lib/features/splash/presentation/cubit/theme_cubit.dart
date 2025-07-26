import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppTheme { light, dark }

class ThemeCubit extends Cubit<AppTheme> {
  static const String themeKey = 'theme_mode';

  ThemeCubit() : super(AppTheme.light) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(themeKey) ?? false;
    emit(isDark ? AppTheme.dark : AppTheme.light);
  }


  Future<void> setTheme(AppTheme theme) async {
    final prefs = await SharedPreferences.getInstance();
    emit(theme);
    await prefs.setBool(ThemeCubit.themeKey, theme == AppTheme.dark);
  }

}

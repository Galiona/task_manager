import 'package:flutter/material.dart';

class TaskManagerTheme {
  static ThemeData lightTheme = ThemeData(
    // Используем colorScheme для определения цветов
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFffd389), // Primary color
      primary: const Color(0xFFffd389), // Primary color
      secondary: const Color(0xFF4ceb8b), // Secondary color
    ),
    // Можно настроить другие аспекты темы по мере необходимости
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(color: Color(0xFFff9033)), // Изменили цвет hintText
      filled: true,
      fillColor: Colors.white.withOpacity(0.2), // Используем withOpacity
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    ),
    // ...
  );
}
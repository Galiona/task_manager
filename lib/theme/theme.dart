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
     // Добавляем тему для BottomNavigationBar
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor:  Color(0xFF4ceb8b), // Цвет фона
      selectedItemColor: Color(0xFFffd389), // Основной цвет для выбранных иконок
      unselectedItemColor: Colors.grey, // Серый цвет для неактивных иконок
      showUnselectedLabels: true, // Показывать текст для неактивных иконок
      selectedLabelStyle: TextStyle(
        fontWeight: FontWeight.bold,
      ), // Стиль текста для выбранных иконок
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.normal,
      ), // Стиль текста для неактивных иконок
    ),
    // ...
  );
}
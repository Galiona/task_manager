import 'package:flutter/material.dart';
import '../pages/login_page.dart';
import '../theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager', // Изменил название приложения
      theme: TaskManagerTheme.lightTheme,
      home: const LoginPage(), 
    );
  }
}

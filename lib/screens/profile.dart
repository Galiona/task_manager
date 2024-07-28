import 'package:flutter/material.dart';

import '../pages/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Заменяем Firebase Authentication на логику из LoginPage
  String? userEmail = 'test@example.com'; // Тестовое значение
  bool isEmailVerified = false; // Тестовое значение

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Аватар
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                'assets/avatar.jpg', // Замените на URL аватара пользователя
              ),
            ),
            const SizedBox(height: 20),

            // Почта
            Text(
              userEmail ?? 'Неизвестно',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Кнопка подтверждения почты
            if (!isEmailVerified)
              ElevatedButton(
                onPressed: () {
                  // Заменяем отправку письма на показ SnackBar
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Письмо с подтверждением отправлено!')),
                  );
                  setState(() {
                    isEmailVerified = true; // Тестовое подтверждение
                  });
                },
                child: const Text('Отправить запрос подтверждения'),
              ),
            const SizedBox(height: 20),

            // Кнопка выхода
            ElevatedButton(
              onPressed: () {
                // Переход на страницу входа
                Navigator.pushReplacement(context, 
                MaterialPageRoute(builder: (context) {
                return LoginPage();
                }));
              },
              child: const Text('Выйти'),
            ),
          ],
        ),
      
    );
  }
}

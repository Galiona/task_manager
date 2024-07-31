import 'package:flutter/material.dart';
import 'package:task_manager/services/firebase_auth.dart';
import '../pages/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Получаем данные пользователя из AuthService
  final AuthService _authService = AuthService();
  String? userEmail;
  bool isEmailVerified = false;
  String? userAvatarUrl;

  @override
  void initState() {
    super.initState();

    // Получаем текущего пользователя
    final user = _authService.currentUser; 

    // Если пользователь не равен null, обновляем состояние
    if (user != null) {
      setState(() {
        userEmail = user.email;
        isEmailVerified = user.emailVerified;
        userAvatarUrl = user.photoURL; // Получаем URL аватара
      });
    } else {
      // Если пользователя нет, устанавливаем значения по умолчанию
      setState(() {
        userEmail = null;
        isEmailVerified = false;
        userAvatarUrl = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return 
     Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.secondary,
              Theme.of(context).colorScheme.primary,
            ],
            stops: const [0.1, 0.9], // 90% primary, 10% secondary
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Аватар
                CircleAvatar(
                  radius: 50,
                  backgroundImage: userAvatarUrl != null
                      ? NetworkImage(userAvatarUrl!) // Используем URL аватара
                      : AssetImage('assets/avatar.jpg'), // Используем дефолтный аватар
                ),
                const SizedBox(height: 20),

                // Почта
                Text(
                  userEmail ?? 'Неизвестно',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 10),

                // Кнопка подтверждения почты
                if (!isEmailVerified)
                  ElevatedButton(
                    onPressed: () {
                      // Отправляем запрос подтверждения почты
                      _authService.sendEmailVerification();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Письмо с подтверждением отправлено!')),
                      );
                    },
                    child: const Text('Подтверждение почты'),
                  ),
                const SizedBox(height: 20),

                // Кнопка выхода
                ElevatedButton(
                  onPressed: () {
                    // Выход из аккаунта
                    _authService.signOut().then((_) {
                      // Переход на страницу входа
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => const LoginPage()));
                    });
                  },
                  child: const Text('Выйти'),
                ),
              ],
            ),
          ),
        ),
      );
  }
}

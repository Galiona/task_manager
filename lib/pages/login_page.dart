import 'package:flutter/material.dart';

import 'main_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isSignIn = true; // Флаг для определения режима (вход/регистрация)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Градиентный фон
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: _isSignIn
                    ? [
                        Theme.of(context).colorScheme.secondary,
                        Theme.of(context).colorScheme.primary,
                      ]
                    : [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary,
                      ],
                stops: const [0.1, 0.9], // 90% primary, 10% secondary
              ),
            ),
          ),
          // Содержимое страницы
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Отступ сверху
                    const SizedBox(height: 80), // Добавлен отступ

                    // Заголовок приложения
                    Text(
                      'Менеджер задач',
                      style: TextStyle(
                        fontSize: 40, // Увеличили размер шрифта
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                        fontFamily: 'Roboto', // Выбрали шрифт Roboto
                      ),
                    ),
                    const SizedBox(height: 20), // Отступ между заголовком и формой

                    // Заголовок формы
                    Text(
                      _isSignIn ? 'Вход' : 'Регистрация',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Поле логина
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Почта',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.2), // Используем withOpacity
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Поле пароля
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Пароль',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.2), // Используем withOpacity
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Поле "Повторить пароль" (только для регистрации)
                    if (!_isSignIn)
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Повторить пароль',
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.2), // Используем withOpacity
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                      ),
                    const SizedBox(height: 30),

                    // Кнопка "Войти"
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(
                              builder: (context) => const MainPage()));
                        // Обработка входа/регистрации
                      },
                      child: Text(_isSignIn ? 'Войти' : 'Зарегистрироваться'),
                    ),
                    const SizedBox(height: 20),

                    // Кнопка "У меня еще нет аккаунта"
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isSignIn = !_isSignIn;
                        });
                      },
                      child: Text(
                        _isSignIn
                            ? 'У меня еще нет аккаунта'
                            : 'Вернуться на страницу входа',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

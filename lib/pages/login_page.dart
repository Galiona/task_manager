import 'package:flutter/material.dart';
import 'package:task_manager/pages/main_page.dart';
import 'package:task_manager/services/firebase_auth.dart'; // Импортируем AuthenticationService

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isSignIn = true; // Флаг для определения режима (вход/регистрация)
  final _formKey = GlobalKey<FormState>(); // Ключ для формы
  final _emailController = TextEditingController(); // Контроллер для поля email
  final _passwordController = TextEditingController(); // Контроллер для поля password
  final _confirmPasswordController = TextEditingController(); // Контроллер для поля подтверждения пароля
  final _authService = AuthService(); // Экземпляр AuthenticationService

  // Переменная для хранения сообщения об ошибке
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

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
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Отступ сверху
                      const SizedBox(height: 80), // Добавлен отступ

                      // Заголовок приложения
                      const Text(
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
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'Почта',
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.2), // Используем withOpacity
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Пожалуйста, введите email';
                          }
                          if (!value.contains('@')) {
                            return 'Некорректный email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Поле пароля
                      TextFormField(
                        controller: _passwordController,
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Пожалуйста, введите пароль';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Поле "Повторить пароль" (только для регистрации)
                      if (!_isSignIn)
                        TextFormField(
                          controller: _confirmPasswordController,
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Пожалуйста, повторите пароль';
                            }
                            if (value != _passwordController.text) {
                              return 'Пароли не совпадают';
                            }
                            return null;
                          },
                        ),
                      const SizedBox(height: 30),

                      // Отображение сообщения об ошибке
                      if (_errorMessage != null)
                        Text(
                          _errorMessage!,
                          style: const TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      const SizedBox(height: 20),

                      // Кнопка "Войти"
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (_isSignIn) {
                              // Вход с помощью email и пароля
                              final userCredential =
                                  await _authService.signInWithEmailAndPassword(
                                      _emailController.text,
                                      _passwordController.text);
                              if (userCredential != null) {
                                // Переход на главную страницу
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const MainPage(),
                                    ));
                              } else {
                                // Ошибка входа
                                setState(() {
                                  _errorMessage =
                                      'Неверный email или пароль.';
                                });
                              }
                            } else {
                              // Регистрация с помощью email и пароля
                              final userCredential =
                                  await _authService.createUserWithEmailAndPassword(
                                      _emailController.text,
                                      _passwordController.text);
                              if (userCredential != null) {
                                // Отправка запроса подтверждения почты
                                await _authService.sendEmailVerification();
                                // Переход на главную страницу
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const MainPage(),
                                    ));
                              } else {
                                // Ошибка регистрации
                                setState(() {
                                  _errorMessage =
                                      'Ошибка регистрации. Попробуйте снова.';
                                });
                              }
                            }
                          }
                        },
                        child: Text(_isSignIn ? 'Войти' : 'Зарегистрироваться'),
                      ),
                      const SizedBox(height: 20),

                      // Кнопка "У меня еще нет аккаунта"
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isSignIn = !_isSignIn;
                            _errorMessage = null; // Сброс сообщения об ошибке
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
          ),
        ],
      ),
    );
  }
}

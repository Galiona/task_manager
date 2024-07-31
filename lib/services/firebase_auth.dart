import 'package:firebase_auth/firebase_auth.dart';
// mport 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Объект для работы с аутентификацией Firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Объект для работы с Google Sign-In
  // final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Получение текущего пользователя
  User? get currentUser => _auth.currentUser;

/*   // Метод для входа с помощью Google
  Future<UserCredential?> signInWithGoogle() async {
    // 1. Авторизация с помощью Google Sign-In
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    // 2. Получение учетных данных Google
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // 3. Создание учетных данных Firebase с помощью Google
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // 4. Вход в Firebase с помощью учетных данных Google
    return await _auth.signInWithCredential(credential);
  } */

  // Метод для входа с помощью email и пароля
  Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      // Вход в Firebase с помощью email и пароля
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      // Обработка ошибок аутентификации
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'Пользователь с таким email не найден.';
          break;
        case 'wrong-password':
          errorMessage = 'Неверный пароль.';
          break;
        default:
          errorMessage = 'Ошибка аутентификации.';
      }
      // Вывод сообщения об ошибке
      print('Ошибка аутентификации: $errorMessage');
      return null;
    }
  }

  // Метод для регистрации с помощью email и пароля
  Future<UserCredential?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      // Регистрация в Firebase с помощью email и пароля
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      // Обработка ошибок аутентификации
      String errorMessage;
      switch (e.code) {
        case 'weak-password':
          errorMessage = 'Пароль слишком слабый.';
          break;
        case 'email-already-in-use':
          errorMessage = 'Пользователь с таким email уже существует.';
          break;
        case 'invalid-email':
          errorMessage = 'Неверный формат email.';
          break;
        default:
          errorMessage = 'Ошибка аутентификации.';
      }
      // Вывод сообщения об ошибке
      print('Ошибка аутентификации: $errorMessage');
      return null;
    }
  }

  // Метод для отправки запроса подтверждения почты
  Future<void> sendEmailVerification() async {
    // Получение текущего пользователя
    final user = _auth.currentUser;

    // Отправка запроса подтверждения почты
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  // Метод для выхода из системы
  Future<void> signOut() async {
    // 1. Выход из Firebase
    await _auth.signOut();

    // 2. Выход из Google Sign-In
    // await _googleSignIn.signOut();
  }
}

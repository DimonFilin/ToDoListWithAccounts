import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do_list_for_flutter_krainet_vacancy/data/api/firestore.dart';

abstract class AuthenticationDaraSource {
  Future<void> register(String email, String password, String confirmPassword);

  Future<void> login(String email, String password);
}

class AuthenticationRemote extends AuthenticationDaraSource {
  @override
  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(), password: password.trim());
  }

  @override
  Future<void> register(
      String email, String password, String confirmPassword) async {
    if (confirmPassword == password) {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim())
          .then((value) {
        FireStore_Database().CreateUser(email);
      });
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do_list_for_flutter_krainet_vacancy/data/api/firestore.dart';

//Class describes the fields to create or login to a user account
abstract class AuthenticationDaraSource {
  Future<void> register(String email, String password, String confirmPassword);
  Future<void> login(String email, String password);
}

//This class describe the implementation of account and registration
class AuthenticationRemote extends AuthenticationDaraSource {

  //Login method -> send data -> to set user on this device
  @override
  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(), password: password.trim());
  }

  //Register method checks the password and
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

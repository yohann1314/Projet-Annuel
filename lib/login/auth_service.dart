import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future<String?> registration({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Le mot de passe est trop faible.';
      } else if (e.code == 'email-already-in-use') {
        return 'Un compte utilise déja cette adresse';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "Le Mot de passe ou l'email est incorect";
      } else if (e.code == 'wrong-password') {
        return "Le Mot de passe ou l'email est incorect";
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth auth;
  Auth({this.auth});

  // Anything auth changes, return a user for it
  Stream<User> get user => auth.authStateChanges();

  Future<String> createAccount({String email, String password}) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return 'Success';
    } on FirebaseAuthException catch (e) {
      return e.toString();
    } catch (e) {
      rethrow;
    }
  }

  Future<String> signIn({String email, String password}) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return 'Success';
    } on FirebaseAuthException catch (e) {
      return e.toString();
    } catch (e) {
      rethrow;
    }
  }

  Future<String> signOut() async {
    try {
      await auth.signOut();
      return 'Success';
    } on FirebaseAuthException catch (e) {
      return e.toString();
    } catch (e) {
      rethrow;
    }
  }
}

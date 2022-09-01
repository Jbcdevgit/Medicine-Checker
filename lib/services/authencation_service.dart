import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth);

  Future<String> signIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return " ";
    } on FirebaseAuthException catch(e) {
      switch(e.code) {
        case 'wrong-password':
          return 'Invalid Username or Password';
        case 'user-not-found':
          return 'Invalid Username or Password';
        case 'network-request-failed':
          return 'Please connect to a internet';
        default:
          return 'Server error, please try again later';
      }
    }
  }

  Future<String> signUp({required String email}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: 'password');
      return " ";
    } on FirebaseAuthException catch(e) {
      switch(e.code) {
        case 'email-already-in-use':
          await signIn(email: email, password: 'password');
          return 'existing-user';
        default:
          return 'Server error, please try again later';
      }
    }
  }

  Future<String> signOut() async {
    await _firebaseAuth.signOut();
    return "Sign Out";
  }
}
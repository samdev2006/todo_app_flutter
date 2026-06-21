import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'userModel.dart';

class Authremotedatasource {
  final firebase_auth.FirebaseAuth firebaseAuth;

  Authremotedatasource(this.firebaseAuth);

  Future<Usermodel> signIn(String email, String password) async {
    final credential = await firebaseAuth.signInWithEmailAndPassword(
      email: email, 
      password: password,
      );
    return Usermodel.fromFirebaseUser(credential.user!);
  }

  Future<Usermodel> signUp(String email,String password) async{
    final credential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email, 
      password: password
      );
      return Usermodel.fromFirebaseUser(credential.user!);
  }

  Future<void> signOut(){
    return firebaseAuth.signOut();
  }
  
  Stream <Usermodel?> get authStateChanges {
    return firebaseAuth.authStateChanges().map((user) {
      return user != null ? Usermodel.fromFirebaseUser(user) : null;
    });
  }
}
import 'package:todoapp/features/auth/domain/userEntity.dart';

abstract class Authrepository {

  //méthode pour l'inscripption
  Future<Userentity> signIn (String email, String password);
  //méthode de connexion 
  Future<Userentity> signUp (String email, String password);
  //méthode  de déconnexion
  Future<void> signOut();
  Stream <Userentity?> get authStateChanges;
}
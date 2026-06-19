import 'package:todoapp/features/auth/domain/userEntity.dart';

abstract class Authrepository {

  Future<Userentity> signIn (String email, String password);
  Future<Userentity> singnUp (String email, String password);
  Future<void> signOut();
  Stream <Userentity?> get authStateChanges;
}
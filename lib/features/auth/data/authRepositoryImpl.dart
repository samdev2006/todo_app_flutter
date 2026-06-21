import 'package:todoapp/features/auth/data/authRemoteDatasource.dart';
import 'package:todoapp/features/auth/domain/authRepository.dart';
import 'package:todoapp/features/auth/domain/userEntity.dart';

class AuthrepositoryImpl implements Authrepository {
  final Authremotedatasource authremotedatasource;
  AuthrepositoryImpl(this.authremotedatasource);

  @override
  Stream<Userentity?> get authStateChanges => authremotedatasource.authStateChanges;

  @override
  Future<Userentity> signIn(String email, String password) {
    return authremotedatasource.signIn(email, password);
    
  }

  @override
  Future<void> signOut() {
   return  authremotedatasource.signOut();
   
  }

  @override
  Future<Userentity> signUp(String email, String password) {
    return authremotedatasource.signUp(email, password);
   
  }
  


  
}
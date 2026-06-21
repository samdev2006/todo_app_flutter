import 'package:todoapp/features/auth/domain/authRepository.dart';
import 'package:todoapp/features/auth/domain/userEntity.dart';


//Chaque UseCase défini une fonctionnalité de l'appplication
class SignInUseCase {
  final Authrepository repository;
  SignInUseCase(this.repository);

  Future<Userentity> call(String email, String password){
    return repository.signIn(email, password);
  }
}


class SignUpUseCase {
  final Authrepository repository;
  SignUpUseCase(this.repository);

  Future<Userentity> call(String email, String password){
    return repository.signUp(email, password);
  }  
}


class SignOutUseCase {
  final Authrepository repository;
  SignOutUseCase(this.repository);

  Future<void> call() {
    return repository.signOut();
  }
}
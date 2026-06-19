import 'package:todoapp/features/auth/domain/authRepository.dart';
import 'package:todoapp/features/auth/domain/userEntity.dart';

class SingnInUseCase {
  final Authrepository repository;
  SingnInUseCase(this.repository);

  Future<Userentity> call(String email, String password){
    return repository.signIn(email, password);
  }
  
}

class singnUpUseCase {
  final Authrepository repository;
  singnUpUseCase(this.repository);

  Future<Userentity> call(String email, String password){
    return repository.singnUp(email, password);
  }

  
}
import 'package:firebase_auth/firebase_auth.dart'as firebase_auth;
import 'package:todoapp/features/auth/domain/userEntity.dart';

class Usermodel extends Userentity {
  Usermodel({
    required super.id,
     required super.email
     }
     );
  factory Usermodel.fromFirebaseUser(firebase_auth.User user){
    return Usermodel(id: 
    user.uid, 
    email:user.email ?? '',
    );
  }
  
}
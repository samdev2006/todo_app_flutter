part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable{
  const AuthState
}

class AuthInitial extends AuthState {}

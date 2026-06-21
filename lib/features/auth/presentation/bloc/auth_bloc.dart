import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todoapp/features/auth/domain/userEntity.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState>{
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final SignOutUseCase signOutUseCase;

  AuthBloc({
    required this.signInUseCase,
    required this.signOutUseCase,
    required this.signUpUseCase,
  }) : super(AuthInitial()){
    on<SignInRequested>((event,emit) async {
      emit(AuthLoading());
      try{
        final user = await signInUseCase(event.email, event.password);
        emit(AuthSuccess(user));
      } catch(e){
        emit(AuthFailure(e.toString()));
      }
    });

    on<SignInRequested>((event,emit) async {
      emit(AuthLoading());
      try{
        final user = await signUpUseCase(event.email,event.password);
        emit(AuthSuccess(user));
      }catch(e) {
        emit(AuthFailure(e.toString()));
      }
    });
    on<SignOutRequested>((event,emit) async {
      await signOutUseCase();
      emit(AuthInitial());
    });
  }

}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todoapp/features/auth/data/authRemoteDatasource.dart';
import 'package:todoapp/features/auth/data/authRepositoryImpl.dart';
import 'package:todoapp/features/auth/domain/authUsecases.dart';
import 'firebase_options.dart';
import 'package:todoapp/features/auth/presentation/bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final authremotedatasource = Authremotedatasource(FirebaseAuth.instance);
  final authRepository = AuthrepositoryImpl(authremotedatasource);

  final signInUseCase = SignInUseCase(authRepository);
  final signUpUseCase =SignUpUseCase(authRepository);
  final signOutUseCase = SignOutUseCase(authRepository);

  runApp(MyApp(
    signInUseCase : signInUseCase,
    signUpUseCase : signUpUseCase,
    signOutUseCase : signOutUseCase,
  ));
}

class MyApp extends StatelessWidget {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final SignOutUseCase signOutUseCase;

  const MyApp({
    super.key,
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.signOutUseCase,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => AuthBloc(
          signInUseCase: signInUseCase,
          signUpUseCase: signUpUseCase,
          signOutUseCase: signOutUseCase,
        ),
        child: const LoginPage(),
      ),
    );
  }
}
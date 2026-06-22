import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

// Auth
import 'features/auth/data/authRemoteDatasource.dart';
import 'features/auth/data/authRepositoryImpl.dart';
import 'features/auth/domain/authUsecases.dart';
import 'features/auth/presentation/loginPage.dart';
import 'package:todoapp/features/auth/presentation/bloc/auth_bloc.dart';

// Tasks
import 'features/tasks/data/taskRemoteDatasource.dart';
import 'features/tasks/data/taskRepositoryImpl.dart';
import 'features/tasks/domain/taskUsecases.dart';
import 'features/tasks/presentation/tasks_bloc.dart';
import 'features/tasks/presentation/task_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Auth
  final authDataSource = Authremotedatasource(FirebaseAuth.instance);
  final authRepository = AuthrepositoryImpl(authDataSource);
  final signInUseCase = SignInUseCase(authRepository);
  final signUpUseCase = SignUpUseCase(authRepository);
  final signOutUseCase = SignOutUseCase(authRepository);

  // Tasks
  final taskDataSource = TaskRemoteDataSource(FirebaseFirestore.instance);
  final taskRepository = TaskRepositoryImpl(taskDataSource);
  final getTasksUseCase = GetTaskUseCase(taskRepository);
  final addTaskUseCase = AddTaskUseCase(taskRepository);
  final updateTaskUseCase = UpdateTaskUseCase(taskRepository);
  final deleteTaskUseCase = DeleteTaskUseCase(taskRepository);

  runApp(MyApp(
    signInUseCase: signInUseCase,
    signUpUseCase: signUpUseCase,
    signOutUseCase: signOutUseCase,
    getTasksUseCase: getTasksUseCase,
    addTaskUseCase: addTaskUseCase,
    updateTaskUseCase: updateTaskUseCase,
    deleteTaskUseCase: deleteTaskUseCase,
  ));
}

class MyApp extends StatelessWidget {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final SignOutUseCase signOutUseCase;
  final GetTaskUseCase getTasksUseCase;
  final AddTaskUseCase addTaskUseCase;
  final UpdateTaskUseCase updateTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;

  const MyApp({
    super.key,
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.signOutUseCase,
    required this.getTasksUseCase,
    required this.addTaskUseCase,
    required this.updateTaskUseCase,
    required this.deleteTaskUseCase,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            signInUseCase: signInUseCase,
            signUpUseCase: signUpUseCase,
            signOutUseCase: signOutUseCase,
          ),
        ),
        BlocProvider(
          create: (_) => TaskBloc(
            getTasksUseCase: getTasksUseCase,
            addTaskUseCase: addTaskUseCase,
            updateTaskUseCase: updateTaskUseCase,
            deleteTaskUseCase: deleteTaskUseCase,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Todo App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is AuthSuccess) {
              return TaskListPage(userId: state.user.id);
            }
            return const LoginPage();
          },
        ),
      ),
    );
  }
}
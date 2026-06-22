import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/features/tasks/presentation/tasks_event.dart';
import 'package:todoapp/features/tasks/presentation/tasks_state.dart';
import 'package:todoapp/features/tasks/domain/taskUsecases.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTaskUseCase getTasksUseCase;
  final AddTaskUseCase addTaskUseCase;
  final UpdateTaskUseCase updateTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;

  TaskBloc({
    required this.getTasksUseCase,
    required this.addTaskUseCase,
    required this.updateTaskUseCase,
    required this.deleteTaskUseCase,
  }) : super(TaskInitial()) {
    on<LoadTasks>((event, emit) async {
      emit(TaskLoading());
      await emit.forEach(
        getTasksUseCase(event.userId),
        onData: (tasks) => tasks.isEmpty ? TaskEmpty() : TaskLoaded(tasks),
        onError: (error, _) => TaskError(error.toString()),
      );
    });

    on<AddTask>((event, emit) async {
      try {
        await addTaskUseCase(event.task);
      } catch (e) {
        emit(TaskError(e.toString()));
      }
    });

    on<UpdateTask>((event, emit) async {
      try {
        await updateTaskUseCase(event.task);
      } catch (e) {
        emit(TaskError(e.toString()));
      }
    });

    on<DeleteTask>((event, emit) async {
      try {
        await deleteTaskUseCase(event.taskId);
      } catch (e) {
        emit(TaskError(e.toString()));
      }
    });
  }
}
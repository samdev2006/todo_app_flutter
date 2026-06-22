import 'package:todoapp/features/tasks/domain/taskEntity.dart';
import 'package:todoapp/features/tasks/domain/taskRepository.dart';

class GetTaskUseCase {
  final Taskrepository repository;
  GetTaskUseCase(this.repository);
  Stream<List<Taskentity>>  call(String userId) => repository.getTasks(userId);
  
}

class AddTaskUseCase {
  final Taskrepository repository;
  AddTaskUseCase(this.repository);
  Future<void> call(Taskentity task) => repository.addTasks(task);
  
}

class UpdateTaskUseCase {
  final Taskrepository repository;
  UpdateTaskUseCase(this.repository);
  Future<void> call(Taskentity task) => repository.updateTask(task);
}

class DeleteTaskUseCase {
  final Taskrepository repository;
  DeleteTaskUseCase(this.repository);
  Future<void> call(String taskId) => repository.deleteTask(taskId);
}


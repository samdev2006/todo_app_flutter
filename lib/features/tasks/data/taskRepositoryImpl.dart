import 'package:todoapp/features/tasks/domain/taskEntity.dart';
import 'package:todoapp/features/tasks/data/taskRemoteDatasource.dart';
import 'package:todoapp/features/tasks/domain/taskRepository.dart';

class TaskRepositoryImpl implements Taskrepository {
  final TaskRemoteDataSource dataSource;

  TaskRepositoryImpl(this.dataSource);

  @override
  Stream<List<Taskentity>> getTasks(String userId) {
    return dataSource.getTasks(userId);
  }

  @override
  Future<void> addTasks(Taskentity task) {
    return dataSource.addTask(task);
  }

  @override
  Future<void> updateTask(Taskentity task) {
    return dataSource.updateTask(task);
  }

  @override
  Future<void> deleteTask(String taskId) {
    return dataSource.deleteTask(taskId);
  }
}
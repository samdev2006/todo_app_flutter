import 'package:todoapp/features/tasks/domain/taskEntity.dart';

abstract class Taskrepository {

  Stream<List<Taskentity>> getTasks(String userId);
  Future<void> addTasks(Taskentity task);
  Future<void> updateTask(Taskentity task);
  Future<void> deleteTask(String taskId);
  
}
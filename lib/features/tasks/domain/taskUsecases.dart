import 'package:todoapp/features/tasks/domain/taskEntity.dart';
import 'package:todoapp/features/tasks/domain/taskRepository.dart';

class GetTaskUseCase {
  final Taskrepository repository;
  GetTaskUseCase(this.repository);
  Stream<List<Taskentity>>  call(String userId)=> repository.getTasks(userId);
  
}


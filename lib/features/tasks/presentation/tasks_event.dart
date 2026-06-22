import 'package:equatable/equatable.dart';
import'package:todoapp/features/tasks/domain/taskEntity.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();
  @override
  List<Object?> get props => [];
}

class LoadTasks extends TaskEvent {
  final String userId;
  const LoadTasks(this.userId);
  @override
  List<Object?> get props => [userId];
}

class AddTask extends TaskEvent {
  final Taskentity task;
  const AddTask(this.task);
  @override
  List<Object?> get props => [task];
}

class UpdateTask extends TaskEvent {
  final Taskentity task;
  const UpdateTask(this.task);
  @override
  List<Object?> get props => [task];
}

class DeleteTask extends TaskEvent {
  final String taskId;
  const DeleteTask(this.taskId);
  @override
  List<Object?> get props => [taskId];
}
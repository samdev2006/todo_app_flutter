import 'package:equatable/equatable.dart';
import'package:todoapp/features/tasks/domain/taskEntity.dart';

abstract class TaskState extends Equatable {
  const TaskState();
  @override
  List<Object?> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Taskentity> tasks;
  const TaskLoaded(this.tasks);
  @override
  List<Object?> get props => [tasks];
}

class TaskEmpty extends TaskState {}

class TaskError extends TaskState {
  final String message;
  const TaskError(this.message);
  @override
  List<Object?> get props => [message];
}
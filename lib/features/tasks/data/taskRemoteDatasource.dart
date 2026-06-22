import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/features/tasks/domain/taskEntity.dart';
import 'package:todoapp/features/tasks/data/taskModel.dart';

class TaskRemoteDataSource {
  final FirebaseFirestore firestore;

  TaskRemoteDataSource(this.firestore);

  Stream<List<TaskModel>> getTasks(String userId) {
    return firestore
        .collection('tasks')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => TaskModel.fromFirestore(doc))
            .toList());
  }

  Future<void> addTask(Taskentity task) {
    return firestore.collection('tasks').add(TaskModel(
      id: '',
      title: task.title,
      description: task.description,
      isDone: task.isDone,
      userId: task.userId,
      createdAt: task.createdAt,
    ).toMap());
  }

  Future<void> updateTask(Taskentity task) {
    return firestore.collection('tasks').doc(task.id).update(TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      isDone: task.isDone,
      userId: task.userId,
      createdAt: task.createdAt,
    ).toMap());
  }

  Future<void> deleteTask(String taskId) {
    return firestore.collection('tasks').doc(taskId).delete();
  }
}
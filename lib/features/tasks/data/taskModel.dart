import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/features/tasks/domain/taskEntity.dart';


class TaskModel extends Taskentity {
  const TaskModel({
    required super.id,
    required super.title,
    required super.description,
    required super.isDone,
    required super.userId,
    required super.createdAt,
  });

  factory TaskModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TaskModel(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      isDone: data['isDone'] ?? false,
      userId: data['userId'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'isDone': isDone,
      'userId': userId,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
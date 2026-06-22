import 'package:equatable/equatable.dart';

class Taskentity extends Equatable {
  final String id;
  final String title;
  final String description;
  final bool isDone;
  final String userId;
  final DateTime createdAt;

  const Taskentity({
    required this.id,
    required this.title,
    required this.description,
    required this.isDone,
    required this.userId,
    required this.createdAt,
  });
  Taskentity copyWith({
    String? id,
    String? title,
    String? description,
    bool? isDone,
    String? userId,
    DateTime? createdAt,
  }) {
    return Taskentity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props =>
      [id, title, description, isDone, userId, createdAt];
}

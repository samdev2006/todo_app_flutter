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

  @override
  List<Object?> get props => [id,title,description,isDone,userId,createdAt];
  
}
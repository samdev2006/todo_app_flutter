import 'package:equatable/equatable.dart';

class Userentity extends Equatable {
  final String id;
  final String email;

  const Userentity({
    required this.id,
    required this.email,
  });

  @override
  List<Object?> get props => [id,email];
  
}
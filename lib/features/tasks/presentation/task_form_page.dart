import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/features/tasks/domain/taskEntity.dart';
import 'package:todoapp/features/tasks/presentation/tasks_bloc.dart';
import 'package:todoapp/features/tasks/presentation/tasks_event.dart';


class TaskFormPage extends StatefulWidget {
  final String userId;
  final Taskentity? task;

  const TaskFormPage({super.key, required this.userId, this.task});

  @override
  State<TaskFormPage> createState() => _TaskFormPageState();
}

class _TaskFormPageState extends State<TaskFormPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      titleController.text = widget.task!.title;
      descriptionController.text = widget.task!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.task != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Modifier la tâche' : 'Nouvelle tâche'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Titre'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text.trim();
                if (title.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Le titre ne peut pas être vide')),
                  );
                  return;
                }

                if (isEditing) {
                  context.read<TaskBloc>().add(UpdateTask(
                    Taskentity(
                      id: widget.task!.id,
                      title: title,
                      description: descriptionController.text.trim(),
                      isDone: widget.task!.isDone,
                      userId: widget.userId,
                      createdAt: widget.task!.createdAt,
                    ),
                  ));
                } else {
                  context.read<TaskBloc>().add(AddTask(
                    Taskentity(
                      id: '',
                      title: title,
                      description: descriptionController.text.trim(),
                      isDone: false,
                      userId: widget.userId,
                      createdAt: DateTime.now(),
                    ),
                  ));
                }
                Navigator.pop(context);
              },
              child: Text(isEditing ? 'Modifier' : 'Ajouter'),
            ),
          ],
        ),
      ),
    );
  }
}
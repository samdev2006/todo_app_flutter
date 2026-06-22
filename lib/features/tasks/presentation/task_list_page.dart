import 'package:flutter/material.dart';
import 'package:todoapp/features/tasks/presentation/task_list_page.dart';
import 'package:todoapp/features/tasks/presentation/tasks_bloc.dart';
import 'package:todoapp/features/tasks/presentation/tasks_state.dart';
import 'package:todoapp/features/tasks/presentation/task_form_page.dart';
import 'package:todoapp/features/tasks/presentation/tasks_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskListPage extends StatelessWidget {
  final String userId;
  const TaskListPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    context.read<TaskBloc>().add(LoadTasks(userId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes tâches'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // TODO: ajouter SignOutRequested via AuthBloc
            },
          ),
        ],
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is TaskEmpty) {
            return const Center(child: Text('Aucune tâche pour le moment.'));
          }
          if (state is TaskError) {
            return Center(child: Text('Erreur : ${state.message}'));
          }
          if (state is TaskLoaded) {
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                return ListTile(
                  leading: Checkbox(
                    value: task.isDone,
                    onChanged: (_) {
                      context.read<TaskBloc>().add(UpdateTask(
                        task.copyWith(isDone: !task.isDone),
                      ));
                    },
                  ),
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration: task.isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  subtitle: Text(task.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TaskFormPage(
                                userId: userId,
                                task: task,
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context.read<TaskBloc>().add(DeleteTask(task.id));
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TaskFormPage(userId: userId),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
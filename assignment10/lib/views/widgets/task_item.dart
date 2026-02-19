import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../controllers/task_cubit.dart';
import '../../models/task_model.dart';

class TaskItemWidget extends StatelessWidget {
  final Task task;

  const TaskItemWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: GestureDetector(
        onTap: () => context.read<TaskCubit>().toggleTaskStatus(task.id),
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: task.isCompleted ? Colors.teal : Colors.transparent,
            border: Border.all(
              color: task.isCompleted ? Colors.teal : Colors.grey,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: task.isCompleted
              ? const Icon(Icons.check, size: 16, color: Colors.white)
              : null,
        ),
      ),
      title: Text(
        task.title,
        style: TextStyle(
          fontSize: 16,
          decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          color: task.isCompleted ? Colors.grey : Colors.black,
        ),
      ),
      subtitle: Text(
        DateFormat('hh:mm a').format(task.date),
        style: const TextStyle(color: Colors.grey, fontSize: 12),
      ),
    );
  }
}

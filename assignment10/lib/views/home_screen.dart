import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../controllers/task_cubit.dart';
import '../controllers/task_state.dart';
import 'add_task_screen.dart';
import 'widgets/task_item.dart';
import 'widgets/bottom_nav.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<TaskCubit, TaskState>(
                  buildWhen: (previous, current) =>
                      previous.tasks != current.tasks ||
                      previous.currentTab != current.currentTab,
                  builder: (context, state) {
                    final tasks = context.read<TaskCubit>().filteredTasks;

                    if (tasks.isEmpty) {
                      return const Center(
                        child: Text(
                          "No tasks found",
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: TaskItemWidget(task: tasks[index]),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const BottomNavWidget(),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      buildWhen: (previous, current) =>
          previous.currentTab != current.currentTab,
      builder: (context, state) {
        String title = "Tasks";
        if (state.currentTab == 1) title = "Pending";
        if (state.currentTab == 2) title = "Completed";

        Widget? icon;
        if (state.currentTab == 0) {
          icon = InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddTaskScreen()),
            ),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 20),
            ),
          );
        } else if (state.currentTab == 1) {
          icon = const Icon(
            Icons.timer_outlined,
            color: Colors.redAccent,
            size: 30,
          );
        } else {
          icon = const Icon(Icons.check_circle, color: Colors.teal, size: 30);
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  DateFormat('MMMM d').format(DateTime.now()),
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
            icon,
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../controllers/task_controller.dart';
import 'add_task_screen.dart';
import 'widgets/task_item.dart';

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
              Consumer<TaskController>(
                builder: (context, controller, child) {
                  String title = "Tasks";
                  if (controller.currentTab == 1) title = "Pending";
                  if (controller.currentTab == 2) title = "Completed";

                  Widget? icon;
                  if (controller.currentTab == 0) {
                    icon = InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AddTaskScreen(),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    );
                  } else if (controller.currentTab == 1) {
                    icon = const Icon(
                      Icons.timer_outlined,
                      color: Colors.redAccent,
                      size: 30,
                    );
                  } else {
                    icon = const Icon(
                      Icons.check_circle,
                      color: Colors.teal,
                      size: 30,
                    );
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
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      icon,
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),

              Expanded(
                child: Consumer<TaskController>(
                  builder: (context, controller, child) {
                    final tasks = controller.filteredTasks;
                    if (tasks.isEmpty) {
                      return const Center(
                        child: Text(
                          "No tasks found",
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }
                    return ListView.separated(
                      itemCount: tasks.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 15),
                      itemBuilder: (context, index) {
                        return TaskItem(task: tasks[index]);
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
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(horizontal: 40),
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Consumer<TaskController>(
          builder: (context, controller, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _TabButton(
                  title: "All",
                  index: 0,
                  isSelected: controller.currentTab == 0,
                ),
                _TabButton(
                  title: "Pending",
                  index: 1,
                  isSelected: controller.currentTab == 1,
                ),
                _TabButton(
                  title: "Completed",
                  index: 2,
                  isSelected: controller.currentTab == 2,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String title;
  final int index;
  final bool isSelected;

  const _TabButton({
    required this.title,
    required this.index,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Provider.of<TaskController>(context, listen: false).changeTab(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

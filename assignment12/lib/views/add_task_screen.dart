import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../controllers/task_cubit.dart';
import '../controllers/task_state.dart';
import '../models/task_model.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerLeft,
                ),
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Add a task",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              const Text(
                "Name your task",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: "EX:- Submit my essay",
                  hintStyle: TextStyle(
                    color: Color.fromARGB(221, 125, 124, 124),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Choose a category",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),

              BlocBuilder<TaskCubit, TaskState>(
                buildWhen: (previous, current) =>
                    previous.draftCategory != current.draftCategory,
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () => _showCategorySheet(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          state.draftCategory == null
                              ? const Text(
                                  "Select Category",
                                  style: TextStyle(fontSize: 16),
                                )
                              : Row(
                                  children: [
                                    Icon(
                                      categories
                                          .firstWhere(
                                            (c) =>
                                                c.name == state.draftCategory,
                                          )
                                          .icon,
                                      size: 18,
                                      color: categories
                                          .firstWhere(
                                            (c) =>
                                                c.name == state.draftCategory,
                                          )
                                          .color,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      state.draftCategory!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),

              BlocBuilder<TaskCubit, TaskState>(
                buildWhen: (previous, current) =>
                    previous.draftDate != current.draftDate,
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: state.draftDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (picked != null && context.mounted) {
                        context.read<TaskCubit>().updateDraftDate(picked);
                      }
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_today_outlined,
                          color: Colors.black,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          DateFormat('MM/dd/yy').format(state.draftDate),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    final cubit = context.read<TaskCubit>();
                    if (titleController.text.isNotEmpty &&
                        cubit.state.draftCategory != null) {
                      cubit.addTask(titleController.text);
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _showCategorySheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetContext) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: categories
                .map(
                  (cat) => ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: cat.color.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(cat.icon, color: cat.color, size: 20),
                    ),
                    title: Text(cat.name),
                    onTap: () {
                      context.read<TaskCubit>().updateDraftCategory(cat.name);
                      Navigator.pop(bottomSheetContext);
                    },
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
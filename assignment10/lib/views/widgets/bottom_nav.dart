import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controllers/task_cubit.dart';
import '../../controllers/task_state.dart';

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: BlocBuilder<TaskCubit, TaskState>(
        buildWhen: (previous, current) =>
            previous.currentTab != current.currentTab,
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTabButton(context, "All", 0, state.currentTab == 0),
              _buildTabButton(context, "Pending", 1, state.currentTab == 1),
              _buildTabButton(context, "Completed", 2, state.currentTab == 2),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTabButton(
    BuildContext context,
    String title,
    int index,
    bool isSelected,
  ) {
    return GestureDetector(
      onTap: () => context.read<TaskCubit>().changeTab(index),
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

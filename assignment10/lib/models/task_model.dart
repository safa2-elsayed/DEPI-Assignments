import 'package:flutter/material.dart';

class Task {
  final String id;
  final String title;
  final DateTime date;
  final String category;
  final bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.date,
    required this.category,
    this.isCompleted = false,
  });

  Task copyWith({
    String? id,
    String? title,
    DateTime? date,
    String? category,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

class CategoryStyle {
  final String name;
  final IconData icon;
  final Color color;

  CategoryStyle(this.name, this.icon, this.color);
}

final List<CategoryStyle> categories = [
  CategoryStyle('Personal', Icons.person_outline, Colors.blue),
  CategoryStyle('Work', Icons.work_outline, Colors.blueAccent),
  CategoryStyle('Health', Icons.favorite_outline, Colors.redAccent),
  CategoryStyle('Family', Icons.home_outlined, Colors.purple),
  CategoryStyle('Learning', Icons.school_outlined, Colors.orange),
];

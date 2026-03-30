To-Do List App (Flutter)

A simple and efficient To-Do List mobile application built with Flutter & Dart.

🚀 Features:- 

➕ Add new tasks

📝 Display a list of tasks

✅ Mark tasks as completed

🔄 Toggle task status (Done / Not Done)

📊 Visual indication of task status

⚡ Real-time UI updates using Cubit

🧩 Clean and scalable architecture
******
📱 Screens
Tasks List Screen
Add Task Screen
Task Item Widget (Reusable component)
******
🧱 Project Architecture :-

The project follows MVVM (Model - View - ViewModel) architecture:
**********

🔹 Model  :-

Represents the data structure of the app.

class Task {
  final String title;
  bool isDone;

  Task({required this.title, this.isDone = false});
}

🔹 View  :-

Handles the UI components (Screens & Widgets).

Examples:

Task List Screen
Task Card Widget
ViewModel (Cubit)

Manages the state and business logic of the application.

*****
Responsibilities:

Adding new tasks
Updating task status
Emitting new states to update the UI

 ******
 
👉 Definition:
The ViewModel acts as a bridge between the View and the Model.
It handles business logic and updates the UI dynamically using state management.

 ******
🧠 State Management :- 

The app uses Cubit (from Bloc) for state management.

Example:
class TaskCubit extends Cubit<List<Task>> {
  TaskCubit() : super([]);

  void addTask(String title) {
    final newTask = Task(title: title);
    emit([...state, newTask]);
  }

  void toggleTask(int index) {
    state[index].isDone = !state[index].isDone;
    emit([...state]);
  }
}
 *******
🛠 Technologies Used :-
Flutter
Dart
Cubit (Bloc)
MVVM Architecture

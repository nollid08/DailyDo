import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

final taskListProvider = StateNotifierProvider<TaskList, List<Task>>((ref) {
  return TaskList(const [
    Task(id: 'task-0', title: 'Buy Porridge'),
    Task(id: 'task-1', title: 'Cook Dinner'),
    Task(id: 'task-2', title: 'Book Train'),
  ]);
});

/// A read-only title of a task-item
@immutable
class Task {
  const Task({
    required this.title,
    required this.id,
    this.completed = false,
  });

  final String id;
  final String title;
  final bool completed;

  @override
  String toString() {
    return 'Task(title: $title, completed: $completed)';
  }
}

/// An object that controls a list of [Task].
class TaskList extends StateNotifier<List<Task>> {
  TaskList([List<Task>? initialTasks]) : super(initialTasks ?? []);

  void add(String title) {
    state = [
      ...state,
      Task(
        id: _uuid.v4(),
        title: title,
      ),
    ];
  }

  void toggle(String id) {
    state = [
      for (final task in state)
        if (task.id == id)
          Task(
            id: task.id,
            completed: !task.completed,
            title: task.title,
          )
        else
          task,
    ];
  }

  void edit({required String id, required String title}) {
    state = [
      for (final task in state)
        if (task.id == id)
          Task(
            id: task.id,
            completed: task.completed,
            title: title,
          )
        else
          task,
    ];
  }

  void remove(Task target) {
    state = state.where((task) => task.id != target.id).toList();
  }
}

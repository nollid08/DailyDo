import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

final taskListProvider = StateNotifierProvider<TaskList, List<Task>>((ref) {
  return TaskList(const [
    Task(
      id: 'task-0',
      title: 'Buy Porridge',
      recursDaily: false,
    ),
    Task(
      id: 'task-1',
      title: 'Cook Dinner',
      recursDaily: true,
    ),
    Task(
      id: 'task-2',
      title: 'Book Train',
      recursDaily: false,
      description:
          'Book the train, leaving after 2:00 from Connolly Station To Mallow',
    ),
  ]);
});

/// A read-only title of a task-item
@immutable
class Task {
  const Task({
    required this.title,
    required this.id,
    required this.recursDaily,
    this.description,
    this.reminder,
    this.completed = false,
  });

  final String id;
  final String title;
  final String? description;
  final TimeOfDay? reminder;
  final bool recursDaily;
  final bool completed;

  @override
  String toString() {
    return 'Task(title: $title, description: $description, reminder: $reminder, recursDaily: $recursDaily completed: $completed)';
  }
}

/// An object that controls a list of [Task].
class TaskList extends StateNotifier<List<Task>> {
  TaskList([List<Task>? initialTasks]) : super(initialTasks ?? []);

  void add(
      {required String title,
      required bool recursDaily,
      String? description,
      TimeOfDay? reminder}) {
    // DEBUG ONLY: Remove var and add directly when print is no longer needed
    Task newTask = Task(
      id: _uuid.v4(),
      title: title,
      recursDaily: recursDaily,
      description: description,
      reminder: reminder,
    );
    print(newTask.toString());
    state = [
      ...state,
      newTask,
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
            recursDaily: task.recursDaily,
          )
        else
          task,
    ];
  }

  void edit(
      {required String id, required String title, required bool recursDaily}) {
    state = [
      for (final task in state)
        if (task.id == id)
          Task(
            id: task.id,
            completed: task.completed,
            title: title,
            recursDaily: recursDaily,
          )
        else
          task,
    ];
  }

  void remove(Task target) {
    state = state.where((task) => task.id != target.id).toList();
  }
}

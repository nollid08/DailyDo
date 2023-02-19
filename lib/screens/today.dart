import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/tasks.dart';
import '../widgets/task_entry.dart';
import '../widgets/task_input.dart';

class Today extends ConsumerWidget {
  const Today({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskList = ref.watch(taskListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DailyDo',
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return TaskEntry(
            title: taskList[index].title,
            recursDaily: taskList[index].recursDaily,
            description: taskList[index].description,
            onAccepted: () => print('Task Completed'),
            onRemoved: () => print('Task Removed'),
          );
        },
        itemCount: taskList.length,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: const SizedBox(height: 350, child: TaskInput()),
              );
            },
          );
        },
      ),
    );
  }
}

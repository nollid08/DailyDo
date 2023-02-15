import 'package:flutter/material.dart';
import '../widgets/task_entry.dart';
import '../widgets/task_input.dart';

class Today extends StatelessWidget {
  const Today({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DailyDo',
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          TaskEntry(
            title: 'Buy Porridge',
            onAccepted: () => print('Task Completed'),
            onRemoved: () => print('Task Removed'),
          ),
          TaskEntry(
            title: 'Cook Dinner',
            onAccepted: () => print('Task Completed'),
            onRemoved: () => print('Task Removed'),
          ),
          TaskEntry(
            title: 'Visit Nana',
            onAccepted: () => print('Task Completed'),
            onRemoved: () => print('Task Removed'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        showModalBottomSheet<void>(
          // context and builder are
          // required properties in this widget
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            // we set up a container inside which
            // we create center column and display text

            // Returning SizedBox instead of a Container
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: const SizedBox(height: 200, child: TaskInput()),
            );
          },
        );
      }),
    );
  }
}

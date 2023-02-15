import 'package:flutter/material.dart';
import '../widgets/task_entry.dart';

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
        ));
  }
}

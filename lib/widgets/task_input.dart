// Create a Form widget.
import 'package:daily_do/controllers/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskInput extends ConsumerWidget {
  TaskInput({super.key});

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<TaskInputState>.
  final _formKey = GlobalKey<FormState>();
  // Create a text controller to use it to retrieve the current value
  // of the TextField.
  final taskTitleController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextFormField(
                controller: taskTitleController,
                autofocus: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your task',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a task!';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ref
                        .read(taskListProvider.notifier)
                        .add(taskTitleController.text);
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Create a Form widget.
import 'package:daily_do/controllers/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskInput extends ConsumerStatefulWidget {
  const TaskInput({Key? key}) : super(key: key);
  @override
  TaskInputState createState() => TaskInputState();
}

class TaskInputState extends ConsumerState<TaskInput> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<TaskInputState>.
  final _formKey = GlobalKey<FormState>();
  // Create a text controller to use it to retrieve the current value
  // of the TextField.
  final taskTitleController = TextEditingController();
  final taskDescriptionController = TextEditingController();

  bool isDaily = true;

  String? validatorForMissingFields(String? input) {
    if (input == null || input.isEmpty || input.trim().isEmpty) {
      return "Mandatory field";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
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
                      validator: validatorForMissingFields),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print(taskDescriptionController.text.isNotEmpty);
                        ref.read(taskListProvider.notifier).add(
                              title: taskTitleController.text,
                              recursDaily: isDaily,
                              description:
                                  taskDescriptionController.text.isNotEmpty
                                      ? taskDescriptionController.text
                                      : null,
                            );
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: taskDescriptionController,
                    keyboardType: TextInputType.multiline,
                    minLines: 8, //Normal textInputField will be displayed
                    maxLines: 8, // when user presses enter it will adapt to it
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Details',
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    SwitchListTile(
                      title: const Text('Daily'),
                      value: isDaily,
                      onChanged: (bool? value) {
                        setState(() {
                          isDaily = value ?? false;
                        });
                      },
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

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

  bool recursDaily = true;
  TimeOfDay? reminder;

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
                              recursDaily: recursDaily,
                              description:
                                  taskDescriptionController.text.isNotEmpty
                                      ? taskDescriptionController.text
                                      : null,
                              reminder: reminder,
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
                      value: recursDaily,
                      onChanged: (bool? value) {
                        setState(() {
                          recursDaily = value ?? false;
                        });
                      },
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        reminder = await showTimePicker(
                          initialTime: TimeOfDay.now(),
                          context: context,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Icon(Icons.notification_add,
                              color: Colors.white),
                          Text(reminder != null
                              ? reminder!.format(context)
                              : 'Add A Reminder')
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        DateTime? scheduleDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.utc(
                            DateTime.now().year + 5,
                            DateTime.now().month,
                            DateTime.now().day,
                          ),
                        );
                        print(scheduleDate);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Icon(Icons.send, color: Colors.white),
                          Text('Schedule')
                        ],
                      ),
                    ),
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

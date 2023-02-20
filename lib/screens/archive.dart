import 'package:daily_do/screens/today.dart';

import '../widgets/archive_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/tasks.dart';
import 'package:intl/intl.dart';
import '../widgets/task_input.dart';

class Archive extends ConsumerWidget {
  const Archive({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final archivedTaskLists = ref.watch(archivedTaskListsProvider);
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: const Text("Today's Tasks"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Today(),
                  ),
                );
                ;
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.archive,
              ),
              enabled: false,
              title: const Text('Archive'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Archive(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'DailyDo',
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          DateTime date = archivedTaskLists[index].date;
          final DateFormat formatter = DateFormat.yMMMMd();
          String formattedDate = formatter.format(date);
          return ArchiveEntry(
            title: formattedDate,
          );
        },
        itemCount: archivedTaskLists.length,
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

import 'package:flutter/material.dart';

class TaskEntry extends StatelessWidget {
  const TaskEntry({
    super.key,
    required this.title,
    required this.recursDaily,
    required this.description,
    required this.onAccepted,
    required this.onRemoved,
  });

  final String title;
  final String? description;
  final bool recursDaily;
  final VoidCallback onAccepted;
  final VoidCallback onRemoved;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.cancel,
                    ),
                    padding: EdgeInsetsDirectional.zero,
                    iconSize: 50,
                    color: Colors.red,
                    onPressed: onRemoved,
                    alignment: AlignmentDirectional.center,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(10),
                      backgroundColor: Colors.orange, // <-- Button color
                      foregroundColor: Colors.orangeAccent, // <-- Splash color
                    ),
                    child: const Icon(Icons.send, color: Colors.white),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.check_circle,
                    ),
                    padding: EdgeInsetsDirectional.zero,
                    iconSize: 50,
                    color: Colors.green,
                    onPressed: onAccepted,
                    alignment: AlignmentDirectional.center,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

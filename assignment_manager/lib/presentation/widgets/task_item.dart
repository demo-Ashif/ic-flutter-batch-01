import 'package:assignment_manager/data/models/task_item.dart';
import 'package:flutter/material.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({super.key, this.taskItem});

  final TaskItem? taskItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              '${taskItem?.title}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
             Text(
              '${taskItem?.description}',
            ),
            Row(
              children: [
                Chip(label: Text('${taskItem?.status.toUpperCase()}')),
                const Spacer(),
                IconButton(onPressed: (){}, icon: const Icon(Icons.edit)),
                IconButton(onPressed: (){}, icon: const Icon(Icons.delete)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

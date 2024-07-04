import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskCounterCard extends StatelessWidget {
  const TaskCounterCard({
    super.key,
    required this.status,
    required this.count,
  });

  final String status;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$count',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$status'.toUpperCase(),
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            )
          ],
        ),
      ),
    );
  }
}

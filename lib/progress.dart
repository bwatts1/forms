import 'package:flutter/material.dart';

class ProgressTracker extends StatelessWidget {
  final double progress;
  final String message;

  const ProgressTracker({super.key, required this.progress, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(
          value: progress,
          color: Colors.purple,
          backgroundColor: Colors.purple[50],
        ),
        const SizedBox(height: 8),
        Text(
          message,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
      ],
    );
  }
}

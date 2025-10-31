import 'package:flutter/material.dart';

class ProgressTracker extends StatelessWidget {
  final double progress;

  const ProgressTracker({super.key, required this.progress});

  Color _getProgressColor(double progress) {
    if (progress <= 0.25) return Colors.red;
    if (progress <= 0.5) return Colors.orange;
    if (progress <= 0.75) return Colors.amber;
    return Colors.green;
  }

  String _getMessage() {
    if (progress >= 1.0) return "🎉 Ready for adventure!";
    if (progress >= 0.75) return "Almost done!";
    if (progress >= 0.5) return "Halfway there!";
    if (progress >= 0.25) return "Great start!";
    return "Let's begin!";
  }

  @override
  Widget build(BuildContext context) {
    final color = _getProgressColor(progress);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: progress),
            duration: const Duration(milliseconds: 300),
            builder: (context, value, _) => LinearProgressIndicator(
              value: value,
              minHeight: 10,
              backgroundColor: Colors.purple[100],
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _getMessage(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}

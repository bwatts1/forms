import 'package:flutter/material.dart';

class PasswordStrengthChecker extends StatefulWidget {
  final Function(String, double) onChanged;

  const PasswordStrengthChecker({super.key, required this.onChanged});

  @override
  State<PasswordStrengthChecker> createState() =>
      _PasswordStrengthCheckerState();
}

class _PasswordStrengthCheckerState extends State<PasswordStrengthChecker> {
  double _strength = 0.0;
  Color _color = Colors.red;

  void _check(String password) {
    double s = 0;
    if (password.isNotEmpty) s += 0.25;
    if (password.length > 6) s += 0.25;
    if (RegExp(r'[A-Z]').hasMatch(password)) s += 0.25;
    if (RegExp(r'[0-9]').hasMatch(password)) s += 0.25;

    setState(() {
      _strength = s;
      _color = s <= 0.25
          ? Colors.red
          : s <= 0.5
              ? Colors.orange
              : s <= 0.75
                  ? Colors.yellow
                  : Colors.green;
    });
    widget.onChanged(password, s);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          obscureText: true,
          onChanged: _check,
          decoration: const InputDecoration(labelText: 'Enter Password'),
        ),
        const SizedBox(height: 10),
        LinearProgressIndicator(
          value: _strength,
          color: _color,
          backgroundColor: Colors.grey[300],
        ),
      ],
    );
  }
}

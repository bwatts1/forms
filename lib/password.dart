import 'package:flutter/material.dart';

class PasswordStrengthChecker extends StatefulWidget {
  @override
  _PasswordStrengthCheckerState createState() => _PasswordStrengthCheckerState();
}

class _PasswordStrengthCheckerState extends State<PasswordStrengthChecker> {
  double _passwordStrength = 0.0;
  Color _strengthColor = Colors.red;

  void _checkPasswordStrength(String password) {
    double strength = 0;
    if (password.isNotEmpty) strength += 0.25;
    if (password.length > 6) strength += 0.25;
    if (RegExp(r'[A-Z]').hasMatch(password)) strength += 0.25;
    if (RegExp(r'[0-9]').hasMatch(password)) strength += 0.25;

    setState(() {
      _passwordStrength = strength;
      if (strength <= 0.25) {
        _strengthColor = Colors.red;
      } else if (strength <= 0.5) {
        _strengthColor = Colors.orange;
      } else if (strength <= 0.75) {
        _strengthColor = Colors.yellow;
      } else {
        _strengthColor = Colors.green;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Password Strength Checker')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: _checkPasswordStrength,
              decoration: InputDecoration(labelText: 'Enter Password'),
            ),
            SizedBox(height: 20),
            LinearProgressIndicator(
              value: _passwordStrength,
              color: _strengthColor,
              backgroundColor: Colors.grey[300],
            ),
          ],
        ),
      ),
    );
  }
}

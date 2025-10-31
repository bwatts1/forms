import 'package:flutter/material.dart';
import 'success.dart';
import 'widgets/progress.dart';
import 'widgets/password.dart';
import 'widgets/badge.dart';
import 'widgets/avatar.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _email;
  String? _password;
  String? _selectedAvatar;
  double _progress = 0.0;
  double _passwordStrength = 0.0;

  void _updateProgress() {
    int filled = 0;
    if (_name?.isNotEmpty ?? false) filled++;
    if (_email?.isNotEmpty ?? false) filled++;
    if (_password?.isNotEmpty ?? false) filled++;
    if (_selectedAvatar != null) filled++;
    setState(() {
      _progress = filled / 4;
    });
  }

  void _onPasswordChanged(String password, double strength) {
    setState(() {
      _password = password;
      _passwordStrength = strength;
      _updateProgress();
    });
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      final badges = generateBadges(_passwordStrength, DateTime.now(), _progress);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SuccessScreen(
            name: _name!,
            avatar: _selectedAvatar!,
            badges: badges,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Signup Adventure")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          onChanged: _updateProgress,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProgressTracker(progress: _progress),
              const SizedBox(height: 20),
              AvatarSelector(onAvatarSelected: (avatar) {
                _selectedAvatar = avatar;
                _updateProgress();
              }),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: (v) => _name = v,
                validator: (v) => v!.isEmpty ? "Please enter your name" : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                onChanged: (v) => _email = v,
                validator: (v) => v!.contains('@') ? null : "Invalid email",
              ),
              PasswordStrengthChecker(onChanged: _onPasswordChanged),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _onSubmit,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                child: const Text("Complete Signup!"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

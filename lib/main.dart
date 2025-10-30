import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fun Signup App',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const SignupPage(),
    );
  }
}

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  String? _selectedAvatar;
  final List<String> _avatars = ['😊', '🚀', '🐱', '🎉', '👑'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Us Today for the Cash Money!'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Create Your Account',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                // Name
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Please enter your name' : null,
                ),
                const SizedBox(height: 16),

                // Email
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Password
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Confirm Password
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Avatar Picker
                const Text(
                  'Pick an Avatar:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 10,
                  children: _avatars.map((avatar) {
                    final isSelected = _selectedAvatar == avatar;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedAvatar = avatar;
                        });
                      },
                      child: CircleAvatar(
                        radius: isSelected ? 30 : 25,
                        backgroundColor:
                            isSelected ? Colors.purple[100] : Colors.grey[200],
                        child: Text(
                          avatar,
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),

                // Signup Button
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (_selectedAvatar == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select an avatar!'),
                              backgroundColor: Colors.orange,
                            ),
                          );
                          return;
                        }

                        // Navigate to welcome screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WelcomeScreen(
                              name: _nameController.text,
                              avatar: _selectedAvatar!,
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  final String name;
  final String avatar;

  const WelcomeScreen({super.key, required this.name, required this.avatar});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  bool _showMessage = false;
  final Random _random = Random();
  final List<Color> _confettiColors = [
    Colors.pink,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.orange,
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _scaleAnimation =
        Tween<double>(begin: 0.8, end: 1.0).animate(_controller);

    _controller.forward();

    // Simulate a short delay before showing welcome message
    Timer(const Duration(seconds: 3), () {
      setState(() {
        _showMessage = true;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Simple built-in confetti effect (no package)
  Widget _buildConfetti() {
    return Stack(
      children: List.generate(20, (index) {
        final double top = _random.nextDouble() * MediaQuery.of(context).size.height / 1.5;
        final double left = _random.nextDouble() * MediaQuery.of(context).size.width;
        final Color color = _confettiColors[_random.nextInt(_confettiColors.length)];

        return Positioned(
          top: top,
          left: left,
          child: Icon(
            Icons.circle,
            color: color.withOpacity(0.7),
            size: 8 + _random.nextDouble() * 10,
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: Stack(
        children: [
          if (!_showMessage) _buildConfetti(), // Confetti before message
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: _showMessage
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.avatar,
                            style: const TextStyle(fontSize: 64),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Welcome, ${widget.name}!',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                          ),
                        ],
                      )
                    : const Text(
                        '🎉 Loading your celebration...',
                        style: TextStyle(fontSize: 20, color: Colors.purple),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

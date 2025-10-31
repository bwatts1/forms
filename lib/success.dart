import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class SuccessScreen extends StatefulWidget {
  final String name;
  final String avatar;
  final List<String> badges;

  const SuccessScreen({
    super.key,
    required this.name,
    required this.avatar,
    required this.badges,
  });

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  late ConfettiController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: const Duration(seconds: 3));
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(radius: 50, backgroundImage: AssetImage(widget.avatar)),
                const SizedBox(height: 20),
                Text("Welcome, ${widget.name}!",
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    )),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  children: widget.badges
                      .map((b) => Chip(label: Text(b)))
                      .toList(),
                ),
              ],
            ),
          ),
          ConfettiWidget(confettiController: _controller, blastDirectionality: BlastDirectionality.explosive),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AvatarSelector extends StatefulWidget {
  final void Function(String) onAvatarSelected;

  const AvatarSelector({super.key, required this.onAvatarSelected});

  @override
  State<AvatarSelector> createState() => _AvatarSelectorState();
}

class _AvatarSelectorState extends State<AvatarSelector> {
  final List<String> _avatars = [
    'images/avatar1.jpg',
    'images/avatar2.jpg',
    'images/avatar3.jpg',
  ];

  String? _selected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Choose Your Avatar",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.purple,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 12,
          children: _avatars.map((path) {
            final bool isSelected = path == _selected;
            return GestureDetector(
              onTap: () {
                setState(() => _selected = path);
                widget.onAvatarSelected(path);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? Colors.purple : Colors.transparent,
                    width: 3,
                  ),
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.purple[50],
                  backgroundImage: AssetImage(path),
                  onBackgroundImageError: (_, __) {
                    debugPrint('⚠️ Could not load $path');
                  },
                  child: Image.asset(
                    path,
                    errorBuilder: (context, error, stack) {
                      return const Icon(Icons.person, size: 35, color: Colors.grey);
                    },
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class CircleInfo extends StatelessWidget {
  final String value;
  final String label;
  const CircleInfo({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                value: 0.8,
                strokeWidth: 6,
                backgroundColor: Colors.white12,
                valueColor: const AlwaysStoppedAnimation(Colors.blueAccent),
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }
}

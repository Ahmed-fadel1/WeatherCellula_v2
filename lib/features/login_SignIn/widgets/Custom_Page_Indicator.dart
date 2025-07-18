import 'package:flutter/material.dart';

class CustomPageIndicator extends StatelessWidget {
  final int currentIndex;
  const CustomPageIndicator({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                index == currentIndex
                    ? Colors.white
                    : Colors.white.withOpacity(0.2),
          ),
        );
      }),
    );
  }
}

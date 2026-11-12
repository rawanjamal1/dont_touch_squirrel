import 'package:flutter/material.dart';

class Game extends StatelessWidget {
  final int acorn;
  final int squirrel;
  final Function(int) onTap;

  const Game({
    super.key,
    required this.acorn,
    required this.squirrel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 16,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        String item = '';

        if (index == acorn) {
          item = '🌰';
        } else if (index == squirrel) {
          item = '🐿️';
        }

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            onTap(index);
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFF754727),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFA87645),
                width: 4,
              ),
            ),
            child: Text(
              item,
              style: const TextStyle(
                fontSize: 32,
              ),
            ),
          ),
        );
      },
    );
  }
}

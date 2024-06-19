import 'package:flutter/material.dart';

class TutorialOverlay extends StatelessWidget {
  final String title;
  final String description;
  final Rect target;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const TutorialOverlay({
    super.key,
    required this.title,
    required this.description,
    required this.target,
    required this.onNext,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: onNext,
          child: Container(
            color: Colors.black54,
          ),
        ),
        Positioned(
          left: target.left,
          top: target.top,
          child: Material(
            elevation: 4.0,
            color: Colors.transparent,
            child: Container(
              width: target.width,
              height: target.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
        ),
        Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text(description, style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: onSkip, child: const Text("Skip")),
                    TextButton(onPressed: onNext, child: const Text("Next")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TutorialStep {
  final String title;
  final String description;
  final GlobalKey key;

  TutorialStep({
    required this.title,
    required this.description,
    required this.key,
  });
}

class SpotlightOverlay extends StatelessWidget {
  final Rect target;
  final VoidCallback onNext;
  final VoidCallback onSkip;
  final String title;
  final String description;

  const SpotlightOverlay({
    super.key,
    required this.target,
    required this.onNext,
    required this.onSkip,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            color: Colors.black54,
          ),
        ),
        Positioned(
          left: target.left,
          top: target.top,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: target.width,
              height: target.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
        ),
        Positioned(
          top: target.bottom + 16,
          left: target.left,
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              width: target.width,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(description, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed: onSkip, child: const Text("Skip")),
                      TextButton(onPressed: onNext, child: const Text("Next")),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

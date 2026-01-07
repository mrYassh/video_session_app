import 'package:flutter/material.dart';

class SelfCameraPreview extends StatelessWidget {
  const SelfCameraPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.black,
      ),
      child: const Center(
        child: Icon(
          Icons.videocam,
          color: Colors.white70,
          size: 48,
        ),
      ),
    );
  }
}

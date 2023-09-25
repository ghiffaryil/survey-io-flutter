import 'package:flutter/material.dart';

class RoundedImage extends StatelessWidget {
  final String imageUrl;
  final double borderRadius;

  RoundedImage({
    required this.imageUrl,
    this.borderRadius = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.asset(imageUrl),
    );
  }
}

class RoundedImageNetwork extends StatelessWidget {
  final String imageUrl;
  final double borderRadius;

  RoundedImageNetwork({
    required this.imageUrl,
    this.borderRadius = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.network(imageUrl),
    );
  }
}

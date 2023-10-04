import 'package:flutter/material.dart';

class RoundedImageNetwork extends StatelessWidget {
  final String imageUrl;
  final double borderRadius;
  final BoxFit fit; // Add this parameter
  final double width; // Add this parameter
  final double height; // Add this parameter

  const RoundedImageNetwork({
    super.key,
    required this.imageUrl,
    this.borderRadius = 10.0,
    this.fit = BoxFit.contain, // Default value for fit
    this.width = 200, // Default value for fit
    this.height = 200, // Default value for fit
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.network(imageUrl, fit: fit, width: width, height: height),
    );
  }
}

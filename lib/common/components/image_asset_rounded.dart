import 'package:flutter/material.dart';

class RoundedImageAsset extends StatelessWidget {
  final String imageUrl;
  final double borderRadius;
  final BoxFit fit; // Add this parameter
  final double width; // Add this parameter
  final double height; // Add this parameter

  const RoundedImageAsset({super.key, 
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
      child: Image.asset(imageUrl, fit: fit, width: width, height: height),
    );
  }
}
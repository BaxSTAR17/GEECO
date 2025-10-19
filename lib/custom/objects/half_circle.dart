import 'package:flutter/material.dart';

/// Reusable circular widget with configurable size, color, border and shadow.
class CustomCircle extends StatelessWidget {
  const CustomCircle({
    super.key,
    this.diameter = 64.0,
    this.color = const Color(0xFF8FD85F),
    this.borderColor = Colors.transparent,
    this.borderWidth = 0.0,
    this.elevation = 0.0,
    this.child,
  });

  final double diameter;
  final Color color;
  final Color borderColor;
  final double borderWidth;
  final double elevation;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: borderColor, width: borderWidth),
        boxShadow: elevation > 0
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: elevation,
                  offset: Offset(0, elevation / 2),
                ),
              ]
            : null,
      ),
      child: child,
    );
  }
}

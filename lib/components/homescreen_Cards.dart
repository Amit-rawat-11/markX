import 'package:flutter/material.dart';
import 'package:mark_x/constant/colors.dart';

class HomescreenCards extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;

  const HomescreenCards({
    super.key,
    required this.height,
    required this.width,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 3,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: MXColors.card,
        ),
        height: height,
        width: width,
        child: Padding(padding: const EdgeInsets.all(16.0), child: child),
      ),
    );
  }
}

class TransparentCard extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;

  const TransparentCard({
    super.key,
    required this.height,
    required this.width,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.transparent,
        ),
        height: height,
        width: width,
        child: Padding(padding: const EdgeInsets.all(0.0), child: child),
      ),
    );
  }
}

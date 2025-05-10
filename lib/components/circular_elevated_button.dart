import 'package:flutter/material.dart';
import 'package:mark_x/constant/colors.dart';

class CircularElevatedButton extends StatelessWidget {
  final VoidCallback? onpressed;
  final IconData iconData;

  const CircularElevatedButton({
    super.key,
    required this.onpressed,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 45,
      child: ElevatedButton(
        onPressed: onpressed,
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          // backgroundColor: const Color.fromARGB(137, 237, 231, 246),
          backgroundColor: const Color.fromARGB(204, 237, 231, 246),
          foregroundColor: MXColors.text,
          elevation: 0,
          padding: EdgeInsets.zero, // ✅ Removes unwanted internal padding
        ),
        child: Center(child: Icon(iconData, size: 24.0, color: MXColors.text)),
      ),
    );
  }
}

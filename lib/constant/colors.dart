import 'package:flutter/material.dart';

class MXColors {
  static const Color primary = Color(0xFF339FA3);
  static const Color secondary = Color(0xFFF7FFF7);
  static const Color accent = Color(0xFF1A535C);
  static const Color background = Color(0xFFEDE7F6);
  static const Color card = Color(0xFFDCC4FF);
  static const Color background2 = Color(0xFFC38EB4); //Background & Background2 make the background gradient combined 
  static const Color text = Color(0xFF1A1A1A);
  static const Color progressbar = Color(0xFF2D9CDB); //Accent color for text
  // static const Color text = Colors.deepOrange;

 //Background & Background2 make the background gradient combined 
}

class GRBackground {
  static const BoxDecoration grbackground = BoxDecoration(
    gradient: LinearGradient(
      colors: [MXColors.background, MXColors.background2],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );

}

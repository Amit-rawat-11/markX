import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mark_x/constant/colors.dart'; // Import MXColors
import 'package:google_fonts/google_fonts.dart'; // Import GoogleFonts

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,

  // ✅ Default Text Theme using Lora font globally
  textTheme: TextTheme(
    displayLarge: GoogleFonts.lora(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: MXColors.text,
    ), // Heading
    bodyLarge: GoogleFonts.lora(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: MXColors.text,
    ), // Body text
    bodyMedium: GoogleFonts.lora(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: MXColors.text,
    ), // Bold body text
    bodySmall: GoogleFonts.lora(
      fontSize: 13,
      fontWeight: FontWeight.normal,
      color: MXColors.text,
    ), // Small text
    titleMedium: GoogleFonts.lora(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: MXColors.text,
    ), // Info text
    labelLarge: GoogleFonts.lora(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: MXColors.text,
    ), // Button text
  ),

  // ✅ AppBar Theme with custom text and icon color
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,

    iconTheme: IconThemeData(
      color: MXColors.text,
    ), // Icon color from MXColors.text
    titleTextStyle: GoogleFonts.lora(
      color: MXColors.text, // Title text color from MXColors.text
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Makes status bar transparent
      statusBarIconBrightness: Brightness.dark, // White icons (for dark bg)
      statusBarBrightness: Brightness.light,

      // For iOS
    ),
  ),

  scaffoldBackgroundColor: MXColors.background,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: MXColors.background2,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    ),
  ),
);

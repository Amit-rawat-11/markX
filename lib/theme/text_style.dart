import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mark_x/constant/colors.dart';

class MXTextStyles {
  static final TextStyle heading = GoogleFonts.lora(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: MXColors.text,
  );

  static final TextStyle body = GoogleFonts.lora(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: MXColors.text,
  );

  static final TextStyle bodyBold = GoogleFonts.lora(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: MXColors.text,
  );

  static final TextStyle small = GoogleFonts.lora(
    fontSize: 13,
    fontWeight: FontWeight.normal,
    color: MXColors.text,
  );

  static final TextStyle info = GoogleFonts.lora(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: MXColors.text,
  );

  static final TextStyle button = GoogleFonts.lora(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: MXColors.text,
  );
}

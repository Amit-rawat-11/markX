// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:mark_x/constant/colors.dart';
import 'package:mark_x/theme/text_style.dart';

class RecentEntryCard extends StatelessWidget {
  final String text;
  final String subtitle;
  final int? height;
  final int? width;
  final TextStyle? textStyle;
  const RecentEntryCard({
    super.key,
    required this.text,
    required this.subtitle,
    this.height,
    this.width,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width?.toDouble(),
      height: height?.toDouble(),
      child: Padding(
        padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
        child: Card(
          elevation: 2,
          color: MXColors.card,
          child: ListTile(
            title: Text(
              text,
              style: textStyle ?? MXTextStyles.bodyBold,
              // textAlign: TextAlign.center,
            ),
            subtitle: Text(subtitle, style: MXTextStyles.body, maxLines: 5),
          ),
        ),
      ),
    );
  }
}

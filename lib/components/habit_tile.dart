import 'package:flutter/material.dart';
import 'package:mark_x/constant/colors.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final bool habitCompleted;
  final Function(bool?)? onChanged;
  final double? habitProgress;
  final String habitPriority;
  const HabitTile({
    required this.habitName,
    required this.habitCompleted,
    required this.habitPriority,
    this.habitProgress,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Container(
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: MXColors.background,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Transform.scale(
              scale: 1.2,
              child: Checkbox(value: habitCompleted, onChanged: onChanged),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.55,
              child: Text(
                habitName,
                style: TextStyle(fontSize: 18),
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.visible,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 70,
              height: 40,
              child: Chip(label: Text(habitPriority!)),
              // child: CircularPercentIndicator(
              //   radius: 20,
              //   percent: habitProgress!.isZero ? 50/100 : habitProgress! / 100 ,
              //   lineWidth: 8,
              //   progressColor: MXColors.progressbar,
              //   backgroundColor: MXColors.card,
              //   animation: true,
              //   animationDuration: 3000,
              //   circularStrokeCap: CircularStrokeCap.round,
              // ),
            ),
          ],
        ),
      ),
    );
  }
}

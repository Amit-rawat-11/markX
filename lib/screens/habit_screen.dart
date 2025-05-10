import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:mark_x/components/habit_tile.dart';
import 'package:mark_x/constant/datetime.dart';
import 'package:mark_x/data/sample_habit.dart';
import 'package:intl/intl.dart';

class HabitScreen extends StatefulWidget {
  const HabitScreen({super.key});

  @override
  State<HabitScreen> createState() => _HabitScreenState();
}

class _HabitScreenState extends State<HabitScreen> {
  // Generate heatmap data based on habit completion dates
  Map<DateTime, int> generateHeatmapData() {
    Map<DateTime, int> heatmap = {};
    for (var habit in demohabits) {
      for (var date in habit.completedDates) {
        final normalizedDate = DateTime(date.year, date.month, date.day);
        heatmap.update(normalizedDate, (value) => value + 1, ifAbsent: () => 1);
      }
    }
    return heatmap;
  }

  // Handle checkbox change for habit completion
  void checkboxChanged(bool? value, int index) {
    setState(() {
      demohabits[index].isCompleted = value!;
      final today = DateTime.now();
      final normalizedToday = DateTime(today.year, today.month, today.day);

      // Update the completedDates list based on checkbox value
      if (value) {
        if (!demohabits[index].completedDates.contains(normalizedToday)) {
          demohabits[index].completedDates.add(normalizedToday);
        }
      } else {
        demohabits[index].completedDates.remove(normalizedToday);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final heatmapData = generateHeatmapData();

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(TimeUtils.formattedDate),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            // HeatMapCalendar to visualize the habit completion status
            HeatMapCalendar(
              datasets: heatmapData,
              colorMode: ColorMode.color,
              monthFontSize: 16,
              showColorTip: false,
              weekTextColor: Colors.grey,
              colorsets: {
                0: Colors.deepPurple[100]!,
                2: Colors.deepPurple[200]!,
                3: Colors.deepPurple[300]!,
                4: Colors.deepPurple[400]!,
                5: Colors.deepPurple[500]!,
                6: Colors.deepPurple[600]!,
                7: Colors.deepPurple[700]!,
                8: Colors.deepPurple[800]!,
                9: Colors.deepPurple[900]!,
              },
              onClick: (value) {
                print("Selected date is $value");
              },
            ),
            // ListView for habit tiles (completed status, progress)
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: demohabits.length,
              itemBuilder: (context, index) {
                return HabitTile(
                  habitName: demohabits[index].title,
                  habitCompleted: demohabits[index].completedDates.contains(
                    DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                    ),
                  ),
                  onChanged: (value) => checkboxChanged(value, index),
                  habitProgress: demohabits[index].progress,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

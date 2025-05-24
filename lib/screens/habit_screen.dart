import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:mark_x/components/habit_alert.dart';
import 'package:mark_x/components/habit_tile.dart';
import 'package:mark_x/constant/datetime.dart';
import 'package:mark_x/firebase/firestore_Service.dart';
import 'package:mark_x/models/habit.dart';

class HabitScreen extends StatefulWidget {
  const HabitScreen({super.key});

  @override
  State<HabitScreen> createState() => _HabitScreenState();
}

class _HabitScreenState extends State<HabitScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  List<Habit> habits = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHabits();
  }

  Future<void> _loadHabits() async {
    setState(() => isLoading = true);
    final fetchedHabits = await _firestoreService.fetchHabits();
    setState(() {
      habits = fetchedHabits;
      isLoading = false;
    });
  }

  // Generate heatmap data based on habit completion dates
  Map<DateTime, int> generateHeatmapData() {
    Map<DateTime, int> heatmap = {};
    for (var habit in habits) {
      for (var date in habit.completedDates) {
        final normalizedDate = DateTime(date.year, date.month, date.day);
        heatmap.update(normalizedDate, (value) => value + 1, ifAbsent: () => 1);
      }
    }
    return heatmap;
  }

  // Handle checkbox change for habit completion and update Firestore
  void checkboxChanged(bool? value, int index) async {
    if (value == null) return;
    final habit = habits[index];
    final today = DateTime.now();
    final normalizedToday = DateTime(today.year, today.month, today.day);

    setState(() {
      habit.isCompleted = value;
      if (value) {
        if (!habit.completedDates.contains(normalizedToday)) {
          habit.completedDates.add(normalizedToday);
        }
      } else {
        habit.completedDates.remove(normalizedToday);
      }
    });

    habit.lastUpdated = DateTime.now();

    if (habit.id != null) {
      await _firestoreService.updateHabit(habit.id!, habit);
    }
  }

  void _showAddHabitDialog() async {
    final result = await showDialog<Habit>(
  context: context,
  builder: (context) => const AddHabitDialog(),
);
    if (result != null ) {
      await _firestoreService.addHabits(result);
      setState(() {
        _loadHabits(); // refresh
      });
    }
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
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: _showAddHabitDialog),
        ],
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: [
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
                  if (habits.isEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "You have no habits yet.\nSwipe to remove. Tap + to add.",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    
                  ] else
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: habits.length,
                      itemBuilder: (context, index) {
                        final habit = habits[index];

                        return Dismissible(
                          key: Key(habit.id ?? habit.title),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            alignment: Alignment.centerRight,
                            color: Colors.red,
                            child: const Icon(Icons.delete, color: Colors.white),
                          ),
                          confirmDismiss: (direction) async {
                            return await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Delete Habit"),
                                content: const Text("Are you sure you want to delete this habit?"),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(false),
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(true),
                                    child: const Text("Delete", style: TextStyle(color: Colors.red)),
                                  ),
                                ],
                              ),
                            );
                          },
                          onDismissed: (direction) async {
                            if (habit.id != null) {
                              await _firestoreService.deleteHabit(habit.id!);
                            }

                            setState(() {
                              habits.removeAt(index);
                            });
                          },
                          child: HabitTile(
                            habitName: habit.title,
                            habitCompleted: habit.completedDates.contains(
                              DateTime(
                                DateTime.now().year,
                                DateTime.now().month,
                                DateTime.now().day,
                              ),
                            ),
                            onChanged: (value) => checkboxChanged(value, index),
                            habitPriority: habit.priority,
                          ),
                        );
                      },
                    ),
                ],
              ),
      ),
    );
  }
}

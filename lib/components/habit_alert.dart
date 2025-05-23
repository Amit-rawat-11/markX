import 'package:flutter/material.dart';
import 'package:mark_x/components/input_textfield.dart';
import 'package:mark_x/constant/colors.dart';
import 'package:mark_x/firebase/firestore_Service.dart';
import 'package:mark_x/models/goal.dart';
import 'package:mark_x/theme/text_style.dart';

class AddHabitDialog extends StatefulWidget {
  const AddHabitDialog({super.key});

  @override
  State<AddHabitDialog> createState() => _AddHabitDialogState();
}

class _AddHabitDialogState extends State<AddHabitDialog> {
  final TextEditingController _habitNameController = TextEditingController();
  final TextEditingController _habitdescController = TextEditingController();
  String Priority = 'Medium';
  @override
  void dispose() {
    _habitNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: MXColors.background,

      title: Text(
        "Add New Habit",
        style: MXTextStyles.bodyBold,
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        height: MediaQuery.of(context).size.height / 3.7,

        width: MediaQuery.of(context).size.width / 1,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputTextfield(
              labelText: 'Habit Name',
              controller: _habitNameController,
              isPassword: false,
            ),
            SizedBox(height: 16),
            InputTextfield(
              labelText: 'Habit Description',
              controller: _habitdescController,
              isPassword: false,
            ),
            SizedBox(height: 18),
            Text(
              "Priority",
              style: MXTextStyles.bodyBold,
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: 'High',
                  groupValue: Priority,
                  onChanged: (value) {
                    setState(() {
                      Priority = value!;
                    });
                  },
                ),
                Text('High', style: MXTextStyles.bodyBold),
                Radio(
                  value: 'Medium',
                  groupValue: Priority,
                  onChanged: (value) {
                    setState(() {
                      Priority = value!;
                    });
                  },
                ),
                Text('Medium', style: MXTextStyles.bodyBold),
                Radio(
                  value: 'Low',
                  groupValue: Priority,
                  onChanged: (value) {
                    setState(() {
                      Priority = value!;
                    });
                  },
                ),

                Text('Low', style: MXTextStyles.bodyBold),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), // close dialog
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            final habitName = _habitNameController.text.trim();
            final habitdesc = _habitdescController.text.trim();

            final newHabit = Habit(
              title: habitName,
              description: habitdesc.isEmpty ? "No description yet" : habitdesc,
              progress: 0.0,
              priority: Priority,
              
              isCompleted: false,
              startDate: DateTime.now(),
              endDate: DateTime.now().add(Duration(days: 30)), // 30 days habit
              lastUpdated: DateTime.now(),
              completedDates: [],
            );

            if (habitName.isNotEmpty) {
              FirestoreService().addHabits(newHabit);
              Navigator.pop(context); // Return habit name
            }
          },
          child: const Text("Add"),
        ),
      ],
    );
  }
}

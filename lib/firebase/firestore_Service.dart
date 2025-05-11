import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mark_x/models/food_item.dart';
import 'package:mark_x/models/goal.dart';
import 'package:mark_x/models/journal.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addJournalEntry(JournalEntry entry) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    try {
      await _db.collection('users').doc(userId).collection('journals').add({
        'title': entry.title,
        'content': entry.content,
        'timestamp': entry.timestamp,
      });
    } catch (e) {
      print("Error saving journal entry: $e");
    }
  }

  Future<void> addHabits(Habit habit) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    try {
      await _db.collection('users').doc(userId).collection('habits').add({
        'title': habit.title,
        'desc': habit.description,
        'start_date': habit.startDate,
        'end_date': habit.endDate,
        'priority': habit.priority,
        'progress': habit.progress,
        'isCompleted': habit.isCompleted,
        'lastUpdated': habit.lastUpdated,
        'completedDates': habit.completedDates,
      });
    } catch (e) {
      print("Error saving habits: $e");
    }
  }

  Future<void> logFood(FoodItem food) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    try {
      await _db.collection('users').doc(userId).collection('foodlogging').add({
        'name': food.name,
        'quantity': food.quantity,
        'calories': food.calories,
        'protein': food.protein,
      });
    } catch (e) {
      print("Error logging food: $e");
      ;
    }
  }
}

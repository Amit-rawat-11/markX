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
      await _db.collection('users').doc(userId).collection('foodloging').add({
        'name': food.name,
        'quantity': food.quantity,
        'calories': food.calories,
        'protein': food.protein,
      });
    } catch (e) {
      print("Error logging food: $e");
    }
  }
}

Future<List<FoodItem>> fetchFoodLogs() async {
  print('Fetching food logs...');
  final userId = FirebaseAuth.instance.currentUser?.uid;
  if (userId == null) {
    print('User not logged in.');
    return [];
  }

  try {
    final querySnapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('foodloging')
            .get();
    print(
      'Query snapshot: ${querySnapshot.docs.length}',
    );

    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      print("Raw Firestore data: $data");

      return FoodItem.fromFirestore(doc);
    }).toList();
  } catch (e, stack) {
    print("Error fetching food logs: $e");
    print(stack);
    return [];
  }
}

void printFoodLogs() async {
  List<FoodItem> foodLogs = await fetchFoodLogs();

  for (var food in foodLogs) {
    print(
      'Food: ${food.name}, Quantity: ${food.quantity}, Calories: ${food.calories}, Protein: ${food.protein}',
    );
  }
}

class FoodLogManager {
  
  // This will store the list of food logs
  List<FoodItem> foodLogs = [];

  // Modify this method to return a Future<List<FoodItem>>
  Future<List<FoodItem>> loadFoodLogs() async {
    // Simulating a delay for fetching data, this can be replaced with actual logic (e.g., Firestore call)
    await Future.delayed(Duration(seconds: 2));

    // For demo purposes, we load some food logs

    return foodLogs;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mark_x/models/food_item.dart';
import 'package:mark_x/models/goal.dart';
import 'package:mark_x/models/journal.dart';// <-- make sure to import Habit model


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

  Future<void> updateJournalEntry(String documentId, JournalEntry entry) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    try {
      await _db
          .collection('users')
          .doc(userId)
          .collection('journals')
          .doc(documentId)
          .update({
            'title': entry.title,
            'content': entry.content,
            'timestamp': entry.timestamp,
          });
    } catch (e) {
      print("Error updating journal entry: $e");
    }
  }

  Future<JournalEntry?> getJournalEntry(String documentId) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return null;

    try {
      final doc =
          await _db
              .collection('users')
              .doc(userId)
              .collection('journals')
              .doc(documentId)
              .get();
      if (doc.exists) {
        final data = doc.data()!;
        return JournalEntry(
          title: data['title'],
          content: data['content'],
          timestamp: (data['timestamp'] as Timestamp).toDate(),
        );
      }
    } catch (e) {
      print("Error fetching journal entry: $e");
    }
    return null;
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

  // New method to fetch habits list
  Future<List<Habit>> fetchHabits() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return [];

    try {
      final querySnapshot = await _db.collection('users').doc(userId).collection('habits').get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return Habit(
          
          title: data['title'] ?? '',
          description: data['desc'] ?? '',
          progress: (data['progress'] ?? 0.0).toDouble(),
          priority: data['priority'] ?? 'Medium',
          isCompleted: data['isCompleted'] ?? false,
          startDate: (data['start_date'] as Timestamp).toDate(),
          endDate: (data['end_date'] as Timestamp).toDate(),
          lastUpdated: (data['lastUpdated'] as Timestamp).toDate(),
          completedDates: (data['completedDates'] as List<dynamic>)
              .map((ts) => (ts as Timestamp).toDate())
              .toList(),
          id: doc.id, // You might want to add an 'id' field in your Habit model for updating
        );
        
      }).toList();
    } catch (e) {
      print('Error fetching habits: $e');
      return [];
    }
  }

  // New method to update habit (pass habit with updated fields and document ID)
  Future<void> updateHabit(String documentId, Habit habit) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    try {
      await _db.collection('users').doc(userId).collection('habits').doc(documentId).update({
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
      print("Error updating habit: $e");
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
    }
  }
}

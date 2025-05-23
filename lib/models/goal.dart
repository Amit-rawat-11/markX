import 'package:cloud_firestore/cloud_firestore.dart';

class Habit {
  final String? id;
  String title;
  String description;
  DateTime startDate;
  DateTime endDate;
  String priority; // <-- changed from int to String
  double progress;
  bool isCompleted;
  DateTime lastUpdated;
  List<DateTime> completedDates;

  Habit({
    this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.priority, // <-- string
    required this.progress,
    required this.isCompleted,
    required this.lastUpdated,
    required this.completedDates,
  });

  factory Habit.fromFirestore(Map<String, dynamic> data, String docId) {
    return Habit(
      id: docId,
      title: data['title'] ?? '',
      description: data['desc'] ?? '',
      startDate: (data['start_date'] as Timestamp).toDate(),
      endDate: (data['end_date'] as Timestamp).toDate(),
      priority: data['priority'] ?? 'Low', // <-- default string
      progress: (data['progress'] ?? 0).toDouble(),
      isCompleted: data['isCompleted'] ?? false,
      lastUpdated: (data['lastUpdated'] as Timestamp).toDate(),
      completedDates: (data['completedDates'] as List<dynamic>?)
              ?.map((d) => (d as Timestamp).toDate())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'desc': description,
      'start_date': startDate,
      'end_date': endDate,
      'priority': priority, // <-- string value
      'progress': progress,
      'isCompleted': isCompleted,
      'lastUpdated': lastUpdated,
      'completedDates': completedDates,
    };
  }
}

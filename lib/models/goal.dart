class Habit {
  String title;
  final String description;
  double progress; // Progress in percentage (0-100)
  final String priority; // "High", "Medium", or "Low"
  bool isCompleted; // Whether the goal is completed
  final DateTime? startDate;
  final DateTime endDate;
  final DateTime lastUpdated;
  List<DateTime> completedDates;

  Habit({
    required this.title,
    required this.description,
    required this.progress,
    required this.priority,
    required this.isCompleted,
    required this.startDate,
    required this.endDate,
    required this.lastUpdated,
    List<DateTime>? completedDates, // Make completedDates optional to allow null safety
  }) : completedDates = completedDates ?? []; // Initialize completedDates as an empty list if not provided
}

import 'package:firebase_auth/firebase_auth.dart';

class FirebasePaths {
  static String get userId => FirebaseAuth.instance.currentUser!.uid;

  // Base user document
  static String get userDoc => 'users/$userId';

  // Subcollections
  static String journalCollection(String uid) => 'users/$uid/journal';
  static String foodCollection(String uid) => 'users/$uid/food';
  static String workoutCollection(String uid) => 'users/$uid/workouts';
  static String habitCollection(String uid) => 'users/$uid/habits';

  // Profile doc inside 'users' collection
  static String profileDoc(String uid) => 'users/$uid/profile';
}

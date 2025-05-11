import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign up function
  Future<String?> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      // Create a new user with email and password
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Optionally, you can update the user's display name (this is not mandatory)
      await userCredential.user?.updateDisplayName(name);

      // Return success message
      final User? user = userCredential.user;

      if (user != null) {
        // Check and create user in Firestore
        final userDoc = _firestore
            .collection('users')
            .doc(user.uid)
            .collection('userData')
            .doc(user.uid);
        final docSnapshot = await userDoc.get();
        if (!docSnapshot.exists) {
          await userDoc.set({
            'email': user.email,
            'name': name,
            'createdAt': FieldValue.serverTimestamp(),
            'lastSignIn': FieldValue.serverTimestamp(),
            'photoURL': '',
            'isGoogleUser': false,
            'isPremium': false,
            'isNewUser': true,
          });
        }
      }
      return null;
    } on FirebaseAuthException catch (e) {
      // Handle Firebase errors
      if (e.code == 'email-already-in-use') {
        return 'This email is already in use.';
      } else if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'invalid-email') {
        return 'The email address is not valid.';
      }
      return e.message; // Other Firebase errors
    } catch (e) {
      return 'An unknown error occurred. Please try again.';
    }
  }
}

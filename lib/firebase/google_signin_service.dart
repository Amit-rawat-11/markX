import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GoogleSignInService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        // Check and create user in Firestore
        final userDoc = _firestore.collection('users').doc(user.uid);
        final docSnapshot = await userDoc.get();
        if (!docSnapshot.exists) {
          await userDoc.set({
            'email': user.email,
            'name': user.displayName,
            'createdAt': FieldValue.serverTimestamp(),
            'lastSignIn': FieldValue.serverTimestamp(),
            'photoURL': user.photoURL,
            'isGoogleUser': true,
            'isPremium': false,
            'isNewUser': true,

          });
        }
      }

      return user;
    } catch (e) {
      print("Google Sign-In Error: $e");
      return null;
    }
  }
}

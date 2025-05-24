import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mark_x/screens/main_screen.dart';
import 'package:mark_x/screens/signup_screen.dart';
import 'package:mark_x/theme/dark_theme.dart';

// Only required if you're manually adding FirebaseOptions
const FirebaseOptions firebaseOptions = FirebaseOptions(
  apiKey: "AIzaSyAcr1fZVqrIwC544BYnYm7j8tZv27Nl_Kg",
  authDomain: "markx-35fec.firebaseapp.com",
  projectId: "markx-35fec",
  storageBucket: "markx-35fec.firebasestorage.app",
  messagingSenderId: "908268878636",
  appId: "1:908268878636:web:53aedb692fd742823c4a89",
  measurementId: "G-610QFPXEQM",
);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Only initialize if no app is already initialized
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(options: firebaseOptions);
    }
  } catch (e) {
    print('Firebase already initialized: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MarkX',
      debugShowCheckedModeBanner: false,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      home: const AuthWrapper(),
    );
  }
}
  
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          return user != null ? MainScreen() : SignupScreen();
        }

        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}

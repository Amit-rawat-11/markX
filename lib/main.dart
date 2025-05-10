import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mark_x/firebase_options.dart';
import 'package:mark_x/screens/auth_screen.dart';
import 'package:mark_x/screens/main_screen.dart';
import 'package:mark_x/theme/dark_theme.dart';
// import 'package:mark_x/theme/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //  theme: lightTheme, // Your custom light theme
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      title: 'MarkX',

      home: AuthScreen(),
      // home: MainScreen(),
    );
  }
}

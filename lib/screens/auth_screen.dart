import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mark_x/firebase/google_signin_service.dart';
import 'package:mark_x/screens/main_screen.dart';

class AuthScreen extends StatelessWidget {
  final GoogleSignInService _googleSignInService = GoogleSignInService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            User? user = await _googleSignInService.signInWithGoogle();
            if (user != null) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => MainScreen()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Login failed')),
              );
            }
          },
          child: Text('Sign in with Google'),
        ),
      ),
    );
  }
}

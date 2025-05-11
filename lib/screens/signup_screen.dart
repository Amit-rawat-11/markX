import 'package:flutter/material.dart';
import 'package:mark_x/components/input_textfield.dart';
import 'package:mark_x/constant/colors.dart';
import 'package:mark_x/firebase/signup_service.dart';
import 'package:mark_x/screens/main_screen.dart'; // Replace with your actual screen

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpassController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmpassController.dispose();
    super.dispose();
  }

  void _handleSignup() async {
    setState(() => isLoading = true);

    final errorMessage = await SignupService().signUp(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    setState(() => isLoading = false);

    if (errorMessage != null) {
      _showError(context, errorMessage);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => MainScreen(),
        ), // Change this screen if needed
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: const Text("Sign Up")),
      body: Container(
        decoration: GRBackground.grbackground,
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InputTextfield(
                    labelText: 'Name',
                    controller: nameController,
                    isPassword: false,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.055),
                  InputTextfield(
                    labelText: 'Email',
                    controller: emailController,
                    isPassword: false,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.055),
                  InputTextfield(
                    labelText: 'Password',
                    controller: passwordController,
                    isPassword: true,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.055),
                  InputTextfield(
                    labelText: 'Confirm Password',
                    controller: confirmpassController,
                    isPassword: true,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.055),
                  isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : SizedBox(
                        width: MediaQuery.of(context).size.width * 0.55,
                        height: MediaQuery.of(context).size.width * 0.12,
                        child: ElevatedButton(
                          onPressed: () {
                            if (nameController.text.isEmpty) {
                              _showError(context, 'Please enter your name.');
                              return;
                            }
                            if (emailController.text.isEmpty) {
                              _showError(context, 'Please enter your email.');
                              return;
                            } else if (!emailController.text.contains('@') ||
                                !emailController.text.endsWith('.com')) {
                              _showError(
                                context,
                                'Please enter a valid email.',
                              );
                              return;
                            }
                            if (passwordController.text.isEmpty) {
                              _showError(
                                context,
                                'Please enter your password.',
                              );
                              return;
                            }
                            if (passwordController.text.length < 6) {
                              _showError(
                                context,
                                'Password must be at least 6 characters.',
                              );
                              return;
                            }
                            if (confirmpassController.text.isEmpty) {
                              _showError(
                                context,
                                'Please confirm your password.',
                              );
                              return;
                            }
                            if (passwordController.text !=
                                confirmpassController.text) {
                              _showError(context, 'Passwords do not match.');
                              return;
                            }

                            _handleSignup();
                          },
                          child: const Text('Sign Up'),
                        ),
                      ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red[500],
        content: Text(message, style: const TextStyle(color: Colors.white)),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

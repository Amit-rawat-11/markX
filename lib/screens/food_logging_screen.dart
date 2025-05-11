import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mark_x/components/recent_entry_card.dart';
import 'package:mark_x/constant/colors.dart';
import 'package:mark_x/constant/datetime.dart';
import 'package:mark_x/data/sample_food.dart';
import 'package:mark_x/firebase/firestore_Service.dart';
import 'package:mark_x/models/food_item.dart';
import 'package:mark_x/screens/signup_screen.dart';
import 'package:mark_x/theme/text_style.dart';

class FoodLoggingScreen extends StatefulWidget {
  const FoodLoggingScreen({super.key});

  @override
  State<FoodLoggingScreen> createState() => _FoodLoggingScreenState();
}

final firestoreService = FirestoreService();

void logout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) =>   SignupScreen()),
  );
}

class _FoodLoggingScreenState extends State<FoodLoggingScreen> {
  TextEditingController foodNameController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();
  TextEditingController proteinController = TextEditingController();
  TextEditingController foodquantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void saveEntry() {
    final foodName = foodNameController.text.trim();
    final calories = int.tryParse(caloriesController.text.trim()) ?? 0;
    final protein = int.tryParse(proteinController.text.trim()) ?? 0;
    final quantity = int.tryParse(foodquantityController.text.trim()) ?? 0;

    if (foodName.isEmpty || calories == 0 || protein == 0 || quantity == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red[500],
          content: Text(
            "Please fill all fields correctly.",
            style: TextStyle(color: Colors.white),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    final foodItem = FoodItem(
      name: foodName,
      calories: calories,
      protein: protein,
      quantity: quantity,
    );

    setState(() {
      demoFoods.insert(0, foodItem);
    });

    firestoreService.logFood(foodItem);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text("Food entry saved successfully!"),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(TimeUtils.formattedDate),
        leading: IconButton(
          onPressed: () {
            logout(context);
          },
          icon: Icon(LucideIcons.logOut),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: GRBackground.grbackground,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  TextField(
                    controller: foodNameController,
                    maxLines: 1,
                    decoration: InputDecoration(
                      labelText: 'Food Name',
                      labelStyle: MXTextStyles.bodyBold,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black38),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                  TextField(
                    controller: foodquantityController,
                    maxLines: 1,
                    decoration: InputDecoration(
                      labelText: 'Quantity',
                      labelStyle: MXTextStyles.bodyBold,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black38),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                  TextField(
                    controller: proteinController,
                    maxLines: 1,
                    decoration: InputDecoration(
                      labelText: 'Protein',
                      labelStyle: MXTextStyles.bodyBold,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black38),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                  TextField(
                    controller: caloriesController,
                    maxLines: 1,
                    decoration: InputDecoration(
                      labelText: 'Calories',
                      labelStyle: MXTextStyles.bodyBold,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black38),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.08),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.55,
                    height: MediaQuery.of(context).size.width * 0.12,
                    child: ElevatedButton(
                      onPressed: saveEntry,
                      child: const Text('Save'),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                  FutureBuilder<QuerySnapshot>(
                    future:
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser?.uid)
                            .collection('foodlogging')
                            .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text("Error: ${snapshot.error}"));
                      }

                      final docs = snapshot.data!.docs;

                      return SizedBox(
                        height: 300,
                        child: ListView.builder(
                          itemCount: docs.length,
                          itemBuilder: (context, index) {
                            final doc = docs[index];
                            return RecentEntryCard(
                              text: doc['name'],
                              subtitle: "${doc['calories']} Kcals",
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

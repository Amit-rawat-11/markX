import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mark_x/components/recent_entry_card.dart';
import 'package:mark_x/screens/jouranl_edit_screen.dart';
import 'package:mark_x/theme/text_style.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<QueryDocumentSnapshot>> _getUserJournalEntries() async {
    final user = _auth.currentUser;
    if (user == null) return [];

    final snapshot =
        await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('journals')
            .orderBy('timestamp', descending: true)
            .get();

    return snapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Journals"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const JournalEditScreen(),
                ),
              );
              setState(() {});
            },
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
      body: FutureBuilder<List<QueryDocumentSnapshot>>(
        future: _getUserJournalEntries(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final entries = snapshot.data ?? [];

          // Show demo journals if no entries
          if (entries.isEmpty) {
            final demoJournals = [
              {
                'title': 'Welcome to MarkX ✨',
                'content':
                    'Tap the + button above to add your first journal entry.',
              },
              {
                'title': 'Edit Your Journals 📝',
                'content':
                    'Tap on any journal card to edit or view the details.',
              },
            ];

            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: demoJournals.length,
              itemBuilder: (context, index) {
                final demo = demoJournals[index];
                return RecentEntryCard(
                  text: demo['title']!,
                  subtitle: demo['content']!,
                  width: 300,
                  height: 200,
                  textStyle: MXTextStyles.heading,
                );
              },
            );
          }

          // Show actual journal entries
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: entries.length,
            itemBuilder: (context, index) {
              final entry = entries[index];
              final title = entry['title'] ?? 'No Title';
              final content = entry['content'] ?? 'No Content';

              return InkWell(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => JournalEditScreen(documentId: entry.id),
                    ),
                  );
                  setState(() {});
                },
                child: RecentEntryCard(
                  text: title,
                  subtitle: content,
                  width: 300,
                  height: 200,
                  textStyle: MXTextStyles.heading,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

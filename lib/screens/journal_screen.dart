// import 'package:flutter/material.dart';
// import 'package:mark_x/components/recent_entry_card.dart';
// import 'package:mark_x/screens/jouranl_edit_screen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:mark_x/theme/text_style.dart';

// class JournalScreen extends StatefulWidget {
//   const JournalScreen({super.key});

//   @override
//   State<JournalScreen> createState() => _JournalScreenState();
// }

// class _JournalScreenState extends State<JournalScreen> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<List<DocumentSnapshot>> _getJournalEntries() async {
//     final querySnapshot = await _firestore.collection('journals').orderBy('timestamp', descending: true).get();
//     return querySnapshot.docs;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Journals"),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.add),
//             onPressed: () async {
//               await Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const JouranlEditScreen(),
//                 ),
//               );
//               setState(() {});
//             },
//           ),
//         ],
//       ),
//       backgroundColor: Colors.transparent,
//       body: FutureBuilder<List<DocumentSnapshot>>(
//         future: _getJournalEntries(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }

//           final journalEntries = snapshot.data ?? [];

//           return ListView.builder(
//             padding: const EdgeInsets.all(16.0),
//             itemCount: journalEntries.length,
//             itemBuilder: (context, index) {
//               final entry = journalEntries[index];
//               final title = entry['title'];
//               final content = entry['content'];

//               return InkWell(
//                 onTap: () async {
//                   await Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => JouranlEditScreen(documentId: entry.id),
//                     ),
//                   );
//                   setState(() {});
//                 },
//                 child: RecentEntryCard(
//                   text: title,
//                   subtitle: content,
//                   width: 300,
//                   height: 200,
//                   textStyle: MXTextStyles.heading,
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:mark_x/components/recent_entry_card.dart';
import 'package:mark_x/data/sample_journal.dart';
import 'package:mark_x/screens/jouranl_edit_screen.dart';
import 'package:mark_x/theme/text_style.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
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
                  builder: (context) => const JouranlEditScreen(),
                ),
              );
              setState(() {}); // Rebuild after coming back
            },
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: demoJournalEntries.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JouranlEditScreen(index: index),
                ),
              );
              setState(() {}); // Rebuild after coming back
            },
            child: RecentEntryCard(
              text: demoJournalEntries[index].title,
              subtitle: demoJournalEntries[index].content,
              width: 300,
              height: 200,
              textStyle: MXTextStyles.heading,
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mark_x/constant/colors.dart';
import 'package:mark_x/constant/datetime.dart';
import 'package:mark_x/data/sample_journal.dart';
import 'package:mark_x/firebase/firestore_Service.dart';
import 'package:mark_x/models/journal.dart';
import 'package:mark_x/theme/text_style.dart';

class JouranlEditScreen extends StatefulWidget {
  final int? index;
  const JouranlEditScreen({super.key, this.index});

  @override
  State<JouranlEditScreen> createState() => _JouranlEditScreenState();
}

class _JouranlEditScreenState extends State<JouranlEditScreen> {
  late TextEditingController titlecontroller;
  late TextEditingController contentcontroller;

  bool get isEditing => widget.index != null;

  @override
  void initState() {
    super.initState();

    // Use existing data if editing, else empty for new entry
    titlecontroller = TextEditingController(
      text: isEditing ? demoJournalEntries[widget.index!].title : '',
    );
    contentcontroller = TextEditingController(
      text: isEditing ? demoJournalEntries[widget.index!].content : '',
    );
  }

  @override
  void dispose() {
    titlecontroller.dispose();
    contentcontroller.dispose();
    super.dispose();
  }

  final firestoreService = FirestoreService();

// Inside saveEntry function


  void saveEntry() {
    final title = titlecontroller.text.trim();
    final content = contentcontroller.text.trim();

    if (title.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red[400],
          content: Text(
            "Please fill in both title and content.",
            style: TextStyle(color: Colors.white),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    if (isEditing) {
      demoJournalEntries[widget.index!] = JournalEntry(
        title: title,
        content: content,
        timestamp: DateTime.now(),
      );
    } else {
      demoJournalEntries.insert(
        0,
        JournalEntry(title: title, content: content, timestamp: DateTime.now()),
        
      );
      firestoreService.addJournalEntry(
         JournalEntry(
    title: title,
    content: content,
    timestamp: DateTime.now(),
  ));
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green[400],
        content: Text(
          isEditing ? "Entry updated successfully!" : "Journal entry saved!",
          style: TextStyle(color: Colors.white),
        ),
        duration: const Duration(seconds: 2),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // title: Text(isEditing ? "Edit Journal" : "New Journal"),
        title: Text(TimeUtils.formattedDate),
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: saveEntry),
        ],
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: GRBackground.grbackground,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: titlecontroller,
                  maxLines: 1,
                  decoration: InputDecoration(
                    labelText: 'Heading',
                    labelStyle: MXTextStyles.bodyBold,
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45, width: 1),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: contentcontroller,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Journal Entry',
                    labelStyle: MXTextStyles.bodyBold,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.55,
                  height: MediaQuery.of(context).size.width * 0.12,
                  child: ElevatedButton(
                    onPressed: saveEntry,
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





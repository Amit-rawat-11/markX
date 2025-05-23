import 'package:flutter/material.dart';
import 'package:mark_x/constant/colors.dart';
import 'package:mark_x/constant/datetime.dart';
import 'package:mark_x/firebase/firestore_Service.dart';
import 'package:mark_x/models/journal.dart';
import 'package:mark_x/theme/text_style.dart';

class JournalEditScreen extends StatefulWidget {
  final String? documentId; // Use this instead of index

  const JournalEditScreen({super.key, this.documentId});

  @override
  State<JournalEditScreen> createState() => _JournalEditScreenState();
}

class _JournalEditScreenState extends State<JournalEditScreen> {
  late TextEditingController titleController;
  late TextEditingController contentController;
  final firestoreService = FirestoreService();

  bool get isEditing => widget.documentId != null;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    contentController = TextEditingController();

    if (isEditing) {
      _loadJournal();
    }
  }

  Future<void> _loadJournal() async {
    final entry = await firestoreService.getJournalEntry(widget.documentId!);
    if (entry != null) {
      titleController.text = entry.title;
      contentController.text = entry.content;
    }
  }

  void saveEntry() async {
    final title = titleController.text.trim();
    final content = contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Please fill in both title and content"),
        ),
      );
      return;
    }

    final entry = JournalEntry(
      title: title,
      content: content,
      timestamp: DateTime.now(),
    );

    if (isEditing) {
      await firestoreService.updateJournalEntry(widget.documentId!, entry);
    } else {
      await firestoreService.addJournalEntry(entry);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text(isEditing ? "Entry updated!" : "Journal entry saved!"),
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(TimeUtils.formattedDate),
        actions: [IconButton(icon: Icon(Icons.save), onPressed: saveEntry)],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: GRBackground.grbackground,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  maxLines: 1,
                  decoration: InputDecoration(
                    labelText: 'Heading',
                    labelStyle: MXTextStyles.bodyBold,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: contentController,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Journal Entry',
                    labelStyle: MXTextStyles.bodyBold,
                    border: OutlineInputBorder(),
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

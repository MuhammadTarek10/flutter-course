import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/note.dart';

// 🗃️ Module 3: Hive NoSQL Database - Quick Notes App
//
// This demo shows how to use Hive, a fast NoSQL database for Flutter.
//
// Key concepts:
// - NoSQL vs SQL databases (filing cabinet vs spreadsheet analogy)
// - Hive boxes as "filing cabinets"
// - Type adapters for custom objects
// - ValueListenableBuilder for reactive UI
// - CRUD operations (Create, Read, Update, Delete)

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🚀 Initialize Hive
  await Hive.initFlutter();

  Hive.registerAdapter(NoteAdapter());

  // 📂 Open the notes box (our "filing cabinet")
  await Hive.openBox<Note>('notes');

  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive Notes Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const NotesHomePage(),
    );
  }
}

class NotesHomePage extends StatefulWidget {
  const NotesHomePage({super.key});

  @override
  State<NotesHomePage> createState() => _NotesHomePageState();
}

class _NotesHomePageState extends State<NotesHomePage> {
  late Box<Note> notesBox;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    notesBox = Hive.box<Note>('notes');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  // ➕ Add a new note to the Hive box
  void _addNote() {
    if (_titleController.text.isEmpty || _contentController.text.isEmpty) {
      _showSnackBar('Please fill in both title and content', isError: true);
      return;
    }

    final note = Note.create(
      title: _titleController.text.trim(),
      content: _contentController.text.trim(),
    );

    // 💾 Save note to Hive box
    notesBox.add(note);

    // 🧹 Clear input fields
    _titleController.clear();
    _contentController.clear();

    _showSnackBar('Note added successfully!');

    print('📝 Added note: ${note.title} (Total notes: ${notesBox.length})');
  }

  // 🗑️ Delete a note from the Hive box
  void _deleteNote(int index) {
    final note = notesBox.getAt(index);
    if (note != null) {
      notesBox.deleteAt(index);
      _showSnackBar('Note "${note.title}" deleted');
      print(
        '🗑️ Deleted note: ${note.title} (Remaining notes: ${notesBox.length})',
      );
    }
  }

  // ✏️ Edit an existing note
  void _editNote(int index) {
    final note = notesBox.getAt(index);
    if (note != null) {
      _titleController.text = note.title;
      _contentController.text = note.content;

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Edit Note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _titleController.clear();
                _contentController.clear();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                note.updateContent(
                  title: _titleController.text.trim(),
                  content: _contentController.text.trim(),
                );
                Navigator.pop(context);
                _titleController.clear();
                _contentController.clear();
                _showSnackBar('Note updated successfully!');
              },
              child: const Text('Update'),
            ),
          ],
        ),
      );
    }
  }

  // 🧹 Clear all notes
  void _clearAllNotes() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Notes'),
        content: const Text(
          'Are you sure you want to delete all notes? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              notesBox.clear();
              Navigator.pop(context);
              _showSnackBar('All notes cleared');
              print('🧹 Cleared all notes');
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }

  // 📱 Show snackbar message
  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quick Notes'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: _clearAllNotes,
            icon: const Icon(Icons.clear_all),
            tooltip: 'Clear All Notes',
          ),
        ],
      ),
      body: Column(
        children: [
          // 📝 Add Note Section
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add New Note',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Note Title',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.title),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _contentController,
                    decoration: const InputDecoration(
                      labelText: 'Note Content',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.note),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _addNote,
                      icon: const Icon(Icons.add),
                      label: const Text('Add Note'),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 📋 Notes List Section
          Expanded(
            child: Card(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Text(
                          'Your Notes',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8),
                        // 📊 Real-time count using ValueListenableBuilder
                        ValueListenableBuilder(
                          valueListenable: notesBox.listenable(),
                          builder: (context, Box<Note> box, _) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${box.length}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    // 🔄 ValueListenableBuilder automatically rebuilds when box changes
                    child: ValueListenableBuilder(
                      valueListenable: notesBox.listenable(),
                      builder: (context, Box<Note> box, _) {
                        if (box.isEmpty) {
                          return const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.note_add,
                                  size: 64,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'No notes yet',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Add your first note above!',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          );
                        }

                        return ListView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          itemCount: box.length,
                          itemBuilder: (context, index) {
                            final note = box.getAt(index);
                            if (note == null) return const SizedBox.shrink();

                            return Card(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: ListTile(
                                title: Text(
                                  note.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 4),
                                    Text(note.summary),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          size: 12,
                                          color: Colors.grey[600],
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          note.formattedCreatedAt,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        if (note.isRecentlyCreated) ...[
                                          const SizedBox(width: 8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 6,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: const Text(
                                              'NEW',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () => _editNote(index),
                                      icon: const Icon(Icons.edit),
                                      tooltip: 'Edit Note',
                                    ),
                                    IconButton(
                                      onPressed: () => _deleteNote(index),
                                      icon: const Icon(Icons.delete),
                                      color: Colors.red,
                                      tooltip: 'Delete Note',
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 💡 Info Section
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: Colors.blue.shade700),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Your notes are automatically saved to Hive database and will persist between app launches!',
                    style: TextStyle(color: Colors.blue.shade700, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 📚 Learning Notes:
//
// 1. HIVE INITIALIZATION:
//    - Call Hive.initFlutter() before using Hive
//    - Register adapters for custom objects
//    - Open boxes before accessing them
//
// 2. HIVE BOXES:
//    - Think of boxes as "filing cabinets"
//    - Each box can store objects of a specific type
//    - Boxes are opened once and reused throughout the app
//
// 3. VALUELISTENABLEBUILDER:
//    - Automatically rebuilds UI when box changes
//    - More efficient than setState for database changes
//    - Listens to box.listenable()
//
// 4. CRUD OPERATIONS:
//    - Create: box.add(object)
//    - Read: box.getAt(index) or box.values
//    - Update: object.save() (if extends HiveObject)
//    - Delete: box.deleteAt(index) or object.delete()
//
// 5. ADVANTAGES OF HIVE:
//    - Fast (written in pure Dart)
//    - Type-safe with code generation
//    - No SQL knowledge required
//    - Automatic reactive UI updates
//    - Cross-platform (mobile, desktop, web)
//
// 6. WHEN TO USE HIVE:
//    - Storing complex Dart objects
//    - When you need fast read/write operations
//    - When your data structure might change
//    - For offline-first applications

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// 🗄️ Module 4: SQLite Database - Notes App (SQL Version)
//
// This demo shows how to use sqflite for SQL database operations.
// Compare this with the Hive version to understand the differences!
//
// Key concepts:
// - SQL databases as "organized spreadsheets"
// - Creating tables with schemas
// - Raw SQL queries (CREATE, INSERT, SELECT, UPDATE, DELETE)
// - Database initialization and version management
// - Structured data with relationships

// 📝 Note model for SQL database (Plain Dart class, no annotations needed)
class SqlNote {
  final int? id;
  final String title;
  final String content;
  final String createdAt;
  final String updatedAt;

  SqlNote({
    this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  // 🔄 Convert from Map (database row) to SqlNote object
  factory SqlNote.fromMap(Map<String, dynamic> map) {
    return SqlNote(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }

  // 🔄 Convert from SqlNote object to Map (database row)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  // 📅 Get formatted creation date
  String get formattedCreatedAt {
    final date = DateTime.parse(createdAt);
    return '${date.day}/${date.month}/${date.year} '
        '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }

  // 📊 Get note summary (first 50 characters)
  String get summary {
    if (content.length <= 50) return content;
    return '${content.substring(0, 50)}...';
  }

  @override
  String toString() {
    return 'SqlNote(id: $id, title: $title, content: ${content.substring(0, content.length.clamp(0, 20))}...)';
  }
}

// 🗄️ Database Helper Class
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  // 📂 Get database instance (singleton pattern)
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // 🚀 Initialize database
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'notes.db');

    print('📂 Database path: $path');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // 🏗️ Create database tables
  Future<void> _onCreate(Database db, int version) async {
    print('🏗️ Creating notes table...');

    await db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    print('✅ Notes table created successfully');
  }

  // ➕ Insert a new note
  Future<int> insertNote(SqlNote note) async {
    final db = await database;
    final id = await db.insert('notes', note.toMap());
    print('📝 Inserted note with ID: $id');
    return id;
  }

  // 📋 Get all notes
  Future<List<SqlNote>> getAllNotes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'notes',
      orderBy: 'created_at DESC',
    );

    print('📋 Retrieved ${maps.length} notes from database');

    return List.generate(maps.length, (i) {
      return SqlNote.fromMap(maps[i]);
    });
  }

  // 🔍 Get a note by ID
  Future<SqlNote?> getNoteById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return SqlNote.fromMap(maps.first);
    }
    return null;
  }

  // ✏️ Update a note
  Future<int> updateNote(SqlNote note) async {
    final db = await database;
    final count = await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
    print('✏️ Updated note ID: ${note.id}');
    return count;
  }

  // 🗑️ Delete a note
  Future<int> deleteNote(int id) async {
    final db = await database;
    final count = await db.delete('notes', where: 'id = ?', whereArgs: [id]);
    print('🗑️ Deleted note ID: $id');
    return count;
  }

  // 🧹 Delete all notes
  Future<int> deleteAllNotes() async {
    final db = await database;
    final count = await db.delete('notes');
    print('🧹 Deleted all notes (count: $count)');
    return count;
  }

  // 📊 Get notes count
  Future<int> getNotesCount() async {
    final db = await database;
    final count =
        Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM notes'),
        ) ??
        0;
    return count;
  }

  // 🔍 Search notes by title or content
  Future<List<SqlNote>> searchNotes(String query) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'notes',
      where: 'title LIKE ? OR content LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
      orderBy: 'created_at DESC',
    );

    return List.generate(maps.length, (i) {
      return SqlNote.fromMap(maps[i]);
    });
  }
}

void main() {
  runApp(const SqlNotesApp());
}

class SqlNotesApp extends StatelessWidget {
  const SqlNotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite Notes Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const SqlNotesHomePage(),
    );
  }
}

class SqlNotesHomePage extends StatefulWidget {
  const SqlNotesHomePage({super.key});

  @override
  State<SqlNotesHomePage> createState() => _SqlNotesHomePageState();
}

class _SqlNotesHomePageState extends State<SqlNotesHomePage> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  List<SqlNote> _notes = [];
  List<SqlNote> _filteredNotes = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // 📋 Load all notes from database
  Future<void> _loadNotes() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final notes = await _databaseHelper.getAllNotes();
      setState(() {
        _notes = notes;
        _filteredNotes = notes;
        _isLoading = false;
      });
    } catch (e) {
      print('❌ Error loading notes: $e');
      setState(() {
        _isLoading = false;
      });
      _showSnackBar('Error loading notes: $e', isError: true);
    }
  }

  // ➕ Add a new note
  Future<void> _addNote() async {
    if (_titleController.text.isEmpty || _contentController.text.isEmpty) {
      _showSnackBar('Please fill in both title and content', isError: true);
      return;
    }

    final now = DateTime.now().toIso8601String();
    final note = SqlNote(
      title: _titleController.text.trim(),
      content: _contentController.text.trim(),
      createdAt: now,
      updatedAt: now,
    );

    try {
      await _databaseHelper.insertNote(note);
      _titleController.clear();
      _contentController.clear();
      _showSnackBar('Note added successfully!');
      await _loadNotes();
    } catch (e) {
      print('❌ Error adding note: $e');
      _showSnackBar('Error adding note: $e', isError: true);
    }
  }

  // 🗑️ Delete a note
  Future<void> _deleteNote(SqlNote note) async {
    try {
      await _databaseHelper.deleteNote(note.id!);
      _showSnackBar('Note "${note.title}" deleted');
      await _loadNotes();
    } catch (e) {
      print('❌ Error deleting note: $e');
      _showSnackBar('Error deleting note: $e', isError: true);
    }
  }

  // ✏️ Edit a note
  Future<void> _editNote(SqlNote note) async {
    _titleController.text = note.title;
    _contentController.text = note.content;
    final context = this.context;

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
            onPressed: () async {
              final updatedNote = SqlNote(
                id: note.id,
                title: _titleController.text.trim(),
                content: _contentController.text.trim(),
                createdAt: note.createdAt,
                updatedAt: DateTime.now().toIso8601String(),
              );

              try {
                await _databaseHelper.updateNote(updatedNote);
                Navigator.pop(context);
                _titleController.clear();
                _contentController.clear();
                _showSnackBar('Note updated successfully!');
                await _loadNotes();
              } catch (e) {
                print('❌ Error updating note: $e');
                _showSnackBar('Error updating note: $e', isError: true);
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  // 🧹 Clear all notes
  Future<void> _clearAllNotes() async {
    final context = this.context;
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
            onPressed: () async {
              try {
                await _databaseHelper.deleteAllNotes();
                Navigator.pop(context);
                _showSnackBar('All notes cleared');
                await _loadNotes();
              } catch (e) {
                print('❌ Error clearing notes: $e');
                _showSnackBar('Error clearing notes: $e', isError: true);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }

  // 🔍 Search notes
  Future<void> _searchNotes(String query) async {
    if (query.isEmpty) {
      setState(() {
        _filteredNotes = _notes;
      });
      return;
    }

    try {
      final searchResults = await _databaseHelper.searchNotes(query);
      setState(() {
        _filteredNotes = searchResults;
      });
    } catch (e) {
      print('❌ Error searching notes: $e');
      _showSnackBar('Error searching notes: $e', isError: true);
    }
  }

  // 📱 Show snackbar message
  void _showSnackBar(String message, {bool isError = false}) {
    final context = this.context;
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
        title: const Text('SQLite Notes'),
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
          // 🔍 Search Section
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  labelText: 'Search notes...',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: _searchNotes,
              ),
            ),
          ),

          // 📝 Add Note Section
          Card(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
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
                          'Your Notes (SQL)',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${_filteredNotes.length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : _filteredNotes.isEmpty
                        ? const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.storage,
                                  size: 64,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'No notes found',
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
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            itemCount: _filteredNotes.length,
                            itemBuilder: (context, index) {
                              final note = _filteredNotes[index];

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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          const SizedBox(width: 8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 6,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.orange,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              'ID: ${note.id}',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () => _editNote(note),
                                        icon: const Icon(Icons.edit),
                                        tooltip: 'Edit Note',
                                      ),
                                      IconButton(
                                        onPressed: () => _deleteNote(note),
                                        icon: const Icon(Icons.delete),
                                        color: Colors.red,
                                        tooltip: 'Delete Note',
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),

          // 💡 SQL Info Section
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.orange.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.storage, color: Colors.orange.shade700),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'This app uses SQLite database with raw SQL queries. Notice the structured approach compared to Hive!',
                    style: TextStyle(
                      color: Colors.orange.shade700,
                      fontSize: 12,
                    ),
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
// 1. SQL VS NOSQL COMPARISON:
//    SQL (SQLite):                    NoSQL (Hive):
//    - Structured tables             - Flexible objects
//    - Predefined schema             - Schema-less
//    - Raw SQL queries               - Simple method calls
//    - Relationships between tables  - Standalone objects
//    - ACID compliance               - Fast read/write
//
// 2. SQFLITE SETUP:
//    - No special annotations needed
//    - Manual database initialization
//    - Create tables with SQL DDL
//    - Handle database versions
//
// 3. SQL OPERATIONS:
//    - CREATE TABLE: Define structure
//    - INSERT: Add new records
//    - SELECT: Query data
//    - UPDATE: Modify records
//    - DELETE: Remove records
//
// 4. ADVANTAGES OF SQL:
//    - Powerful querying capabilities
//    - Data integrity and relationships
//    - Standardized language
//    - Complex joins and aggregations
//    - ACID transactions
//
// 5. WHEN TO USE SQL:
//    - Complex data relationships
//    - Need for advanced queries
//    - Data integrity is crucial
//    - Working with large datasets
//    - Team familiar with SQL
//
// 6. SQLITE SPECIFIC:
//    - Lightweight, serverless
//    - Single file database
//    - Cross-platform
//    - ACID compliant
//    - Perfect for mobile apps

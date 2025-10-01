import 'package:app/models/note.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '1_shared_preferences_demo.dart' as shared_prefs;
import '2_hive_notes_demo.dart' as hive_demo;
import '3_sqflite_notes_demo.dart' as sqflite_demo;

// 🎯 Session 5: Saving Data Locally - Workshop Navigation
//
// This app provides access to all the local storage workshops:
// 1. SharedPreferences - Theme Switcher (simple key-value storage)
// 2. Hive NoSQL Database - Quick Notes App (object storage)
// 3. SQLite Database - SQL Notes App (relational database)

void main() async {
  await Hive.initFlutter();

  // Register the Note adapter
  Hive.registerAdapter(NoteAdapter());

  await Hive.openBox<Note>('notes');

  runApp(const LocalStorageWorkshopApp());
}

class LocalStorageWorkshopApp extends StatelessWidget {
  const LocalStorageWorkshopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Session 5: Local Storage Workshops',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WorkshopHomePage(),
    );
  }
}

class WorkshopHomePage extends StatelessWidget {
  const WorkshopHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Storage Workshops'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📋 Session Overview
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.storage,
                          color: Theme.of(context).primaryColor,
                          size: 28,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Session 5: Saving Data Locally',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Learn how to persist data in your Flutter apps using different storage solutions. '
                      'Each workshop demonstrates a different approach to local data storage.',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 🎯 Learning Objectives
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.checklist,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Learning Objectives',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ObjectiveItem(
                          'Understand why local storage is essential',
                        ),
                        _ObjectiveItem(
                          'Learn shared_preferences for simple data',
                        ),
                        _ObjectiveItem(
                          'Grasp differences between SQL and NoSQL',
                        ),
                        _ObjectiveItem(
                          'Get hands-on with Hive (NoSQL database)',
                        ),
                        _ObjectiveItem('Experience SQLite for structured data'),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 🛠️ Workshops Section
            Text(
              'Workshops',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Workshop 1: SharedPreferences
            _WorkshopCard(
              title: '1. SharedPreferences Demo',
              subtitle: 'Simple key-value storage',
              description:
                  'Learn the basics of local storage with a theme switcher app. '
                  'Perfect for saving user preferences and simple settings.',
              icon: Icons.settings,
              color: Colors.blue,
              concepts: const [
                'Key-value storage',
                'Async operations',
                'Theme persistence',
                'User preferences',
              ],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const shared_prefs.ThemeSwitcherApp(),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            // Workshop 2: Hive NoSQL
            _WorkshopCard(
              title: '2. Hive NoSQL Database',
              subtitle: 'Object storage with code generation',
              description:
                  'Build a notes app using Hive, a fast NoSQL database. '
                  'Learn about type adapters, reactive UI, and object storage.',
              icon: Icons.note,
              color: Colors.green,
              concepts: const [
                'NoSQL database',
                'Type adapters',
                'Reactive UI',
                'Object storage',
              ],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const hive_demo.NotesApp(),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            // Workshop 3: SQLite
            _WorkshopCard(
              title: '3. SQLite Database',
              subtitle: 'Structured relational database',
              description:
                  'Compare with Hive by building the same notes app using SQLite. '
                  'Learn SQL queries, database schemas, and structured data.',
              icon: Icons.storage,
              color: Colors.orange,
              concepts: const [
                'SQL queries',
                'Database schema',
                'CRUD operations',
                'Structured data',
              ],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const sqflite_demo.SqlNotesApp(),
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            // 💡 Key Differences
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.compare,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Storage Solutions Comparison',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const _ComparisonRow(
                      'SharedPreferences',
                      'Simple settings, user preferences',
                      'Key-value pairs, small data',
                      Colors.blue,
                    ),
                    const SizedBox(height: 8),
                    const _ComparisonRow(
                      'Hive (NoSQL)',
                      'Complex objects, fast read/write',
                      'Schema-less, flexible structure',
                      Colors.green,
                    ),
                    const SizedBox(height: 8),
                    const _ComparisonRow(
                      'SQLite (SQL)',
                      'Structured data, relationships',
                      'Tables, queries, data integrity',
                      Colors.orange,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 🎯 Next Steps
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_forward,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'After the Workshops',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '1. Complete the homework assignment to enhance the Hive notes app\n'
                      '2. Experiment with different data types in each storage solution\n'
                      '3. Consider which approach fits best for your app ideas\n'
                      '4. Explore advanced features like encryption and data migration',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper Widgets

class _ObjectiveItem extends StatelessWidget {
  final String text;

  const _ObjectiveItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 20),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

class _WorkshopCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final Color color;
  final List<String> concepts;
  final VoidCallback onTap;

  const _WorkshopCard({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.color,
    required this.concepts,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: color, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          subtitle,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey[400]),
                ],
              ),
              const SizedBox(height: 16),
              Text(description),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: concepts.map((concept) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: color.withOpacity(0.3)),
                    ),
                    child: Text(
                      concept,
                      style: TextStyle(
                        color: color,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ComparisonRow extends StatelessWidget {
  final String name;
  final String useCase;
  final String characteristics;
  final Color color;

  const _ComparisonRow(
    this.name,
    this.useCase,
    this.characteristics,
    this.color,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
          ),
          const SizedBox(height: 4),
          Text(useCase, style: const TextStyle(fontSize: 12)),
          Text(
            characteristics,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}

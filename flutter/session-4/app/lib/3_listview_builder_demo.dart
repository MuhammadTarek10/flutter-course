import 'package:flutter/material.dart';

// Demo 3: ListView.builder Basics
// This demonstrates efficient list building with dynamic data

void main() {
  runApp(const ListViewBuilderDemo());
}

class ListViewBuilderDemo extends StatelessWidget {
  const ListViewBuilderDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListView.builder Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      home: const ListViewScreen(),
    );
  }
}

class ListViewScreen extends StatefulWidget {
  const ListViewScreen({super.key});

  @override
  State<ListViewScreen> createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {
  // KEY CONCEPT 1: Mock Data Structure
  static const List<Map<String, dynamic>> items = [
    {
      'id': 1,
      'title': 'Flutter Development',
      'subtitle': 'Build beautiful mobile apps',
      'icon': Icons.phone_android,
      'color': Colors.blue,
      'description':
          'Learn to create amazing mobile applications with Flutter framework.',
    },
    {
      'id': 2,
      'title': 'Dart Programming',
      'subtitle': 'Master the language behind Flutter',
      'icon': Icons.code,
      'color': Colors.green,
      'description':
          'Understand Dart programming language fundamentals and advanced concepts.',
    },
    {
      'id': 3,
      'title': 'UI/UX Design',
      'subtitle': 'Create stunning user interfaces',
      'icon': Icons.design_services,
      'color': Colors.orange,
      'description':
          'Design beautiful and intuitive user interfaces for mobile apps.',
    },
    {
      'id': 4,
      'title': 'State Management',
      'subtitle': 'Handle app state effectively',
      'icon': Icons.settings,
      'color': Colors.red,
      'description':
          'Learn different state management approaches in Flutter applications.',
    },
    {
      'id': 5,
      'title': 'API Integration',
      'subtitle': 'Connect your app to web services',
      'icon': Icons.api,
      'color': Colors.teal,
      'description':
          'Integrate REST APIs and handle network requests in Flutter apps.',
    },
    {
      'id': 6,
      'title': 'Database Storage',
      'subtitle': 'Store and manage app data',
      'icon': Icons.storage,
      'color': Colors.indigo,
      'description':
          'Implement local storage solutions using SQLite and other databases.',
    },
    {
      'id': 7,
      'title': 'Testing',
      'subtitle': 'Ensure app quality and reliability',
      'icon': Icons.bug_report,
      'color': Colors.brown,
      'description':
          'Write unit tests, widget tests, and integration tests for Flutter apps.',
    },
    {
      'id': 8,
      'title': 'Deployment',
      'subtitle': 'Publish your app to stores',
      'icon': Icons.publish,
      'color': Colors.pink,
      'description':
          'Deploy your Flutter app to Google Play Store and Apple App Store.',
    },
  ];

  // KEY CONCEPT 2: Selected item tracking
  int? _selectedItemId;

  // KEY CONCEPT 3: Item selection handler
  void _onItemTapped(Map<String, dynamic> item) {
    setState(() {
      _selectedItemId = _selectedItemId == item['id'] ? null : item['id'];
    });

    // Show snackbar with item info
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${_selectedItemId == item['id'] ? 'Selected' : 'Deselected'}: ${item['title']}',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListView.builder Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // Show item count
          Center(
            child: Text(
              '${items.length} items',
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          // Header with instructions
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            color: Colors.purple.shade50,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ListView.builder Example',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('Tap on any item to select/deselect it.'),
                Text(
                  'Notice how the list efficiently builds only visible items.',
                ),
              ],
            ),
          ),
          // KEY CONCEPT 4: ListView.builder Implementation
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: items.length, // Total number of items
              itemBuilder: (context, index) {
                // KEY CONCEPT 5: ItemBuilder function
                final item = items[index];
                final isSelected = _selectedItemId == item['id'];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 8.0,
                  ),
                  elevation: isSelected ? 4 : 2,
                  color: isSelected ? item['color'].withOpacity(0.1) : null,
                  child: ListTile(
                    // KEY CONCEPT 6: ListTile components
                    leading: CircleAvatar(
                      backgroundColor: item['color'],
                      child: Icon(item['icon'], color: Colors.white),
                    ),
                    title: Text(
                      item['title'],
                      style: TextStyle(
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item['subtitle']),
                        if (isSelected) ...[
                          const SizedBox(height: 8),
                          Text(
                            item['description'],
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (isSelected)
                          const Icon(Icons.check_circle, color: Colors.green),
                        const Icon(Icons.arrow_forward_ios, size: 16),
                      ],
                    ),
                    onTap: () => _onItemTapped(item),
                    // KEY CONCEPT 7: Visual feedback
                    selected: isSelected,
                    selectedTileColor: item['color'].withOpacity(0.1),
                  ),
                );
              },
            ),
          ),
          // Footer with selection info
          if (_selectedItemId != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              color: Colors.green.shade50,
              child: Text(
                'Selected: ${items.firstWhere((item) => item['id'] == _selectedItemId)['title']}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
      // KEY CONCEPT 8: Floating Action Button for additional actions
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Scroll to top
          // Note: In a real app, you'd need a ScrollController for this
          setState(() {
            _selectedItemId = null;
          });
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Selection cleared!')));
        },
        child: const Icon(Icons.clear_all),
      ),
    );
  }
}

/*
KEY LEARNING POINTS:

1. LISTVIEW.BUILDER BASICS:
   - itemCount: total number of items
   - itemBuilder: function that builds each item
   - Only builds visible items (memory efficient)
   - Automatically handles scrolling

2. DATA STRUCTURE:
   - Use List<Map<String, dynamic>> for complex data
   - Each item can have multiple properties
   - Access data using item['key'] syntax

3. ITEMBUILDER FUNCTION:
   - Receives (context, index) parameters
   - Returns a Widget for each list item
   - Called only for visible items

4. LISTTILE WIDGET:
   - leading: widget at the start (usually icon/avatar)
   - title: main text
   - subtitle: secondary text (can be multi-line)
   - trailing: widget at the end (usually icon)
   - onTap: handles item selection

5. DYNAMIC UI:
   - Change appearance based on state
   - Use conditional rendering (if statements)
   - Update colors, fonts, icons based on selection

6. STATE MANAGEMENT:
   - Track selected items with state variables
   - Use setState() to update UI
   - Provide visual feedback for user actions

7. PERFORMANCE:
   - ListView.builder is efficient for large lists
   - Only visible items are built and rendered
   - Smooth scrolling even with thousands of items

8. USER EXPERIENCE:
   - Provide clear visual feedback
   - Use SnackBar for temporary messages
   - Show selection state clearly
   - Handle edge cases gracefully
*/

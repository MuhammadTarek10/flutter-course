import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/user.dart';

// 🏗️ Module 3: Displaying API Data in the UI
//
// This demo shows how to use FutureBuilder to handle loading, error, and success
// states when displaying API data in the UI.
//
// Key concepts:
// - FutureBuilder widget for async UI updates
// - ConnectionState management
// - Error handling in UI
// - Loading states and user feedback

void main() {
  runApp(const FutureBuilderApp());
}

class FutureBuilderApp extends StatelessWidget {
  const FutureBuilderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FutureBuilder Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      home: const FutureBuilderDemo(),
    );
  }
}

class FutureBuilderDemo extends StatefulWidget {
  const FutureBuilderDemo({super.key});

  @override
  State<FutureBuilderDemo> createState() => _FutureBuilderDemoState();
}

class _FutureBuilderDemoState extends State<FutureBuilderDemo> {
  late Future<List<User>> _usersFuture;
  String _currentDemo = 'users';

  @override
  void initState() {
    super.initState();
    _usersFuture = _fetchUsers();
  }

  // 🌐 API Service Functions
  Future<List<User>> _fetchUsers() async {
    // Simulate network delay for better demonstration
    await Future.delayed(const Duration(seconds: 1));

    final uri = Uri.https('jsonplaceholder.typicode.com', '/users');
    final response = await http.get(
      uri,
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load users (HTTP ${response.statusCode})');
    }

    final List<dynamic> jsonList = jsonDecode(response.body) as List<dynamic>;
    return jsonList
        .map((json) => User.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<List<User>> _fetchUsersWithError() async {
    await Future.delayed(const Duration(seconds: 2));
    throw Exception('Simulated network error - server is down!');
  }

  Future<List<User>> _fetchUsersSlowly() async {
    await Future.delayed(const Duration(seconds: 5));
    return _fetchUsers();
  }

  Future<List<User>> _fetchEmptyUsers() async {
    await Future.delayed(const Duration(seconds: 1));
    return <User>[]; // Return empty list
  }

  // 🔄 Refresh methods
  void _refreshUsers() {
    setState(() {
      _usersFuture = _fetchUsers();
      _currentDemo = 'users';
    });
  }

  void _demonstrateError() {
    setState(() {
      _usersFuture = _fetchUsersWithError();
      _currentDemo = 'error';
    });
  }

  void _demonstrateSlowLoading() {
    setState(() {
      _usersFuture = _fetchUsersSlowly();
      _currentDemo = 'slow';
    });
  }

  void _demonstrateEmptyState() {
    setState(() {
      _usersFuture = _fetchEmptyUsers();
      _currentDemo = 'empty';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FutureBuilder Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: _refreshUsers,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Column(
        children: [
          // 🎛️ Demo Controls
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.science,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'FutureBuilder State Demonstrations',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Try different scenarios to see how FutureBuilder handles various states:',
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _refreshUsers,
                        icon: const Icon(Icons.check_circle),
                        label: const Text('Success'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade100,
                          foregroundColor: Colors.green.shade700,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: _demonstrateError,
                        icon: const Icon(Icons.error),
                        label: const Text('Error'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade100,
                          foregroundColor: Colors.red.shade700,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: _demonstrateSlowLoading,
                        icon: const Icon(Icons.hourglass_empty),
                        label: const Text('Slow Loading'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange.shade100,
                          foregroundColor: Colors.orange.shade700,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: _demonstrateEmptyState,
                        icon: const Icon(Icons.inbox),
                        label: const Text('Empty Data'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade100,
                          foregroundColor: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // 📊 Current Demo Info
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _getDemoColor().withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _getDemoColor().withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(_getDemoIcon(), color: _getDemoColor()),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _getDemoDescription(),
                    style: TextStyle(
                      color: _getDemoColor(),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 🏗️ FutureBuilder Widget
          Expanded(
            child: FutureBuilder<List<User>>(
              future: _usersFuture,
              builder: (context, snapshot) {
                // 📊 Debug Information (for learning purposes)
                _showDebugInfo(snapshot);

                // 1️⃣ Loading State
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _buildLoadingState();
                }

                // 2️⃣ Error State
                if (snapshot.hasError) {
                  return _buildErrorState(snapshot.error.toString());
                }

                // 3️⃣ Success State with Data
                if (snapshot.hasData) {
                  final users = snapshot.data!;

                  // Handle empty data
                  if (users.isEmpty) {
                    return _buildEmptyState();
                  }

                  return _buildSuccessState(users);
                }

                // 4️⃣ Fallback State (should rarely happen)
                return _buildFallbackState();
              },
            ),
          ),

          // 💡 Learning Notes
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.lightbulb, color: Colors.blue.shade700),
                    const SizedBox(width: 8),
                    Text(
                      'FutureBuilder States',
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'ConnectionState.waiting → Loading\n'
                  'snapshot.hasError → Error occurred\n'
                  'snapshot.hasData → Success with data\n'
                  'Fallback → No data, no error (rare)',
                  style: TextStyle(
                    color: Colors.blue.shade700,
                    fontSize: 12,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🎨 UI State Builders

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(
            'Loading users...',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            _getLoadingMessage(),
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red.shade400),
            const SizedBox(height: 16),
            Text(
              'Oops! Something went wrong',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: Colors.red.shade700),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Text(
                error,
                style: TextStyle(color: Colors.red.shade700, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'No users found',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 8),
          Text(
            'The API returned an empty list',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade500),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _refreshUsers,
            icon: const Icon(Icons.refresh),
            label: const Text('Refresh'),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessState(List<User> users) {
    return Column(
      children: [
        // Success Header
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.green.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green.shade700),
              const SizedBox(width: 8),
              Text(
                'Successfully loaded ${users.length} users',
                style: TextStyle(
                  color: Colors.green.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        // Users List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Text(
                      user.initials,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    user.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.email),
                      const SizedBox(height: 2),
                      Text(
                        user.company.name,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  trailing: Chip(
                    label: Text(
                      'ID: ${user.id}',
                      style: const TextStyle(fontSize: 10),
                    ),
                    backgroundColor: Theme.of(
                      context,
                    ).primaryColor.withOpacity(0.1),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFallbackState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.help_outline, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'Unknown State',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 8),
          Text(
            'No data and no error - this is unusual',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  // 🔧 Helper Methods

  Color _getDemoColor() {
    switch (_currentDemo) {
      case 'users':
        return Colors.green;
      case 'error':
        return Colors.red;
      case 'slow':
        return Colors.orange;
      case 'empty':
        return Colors.grey;
      default:
        return Colors.blue;
    }
  }

  IconData _getDemoIcon() {
    switch (_currentDemo) {
      case 'users':
        return Icons.check_circle;
      case 'error':
        return Icons.error;
      case 'slow':
        return Icons.hourglass_empty;
      case 'empty':
        return Icons.inbox;
      default:
        return Icons.info;
    }
  }

  String _getDemoDescription() {
    switch (_currentDemo) {
      case 'users':
        return 'Normal API call - demonstrates successful data loading';
      case 'error':
        return 'Simulated error - demonstrates error handling in FutureBuilder';
      case 'slow':
        return 'Slow loading (5s) - demonstrates extended loading states';
      case 'empty':
        return 'Empty data - demonstrates handling of empty API responses';
      default:
        return 'Unknown demo state';
    }
  }

  String _getLoadingMessage() {
    switch (_currentDemo) {
      case 'slow':
        return 'This will take 5 seconds to demonstrate\nextended loading states...';
      case 'error':
        return 'This will fail after 2 seconds to\ndemonstrate error handling...';
      default:
        return 'Fetching data from JSONPlaceholder API...';
    }
  }

  void _showDebugInfo(AsyncSnapshot<List<User>> snapshot) {
    // This is for educational purposes - showing the internal state
    // In a real app, you wouldn't need this
    debugPrint('FutureBuilder State:');
    debugPrint('  ConnectionState: ${snapshot.connectionState}');
    debugPrint('  HasData: ${snapshot.hasData}');
    debugPrint('  HasError: ${snapshot.hasError}');
    if (snapshot.hasData) {
      debugPrint('  Data Length: ${snapshot.data?.length}');
    }
    if (snapshot.hasError) {
      debugPrint('  Error: ${snapshot.error}');
    }
  }
}

// 📚 Learning Notes:
//
// 1. FUTUREBUILDER WIDGET:
//    - Takes a Future and a builder function
//    - Automatically rebuilds when Future state changes
//    - Provides AsyncSnapshot with connection state and data
//
// 2. CONNECTION STATES:
//    - ConnectionState.none: No Future provided
//    - ConnectionState.waiting: Future is running
//    - ConnectionState.active: Stream is active (not used with Future)
//    - ConnectionState.done: Future completed (success or error)
//
// 3. SNAPSHOT PROPERTIES:
//    - snapshot.connectionState: Current state of the Future
//    - snapshot.hasData: True if Future completed with data
//    - snapshot.hasError: True if Future completed with error
//    - snapshot.data: The actual data (if hasData is true)
//    - snapshot.error: The error (if hasError is true)
//
// 4. UI STATE PATTERNS:
//    - Loading: Show CircularProgressIndicator
//    - Error: Show error message with retry button
//    - Empty: Show "no data" message
//    - Success: Show the actual data
//
// 5. BEST PRACTICES:
//    - Always handle all possible states
//    - Provide retry mechanisms for errors
//    - Show meaningful loading messages
//    - Handle empty data gracefully
//    - Use proper error messages for users
//
// 6. COMMON MISTAKES:
//    - Not handling empty data
//    - Not providing retry options
//    - Poor error messages
//    - Missing loading states
//    - Not disposing of resources properly

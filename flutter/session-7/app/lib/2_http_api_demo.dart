import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/user.dart';

// 🌐 Module 2: Talking to the Internet
//
// This demo shows how to make HTTP requests to real APIs and parse JSON data.
// It demonstrates the complete flow from API call to displaying data.
//
// Key concepts:
// - HTTP requests with the http package
// - JSON parsing and data models
// - Error handling for network requests
// - API service patterns

void main() {
  runApp(const HttpApiApp());
}

class HttpApiApp extends StatelessWidget {
  const HttpApiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HTTP API Integration',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HttpApiDemo(),
    );
  }
}

class HttpApiDemo extends StatefulWidget {
  const HttpApiDemo({super.key});

  @override
  State<HttpApiDemo> createState() => _HttpApiDemoState();
}

class _HttpApiDemoState extends State<HttpApiDemo> {
  List<User> _users = [];
  bool _isLoading = false;
  String? _error;
  String _apiResponse = '';

  @override
  void initState() {
    super.initState();
    _fetchUsers(); // Load data when the widget initializes
  }

  // 🌐 Fetch users from JSONPlaceholder API
  Future<void> _fetchUsers() async {
    setState(() {
      _isLoading = true;
      _error = null;
      _apiResponse = '';
    });

    try {
      // Step 1: Create the API URL
      final uri = Uri.https('jsonplaceholder.typicode.com', '/users');

      // Step 2: Make the HTTP GET request
      final response = await http.get(
        uri,
        headers: {'Accept': 'application/json'},
      );

      // Step 3: Check if the request was successful
      if (response.statusCode == 200) {
        // Step 4: Parse the JSON response
        final List<dynamic> jsonList =
            jsonDecode(response.body) as List<dynamic>;

        // Step 5: Convert JSON to User objects
        final users = jsonList
            .map((json) => User.fromJson(json as Map<String, dynamic>))
            .toList();

        setState(() {
          _users = users;
          _isLoading = false;
          _apiResponse = 'Successfully loaded ${users.length} users';
        });
      } else {
        throw Exception('Failed to load users (HTTP ${response.statusCode})');
      }
    } catch (error) {
      setState(() {
        _error = error.toString();
        _isLoading = false;
        _apiResponse = 'Error: $error';
      });
    }
  }

  // 🔍 Fetch a single user by ID
  Future<void> _fetchSingleUser(int userId) async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final uri = Uri.https('jsonplaceholder.typicode.com', '/users/$userId');
      final response = await http.get(
        uri,
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final user = User.fromJson(json);

        setState(() {
          _users = [user]; // Show only this user
          _isLoading = false;
          _apiResponse = 'Loaded user: ${user.name}';
        });
      } else {
        throw Exception('User not found (HTTP ${response.statusCode})');
      }
    } catch (error) {
      setState(() {
        _error = error.toString();
        _isLoading = false;
      });
    }
  }

  // 📊 Show raw JSON response
  Future<void> _showRawJson() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final uri = Uri.https('jsonplaceholder.typicode.com', '/users/1');
      final response = await http.get(
        uri,
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Pretty print the JSON
        final json = jsonDecode(response.body);
        const encoder = JsonEncoder.withIndent('  ');
        final prettyJson = encoder.convert(json);

        setState(() {
          _isLoading = false;
          _apiResponse = 'Raw JSON Response:\n\n$prettyJson';
        });

        // Show in dialog
        if (mounted) {
          _showJsonDialog(prettyJson);
        }
      }
    } catch (error) {
      setState(() {
        _error = error.toString();
        _isLoading = false;
      });
    }
  }

  void _showJsonDialog(String json) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Raw JSON Response'),
        content: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              json,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  // 🧪 Test different HTTP scenarios
  Future<void> _testErrorScenario() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // Try to fetch a non-existent endpoint
      final uri = Uri.https('jsonplaceholder.typicode.com', '/nonexistent');
      final response = await http.get(
        uri,
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode != 200) {
        throw Exception(
          'API returned ${response.statusCode}: ${response.reasonPhrase}',
        );
      }
    } catch (error) {
      setState(() {
        _error = error.toString();
        _isLoading = false;
        _apiResponse = 'Demonstrated error handling: $error';
      });
    }
  }

  void _clearData() {
    setState(() {
      _users = [];
      _error = null;
      _apiResponse = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HTTP API Integration'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: _clearData,
            icon: const Icon(Icons.clear_all),
            tooltip: 'Clear Data',
          ),
        ],
      ),
      body: Column(
        children: [
          // 🎛️ Control Panel
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.api, color: Theme.of(context).primaryColor),
                      const SizedBox(width: 8),
                      Text(
                        'API Testing Panel',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'JSONPlaceholder API: A free testing API for developers',
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _isLoading ? null : _fetchUsers,
                        icon: const Icon(Icons.people),
                        label: const Text('Fetch All Users'),
                      ),
                      ElevatedButton.icon(
                        onPressed: _isLoading
                            ? null
                            : () => _fetchSingleUser(1),
                        icon: const Icon(Icons.person),
                        label: const Text('Fetch User #1'),
                      ),
                      ElevatedButton.icon(
                        onPressed: _isLoading ? null : _showRawJson,
                        icon: const Icon(Icons.code),
                        label: const Text('Show Raw JSON'),
                      ),
                      ElevatedButton.icon(
                        onPressed: _isLoading ? null : _testErrorScenario,
                        icon: const Icon(Icons.error_outline),
                        label: const Text('Test Error'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange.shade100,
                          foregroundColor: Colors.orange.shade700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // 📊 Status Display
          if (_isLoading || _apiResponse.isNotEmpty || _error != null)
            Card(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (_isLoading)
                          const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        else if (_error != null)
                          Icon(Icons.error, color: Colors.red.shade700)
                        else
                          Icon(
                            Icons.check_circle,
                            color: Colors.green.shade700,
                          ),
                        const SizedBox(width: 8),
                        Text(
                          _isLoading
                              ? 'Loading...'
                              : _error != null
                              ? 'Error'
                              : 'Success',
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: _error != null
                                    ? Colors.red.shade700
                                    : Colors.green.shade700,
                              ),
                        ),
                      ],
                    ),
                    if (_apiResponse.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: _error != null
                              ? Colors.red.shade50
                              : Colors.green.shade50,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: _error != null
                                ? Colors.red.shade200
                                : Colors.green.shade200,
                          ),
                        ),
                        child: Text(
                          _apiResponse,
                          style: TextStyle(
                            fontFamily: _apiResponse.startsWith('Raw JSON')
                                ? 'monospace'
                                : null,
                            fontSize: _apiResponse.startsWith('Raw JSON')
                                ? 10
                                : 14,
                            color: _error != null
                                ? Colors.red.shade700
                                : Colors.green.shade700,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

          // 👥 Users List
          Expanded(
            child: _users.isEmpty && !_isLoading
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cloud_download,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No data loaded',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Tap a button above to fetch data from the API',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    itemCount: _users.length,
                    itemBuilder: (context, index) {
                      final user = _users[index];
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
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(
                                    Icons.business,
                                    size: 14,
                                    color: Colors.grey[600],
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      user.company.name,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 14,
                                    color: Colors.grey[600],
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      user.fullAddress,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            onPressed: () => _showUserDetails(user),
                            icon: const Icon(Icons.info_outline),
                            tooltip: 'View Details',
                          ),
                        ),
                      );
                    },
                  ),
          ),

          // 💡 API Information
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
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
                    'Using JSONPlaceholder API - a free testing service for developers',
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

  void _showUserDetails(User user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(user.name),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _DetailRow('Username', user.username),
              _DetailRow('Email', user.email),
              _DetailRow('Phone', user.phone),
              _DetailRow('Website', user.website),
              const SizedBox(height: 16),
              Text(
                'Address',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              _DetailRow(
                'Street',
                '${user.address.street}, ${user.address.suite}',
              ),
              _DetailRow('City', user.address.city),
              _DetailRow('Zipcode', user.address.zipcode),
              const SizedBox(height: 16),
              Text(
                'Company',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              _DetailRow('Name', user.company.name),
              _DetailRow('Catchphrase', user.company.catchPhrase),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

// 📚 Learning Notes:
//
// 1. HTTP REQUESTS:
//    - Use http.get() for GET requests
//    - Create URIs with Uri.https() for HTTPS endpoints
//    - Always check response.statusCode for success (200)
//    - Handle network errors with try/catch
//
// 2. JSON PARSING:
//    - Use jsonDecode() to parse JSON strings
//    - Cast to appropriate types: as List<dynamic>, as Map<String, dynamic>
//    - Create model classes with fromJson() factory constructors
//    - Handle null values safely with ?? operator
//
// 3. API PATTERNS:
//    - Create dedicated service classes for API calls
//    - Use proper error handling and user feedback
//    - Show loading states during network requests
//    - Parse responses into strongly-typed objects
//
// 4. BEST PRACTICES:
//    - Always handle network errors gracefully
//    - Show meaningful error messages to users
//    - Use loading indicators for better UX
//    - Validate API responses before using data
//    - Create reusable API service functions
//
// 5. COMMON APIS:
//    - JSONPlaceholder: Free testing API
//    - REST APIs: Standard HTTP methods (GET, POST, PUT, DELETE)
//    - JSON: Most common data format for APIs
//    - Status codes: 200 (success), 404 (not found), 500 (server error)

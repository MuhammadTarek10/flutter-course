import 'package:flutter/material.dart';

// Demo 4: Named Routes and Navigation
// This demonstrates navigation between screens using named routes

void main() {
  runApp(const NamedRoutesDemo());
}

class NamedRoutesDemo extends StatelessWidget {
  const NamedRoutesDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Named Routes Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      // KEY CONCEPT 1: Named Routes Configuration
      initialRoute: '/', // Starting route
      routes: {
        '/': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/details': (context) => const DetailsScreen(),
      },
      // KEY CONCEPT 2: Handle unknown routes
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => const NotFoundScreen());
      },
    );
  }
}

// Home Screen - Main navigation hub
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Named Routes Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Navigation Options',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // KEY CONCEPT 3: Basic Named Route Navigation
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              icon: const Icon(Icons.person),
              label: const Text('Go to Profile'),
            ),
            const SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
              icon: const Icon(Icons.settings),
              label: const Text('Go to Settings'),
            ),
            const SizedBox(height: 16),

            // KEY CONCEPT 4: Navigation with Arguments
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/details',
                  arguments: {
                    'title': 'Flutter Course',
                    'description':
                        'Learn Flutter development with practical examples',
                    'author': 'IEEE Instructor',
                    'rating': 4.8,
                    'color': Colors.blue,
                  },
                );
              },
              icon: const Icon(Icons.info),
              label: const Text('Go to Details (with data)'),
            ),
            const SizedBox(height: 32),

            const Divider(),
            const SizedBox(height: 16),

            const Text(
              'Navigation Methods',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            // Different navigation methods
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // KEY CONCEPT 5: Push (can go back)
                      Navigator.pushNamed(context, '/profile');
                    },
                    child: const Text('Push'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // KEY CONCEPT 6: Push and replace current screen
                      Navigator.pushReplacementNamed(context, '/settings');
                    },
                    child: const Text('Replace'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Test unknown route
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/unknown');
              },
              child: const Text('Test Unknown Route'),
            ),
          ],
        ),
      ),
    );
  }
}

// Profile Screen
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.green.shade100,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 32),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.green,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              'John Doe',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Flutter Developer',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 32),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Profile Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text('• Email: john.doe@example.com'),
                    Text('• Phone: +1 (555) 123-4567'),
                    Text('• Location: San Francisco, CA'),
                    Text('• Joined: January 2024'),
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

// Settings Screen
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = true;
  bool _darkMode = false;
  double _fontSize = 16.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.purple.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'App Settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            SwitchListTile(
              title: const Text('Notifications'),
              subtitle: const Text('Receive push notifications'),
              value: _notifications,
              onChanged: (value) {
                setState(() {
                  _notifications = value;
                });
              },
            ),

            SwitchListTile(
              title: const Text('Dark Mode'),
              subtitle: const Text('Use dark theme'),
              value: _darkMode,
              onChanged: (value) {
                setState(() {
                  _darkMode = value;
                });
              },
            ),

            const SizedBox(height: 16),

            Text('Font Size: ${_fontSize.round()}px'),
            Slider(
              value: _fontSize,
              min: 12.0,
              max: 24.0,
              divisions: 12,
              onChanged: (value) {
                setState(() {
                  _fontSize = value;
                });
              },
            ),

            const SizedBox(height: 32),

            // KEY CONCEPT 7: Navigation from Settings
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              icon: const Icon(Icons.person),
              label: const Text('Go to Profile'),
            ),
          ],
        ),
      ),
    );
  }
}

// Details Screen - Demonstrates receiving arguments
class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // KEY CONCEPT 8: Receiving Route Arguments
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    // Handle case where no arguments are passed
    if (args == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Details')),
        body: const Center(child: Text('No data provided')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(args['title'] ?? 'Details'),
        backgroundColor: (args['color'] as Color?)?.withOpacity(0.1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display passed data
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      args['title'] ?? 'No Title',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Author: ${args['author'] ?? 'Unknown'}',
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      args['description'] ?? 'No description available',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Text('Rating: '),
                        ...List.generate(5, (index) {
                          final rating = args['rating'] ?? 0.0;
                          return Icon(
                            index < rating ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                            size: 20,
                          );
                        }),
                        Text(' ${args['rating'] ?? 0.0}'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Navigation options
            const Text(
              'Navigation Options',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // KEY CONCEPT 9: Pop (go back)
                      Navigator.pop(context);
                    },
                    child: const Text('Go Back'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // KEY CONCEPT 10: Pop until home
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/',
                        (route) => false,
                      );
                    },
                    child: const Text('Go Home'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// 404 Screen for unknown routes
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Not Found'),
        backgroundColor: Colors.red.shade100,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 100, color: Colors.red),
            const SizedBox(height: 20),
            const Text(
              '404',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Page Not Found',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            const Text(
              'The page you are looking for does not exist.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (route) => false,
                );
              },
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}

/*
KEY LEARNING POINTS:

1. NAMED ROUTES SETUP:
   - Define routes in MaterialApp
   - Use initialRoute to set starting screen
   - Map route names to widget builders

2. NAVIGATION METHODS:
   - Navigator.pushNamed() - navigate to route
   - Navigator.pop() - go back
   - Navigator.pushReplacementNamed() - replace current screen
   - Navigator.pushNamedAndRemoveUntil() - clear stack and navigate

3. PASSING ARGUMENTS:
   - Use arguments parameter in pushNamed()
   - Receive with ModalRoute.of(context)?.settings.arguments
   - Cast to appropriate type (Map<String, dynamic>)

4. ERROR HANDLING:
   - onUnknownRoute for handling invalid routes
   - Check for null arguments
   - Provide fallback UI for missing data

5. ROUTE MANAGEMENT:
   - Each route is independent
   - Navigation stack is managed automatically
   - Can clear entire stack if needed

6. BEST PRACTICES:
   - Use meaningful route names
   - Handle null arguments gracefully
   - Provide clear navigation options
   - Test unknown routes

7. USER EXPERIENCE:
   - Clear navigation paths
   - Consistent AppBar styling
   - Helpful error messages
   - Multiple ways to navigate back
*/

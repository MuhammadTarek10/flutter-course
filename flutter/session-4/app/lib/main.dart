import 'package:flutter/material.dart';

void main() {
  runApp(const NavigationLearningApp());
}

// Main App with Named Routes Configuration
class NavigationLearningApp extends StatelessWidget {
  const NavigationLearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Learning App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // Named Routes Configuration - Key Concept #1
      initialRoute: '/',
      routes: {
        '/': (context) => const MainNavigationScreen(),
        '/details': (context) => const DetailsScreen(),
        '/concepts': (context) => const ConceptsOverviewScreen(),
      },
    );
  }
}

// Main Screen demonstrating Bottom Navigation + PageView
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  // Key Concept #2: State Management for Navigation
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    // Key Concept #3: PageController initialization
    _pageController = PageController();
  }

  @override
  void dispose() {
    // Always dispose controllers to prevent memory leaks
    _pageController.dispose();
    super.dispose();
  }

  // Key Concept #4: Bottom Navigation Handler
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    // Animate to the selected page
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // Key Concept #5: PageView Change Handler
  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Concepts'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              // Key Concept #6: Named Route Navigation
              Navigator.pushNamed(context, '/concepts');
            },
          ),
        ],
      ),
      // Key Concept #7: PageView Widget
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: const [
          ListExamplePage(),
          InteractionExamplePage(),
          ProfileExamplePage(),
        ],
      ),
      // Key Concept #8: Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'ListView'),
          BottomNavigationBarItem(
            icon: Icon(Icons.touch_app),
            label: 'Interactions',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// Page 1: ListView.builder Example
class ListExamplePage extends StatelessWidget {
  const ListExamplePage({super.key});

  // Key Concept #9: Mock Data Structure
  static const List<Map<String, dynamic>> items = [
    {
      'title': 'ListView.builder',
      'subtitle': 'Efficiently builds large lists',
      'icon': Icons.list,
      'color': Colors.blue,
    },
    {
      'title': 'Card Widget',
      'subtitle': 'Material Design card container',
      'icon': Icons.credit_card,
      'color': Colors.green,
    },
    {
      'title': 'ListTile',
      'subtitle': 'Built-in list item with leading, title, subtitle',
      'icon': Icons.view_list,
      'color': Colors.orange,
    },
    {
      'title': 'InkWell',
      'subtitle': 'Adds touch ripple effects',
      'icon': Icons.touch_app,
      'color': Colors.purple,
    },
    {
      'title': 'Navigation',
      'subtitle': 'Navigate between screens',
      'icon': Icons.navigation,
      'color': Colors.red,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'ListView.builder Example',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        // Key Concept #10: ListView.builder Implementation
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: item['color'],
                    child: Icon(item['icon'], color: Colors.white),
                  ),
                  title: Text(item['title']),
                  subtitle: Text(item['subtitle']),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Key Concept #11: Navigation with Arguments
                    Navigator.pushNamed(context, '/details', arguments: item);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// Page 2: User Interactions Example
class InteractionExamplePage extends StatefulWidget {
  const InteractionExamplePage({super.key});

  @override
  State<InteractionExamplePage> createState() => _InteractionExamplePageState();
}

class _InteractionExamplePageState extends State<InteractionExamplePage> {
  int _likes = 0;
  bool _isLiked = false;
  String _selectedOption = 'None';

  // Key Concept #12: User Interaction Handlers
  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _likes += _isLiked ? 1 : -1;
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'User Interactions',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),

          // Like Button Example
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'Interactive Like Button',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: _toggleLike,
                        icon: Icon(
                          _isLiked ? Icons.favorite : Icons.favorite_border,
                          color: _isLiked ? Colors.red : Colors.grey,
                          size: 32,
                        ),
                      ),
                      Text(
                        '$_likes likes',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Button Examples
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'Button Types',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => _showSnackBar('ElevatedButton pressed!'),
                    icon: const Icon(Icons.thumb_up),
                    label: const Text('ElevatedButton'),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed: () => _showSnackBar('OutlinedButton pressed!'),
                    icon: const Icon(Icons.share),
                    label: const Text('OutlinedButton'),
                  ),
                  const SizedBox(height: 8),
                  TextButton.icon(
                    onPressed: () => _showSnackBar('TextButton pressed!'),
                    icon: const Icon(Icons.comment),
                    label: const Text('TextButton'),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Selection Example
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'Selection Options',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),
                  Text('Selected: $_selectedOption'),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8.0,
                    children: ['Option A', 'Option B', 'Option C']
                        .map(
                          (option) => ChoiceChip(
                            label: Text(option),
                            selected: _selectedOption == option,
                            onSelected: (selected) {
                              setState(() {
                                _selectedOption = selected ? option : 'None';
                              });
                            },
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Page 3: Profile Layout Example
class ProfileExamplePage extends StatelessWidget {
  const ProfileExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            'Profile Layout',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),

          // Profile Header
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.blue,
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
          const SizedBox(height: 16),
          const Text(
            'John Doe',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Text(
            '@johndoe',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          const Text(
            'Flutter developer passionate about creating beautiful mobile experiences.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),

          const SizedBox(height: 32),

          // Stats Row - Key Concept #13: Custom Widget Creation
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatColumn('Posts', '42'),
              _buildStatColumn('Followers', '1.2K'),
              _buildStatColumn('Following', '256'),
            ],
          ),

          const SizedBox(height: 32),

          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Edit Profile clicked!')),
                  );
                },
                icon: const Icon(Icons.edit),
                label: const Text('Edit Profile'),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Settings clicked!')),
                  );
                },
                icon: const Icon(Icons.settings),
                label: const Text('Settings'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Key Concept #14: Helper Widget Method
  Widget _buildStatColumn(String label, String count) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
      ],
    );
  }
}

// Details Screen - Demonstrates Named Route with Arguments
class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Key Concept #15: Receiving Route Arguments
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(args['title']),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: args['color'],
                child: Icon(args['icon'], size: 40, color: Colors.white),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              args['title'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              args['subtitle'],
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            const Text(
              'This screen demonstrates:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            const Text('• Named route navigation'),
            const Text('• Passing arguments between screens'),
            const Text('• Receiving data in destination screen'),
            const Text('• AppBar with back navigation'),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Go Back'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Concepts Overview Screen
class ConceptsOverviewScreen extends StatelessWidget {
  const ConceptsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Key Concepts'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          ConceptCard(
            title: '1. Named Routes',
            description:
                'Configure routes in MaterialApp and navigate using Navigator.pushNamed()',
            icon: Icons.route,
          ),
          ConceptCard(
            title: '2. Bottom Navigation',
            description:
                'BottomNavigationBar with currentIndex and onTap handler',
            icon: Icons.navigation,
          ),
          ConceptCard(
            title: '3. PageView',
            description:
                'Swipeable pages with PageController for programmatic control',
            icon: Icons.swipe,
          ),
          ConceptCard(
            title: '4. State Management',
            description: 'Using setState() to update UI and manage app state',
            icon: Icons.settings,
          ),
          ConceptCard(
            title: '5. ListView.builder',
            description: 'Efficiently build scrollable lists with dynamic data',
            icon: Icons.list,
          ),
          ConceptCard(
            title: '6. User Interactions',
            description:
                'Handle taps, buttons, and user input with proper feedback',
            icon: Icons.touch_app,
          ),
        ],
      ),
    );
  }
}

// Helper Widget for Concepts
class ConceptCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const ConceptCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(description, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

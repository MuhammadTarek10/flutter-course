import 'package:flutter/material.dart';

// Demo 6: Combined Navigation - Bottom Navigation + PageView + Named Routes
// This demonstrates how to combine all navigation concepts together

void main() {
  runApp(const CombinedNavigationDemo());
}

class CombinedNavigationDemo extends StatelessWidget {
  const CombinedNavigationDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Combined Navigation Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      // Named routes for additional screens
      initialRoute: '/',
      routes: {
        '/': (context) => const MainNavigationScreen(),
        '/item-details': (context) => const ItemDetailsScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/about': (context) => const AboutScreen(),
      },
    );
  }
}

// Main screen combining Bottom Navigation and PageView
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  // KEY CONCEPT 1: Combined State Management
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // KEY CONCEPT 2: Synchronized Navigation Handlers
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Combined Navigation'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'settings':
                  Navigator.pushNamed(context, '/settings');
                  break;
                case 'about':
                  Navigator.pushNamed(context, '/about');
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'settings', child: Text('Settings')),
              const PopupMenuItem(value: 'about', child: Text('About')),
            ],
          ),
        ],
      ),
      // KEY CONCEPT 3: PageView with Multiple Complex Pages
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: const [
          FeedPage(),
          ExplorePage(),
          NotificationsPage(),
          ProfilePage(),
        ],
      ),
      // KEY CONCEPT 4: Bottom Navigation with 4 Tabs
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Feed'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// Feed Page with ListView and Navigation
class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  static const List<Map<String, dynamic>> feedItems = [
    {
      'id': 1,
      'title': 'Flutter 3.0 Released!',
      'author': 'Flutter Team',
      'content':
          'Exciting new features and improvements in the latest Flutter release.',
      'likes': 234,
      'comments': 45,
      'time': '2 hours ago',
      'type': 'announcement',
    },
    {
      'id': 2,
      'title': 'Building Responsive UIs',
      'author': 'UI Designer',
      'content':
          'Tips and tricks for creating beautiful responsive user interfaces.',
      'likes': 156,
      'comments': 28,
      'time': '4 hours ago',
      'type': 'tutorial',
    },
    {
      'id': 3,
      'title': 'State Management Best Practices',
      'author': 'Senior Developer',
      'content':
          'Learn about different state management approaches in Flutter.',
      'likes': 189,
      'comments': 67,
      'time': '6 hours ago',
      'type': 'guide',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          color: Colors.indigo.shade50,
          child: const Text(
            'Latest Updates',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        // Feed List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: feedItems.length,
            itemBuilder: (context, index) {
              final item = feedItems[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                child: InkWell(
                  onTap: () {
                    // KEY CONCEPT 5: Navigation from ListView to Details
                    Navigator.pushNamed(
                      context,
                      '/item-details',
                      arguments: item,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: _getTypeColor(item['type']),
                              child: Text(
                                item['author'][0],
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['author'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    item['time'],
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Chip(
                              label: Text(item['type']),
                              backgroundColor: _getTypeColor(
                                item['type'],
                              ).withOpacity(0.2),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          item['title'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(item['content']),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Icon(
                              Icons.favorite_border,
                              color: Colors.grey.shade600,
                            ),
                            const SizedBox(width: 4),
                            Text('${item['likes']}'),
                            const SizedBox(width: 20),
                            Icon(
                              Icons.comment_outlined,
                              color: Colors.grey.shade600,
                            ),
                            const SizedBox(width: 4),
                            Text('${item['comments']}'),
                            const Spacer(),
                            const Icon(Icons.arrow_forward_ios, size: 16),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'announcement':
        return Colors.blue;
      case 'tutorial':
        return Colors.green;
      case 'guide':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}

// Explore Page with Grid Layout
class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final List<String> categories = [
    'Widgets',
    'Layouts',
    'Navigation',
    'Animation',
    'State Management',
    'Networking',
    'Storage',
    'Testing',
    'Deployment',
    'Performance',
  ];

  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Category Filter
        Container(
          height: 60,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length + 1,
            itemBuilder: (context, index) {
              final category = index == 0 ? 'All' : categories[index - 1];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ChoiceChip(
                  label: Text(category),
                  selected: _selectedCategory == category,
                  onSelected: (selected) {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                ),
              );
            },
          ),
        ),
        // Grid Content
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 1.2,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Card(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/item-details',
                      arguments: {
                        'title': category,
                        'type': 'category',
                        'content': 'Explore $category topics and examples.',
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _getCategoryIcon(category),
                          size: 40,
                          color: Colors.indigo,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          category,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'widgets':
        return Icons.widgets;
      case 'layouts':
        return Icons.view_quilt;
      case 'navigation':
        return Icons.navigation;
      case 'animation':
        return Icons.animation;
      case 'state management':
        return Icons.settings;
      case 'networking':
        return Icons.network_check;
      case 'storage':
        return Icons.storage;
      case 'testing':
        return Icons.bug_report;
      case 'deployment':
        return Icons.publish;
      case 'performance':
        return Icons.speed;
      default:
        return Icons.category;
    }
  }
}

// Notifications Page
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_off, size: 100, color: Colors.grey),
          SizedBox(height: 20),
          Text(
            'No Notifications',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text('You\'re all caught up!'),
        ],
      ),
    );
  }
}

// Profile Page
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.indigo,
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
          const SizedBox(height: 16),
          const Text(
            'Flutter Developer',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('@flutter_dev', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatColumn('Projects', '12'),
              _buildStatColumn('Followers', '1.2K'),
              _buildStatColumn('Following', '234'),
            ],
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () => Navigator.pushNamed(context, '/settings'),
            icon: const Icon(Icons.settings),
            label: const Text('Settings'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String label, String count) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}

// Item Details Screen
class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Details')),
        body: const Center(child: Text('No data provided')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(args['title'] ?? 'Details'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              args['title'] ?? 'No Title',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (args['author'] != null) ...[
              Text('Author: ${args['author']}'),
              const SizedBox(height: 8),
            ],
            if (args['time'] != null) ...[
              Text('Time: ${args['time']}'),
              const SizedBox(height: 16),
            ],
            Text(args['content'] ?? 'No content available'),
            const SizedBox(height: 24),
            if (args['likes'] != null && args['comments'] != null) ...[
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite_border),
                    label: Text('${args['likes']} Likes'),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.comment_outlined),
                    label: Text('${args['comments']} Comments'),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Settings Screen
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Center(
        child: Text('Settings Screen', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

// About Screen
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Center(
        child: Text('About Screen', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

/*
KEY LEARNING POINTS:

1. COMBINING NAVIGATION PATTERNS:
   - Bottom Navigation for main app sections
   - PageView for swipeable content
   - Named Routes for detailed screens
   - PopupMenu for additional options

2. STATE SYNCHRONIZATION:
   - Keep bottom navigation and PageView in sync
   - Handle both tap and swipe navigation
   - Maintain consistent state across interactions

3. COMPLEX PAGE LAYOUTS:
   - ListView.builder for dynamic content
   - GridView for category exploration
   - Different layouts for different content types
   - Responsive design considerations

4. NAVIGATION HIERARCHY:
   - Main app level (Bottom Navigation)
   - Page level (PageView content)
   - Detail level (Named Routes)
   - Modal level (Dialogs, Bottom Sheets)

5. DATA FLOW:
   - Pass complex data through route arguments
   - Handle null arguments gracefully
   - Maintain data consistency across screens

6. USER EXPERIENCE:
   - Smooth transitions between all navigation types
   - Clear visual hierarchy and feedback
   - Intuitive navigation patterns
   - Consistent theming throughout

This example shows how real-world apps combine multiple navigation
patterns to create rich, interactive user experiences.
*/

import 'package:flutter/material.dart';

// Demo 1: Bottom Navigation Bar Basics
// This demonstrates the core concepts of BottomNavigationBar

void main() {
  runApp(const BottomNavigationDemo());
}

class BottomNavigationDemo extends StatelessWidget {
  const BottomNavigationDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom Navigation Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const BottomNavScreen(),
    );
  }
}

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  // KEY CONCEPT 1: State Management for Navigation
  int _selectedIndex = 0;

  // KEY CONCEPT 2: List of Pages/Widgets
  final List<Widget> _pages = [
    const HomePage(),
    const SearchPage(),
    const FavoritesPage(),
    const ProfilePage(),
  ];

  // KEY CONCEPT 3: Navigation Handler
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    print('Selected tab: $index'); // Debug output
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bottom Navigation Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      // KEY CONCEPT 4: Display Selected Page
      body: _pages[_selectedIndex],
      // KEY CONCEPT 5: BottomNavigationBar Configuration
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Shows all tabs
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// Sample Pages for Each Tab
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.home, size: 100, color: Colors.blue),
          SizedBox(height: 20),
          Text(
            'Home Page',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text('This is the Home tab content'),
        ],
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 100, color: Colors.green),
          SizedBox(height: 20),
          Text(
            'Search Page',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text('This is the Search tab content'),
        ],
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite, size: 100, color: Colors.red),
          SizedBox(height: 20),
          Text(
            'Favorites Page',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text('This is the Favorites tab content'),
        ],
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person, size: 100, color: Colors.purple),
          SizedBox(height: 20),
          Text(
            'Profile Page',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text('This is the Profile tab content'),
        ],
      ),
    );
  }
}

/*
KEY LEARNING POINTS:

1. STATE MANAGEMENT:
   - Use int _selectedIndex to track current tab
   - setState() to update UI when tab changes

2. BOTTOM NAVIGATION BAR:
   - type: BottomNavigationBarType.fixed (shows all tabs)
   - currentIndex: tracks which tab is selected
   - onTap: handles tab selection
   - items: list of BottomNavigationBarItem

3. TAB SWITCHING:
   - Store pages in a List<Widget>
   - Use _selectedIndex to display correct page
   - _onItemTapped() updates the selected index

4. STYLING:
   - selectedItemColor: color for active tab
   - unselectedItemColor: color for inactive tabs
   - Each item has icon and label

5. BEST PRACTICES:
   - Use meaningful variable names
   - Add debug prints to understand flow
   - Keep page widgets separate and simple
*/

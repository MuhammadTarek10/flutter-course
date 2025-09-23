import 'package:flutter/material.dart';

// Demo 2: PageView Widget Basics
// This demonstrates PageView with PageController

void main() {
  runApp(const PageViewDemo());
}

class PageViewDemo extends StatelessWidget {
  const PageViewDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PageView Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const PageViewScreen(),
    );
  }
}

class PageViewScreen extends StatefulWidget {
  const PageViewScreen({super.key});

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  // KEY CONCEPT 1: PageController for programmatic control
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    // KEY CONCEPT 2: Initialize PageController
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    // KEY CONCEPT 3: Always dispose controllers
    _pageController.dispose();
    super.dispose();
  }

  // KEY CONCEPT 4: Handle page changes from swiping
  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
    print('Page changed to: $page'); // Debug output
  }

  // KEY CONCEPT 5: Programmatic navigation to specific page
  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // KEY CONCEPT 6: Navigate to next page
  void _nextPage() {
    if (_currentPage < 2) {
      _goToPage(_currentPage + 1);
    }
  }

  // KEY CONCEPT 7: Navigate to previous page
  void _previousPage() {
    if (_currentPage > 0) {
      _goToPage(_currentPage - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PageView Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // Page indicator in AppBar
          Center(
            child: Text(
              '${_currentPage + 1} / 3',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          // KEY CONCEPT 8: Page Indicators
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? Colors.green
                        : Colors.grey.shade300,
                  ),
                );
              }),
            ),
          ),
          // KEY CONCEPT 9: PageView Widget
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: const [
                PageContent(
                  title: 'Page 1',
                  color: Colors.red,
                  icon: Icons.star,
                  description:
                      'This is the first page.\nSwipe left to go to the next page.',
                ),
                PageContent(
                  title: 'Page 2',
                  color: Colors.blue,
                  icon: Icons.favorite,
                  description:
                      'This is the second page.\nYou can swipe left or right.',
                ),
                PageContent(
                  title: 'Page 3',
                  color: Colors.orange,
                  icon: Icons.thumb_up,
                  description:
                      'This is the third page.\nSwipe right to go back.',
                ),
              ],
            ),
          ),
          // KEY CONCEPT 10: Navigation Controls
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _currentPage > 0 ? _previousPage : null,
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Previous'),
                ),
                ElevatedButton.icon(
                  onPressed: () => _goToPage(1), // Go to middle page
                  icon: const Icon(Icons.home),
                  label: const Text('Home'),
                ),
                ElevatedButton.icon(
                  onPressed: _currentPage < 2 ? _nextPage : null,
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Next'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Reusable Page Content Widget
class PageContent extends StatelessWidget {
  final String title;
  final Color color;
  final IconData icon;
  final String description;

  const PageContent({
    super.key,
    required this.title,
    required this.color,
    required this.icon,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color.withOpacity(0.1),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 100, color: color),
            const SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
KEY LEARNING POINTS:

1. PAGECONTROLLER:
   - late PageController _pageController
   - Initialize in initState()
   - Always dispose in dispose()

2. PAGEVIEW WIDGET:
   - controller: connects to PageController
   - onPageChanged: callback when user swipes
   - children: list of pages to display

3. PROGRAMMATIC NAVIGATION:
   - animateToPage() for smooth transitions
   - Duration and Curve for animation control
   - Check bounds before navigating

4. PAGE INDICATORS:
   - Visual dots showing current page
   - Update appearance based on _currentPage
   - Use List.generate() for dynamic creation

5. USER INTERACTION:
   - Swipe gestures work automatically
   - Button controls for programmatic navigation
   - Disable buttons at boundaries (first/last page)

6. STATE MANAGEMENT:
   - Track _currentPage with setState()
   - Update UI when page changes
   - Sync all UI elements with current page

7. BEST PRACTICES:
   - Always dispose controllers
   - Provide visual feedback (indicators)
   - Handle edge cases (first/last page)
   - Use meaningful animations
*/

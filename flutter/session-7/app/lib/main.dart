import 'package:flutter/material.dart';

import '1_async_basics_demo.dart' as async_demo;
import '2_http_api_demo.dart' as http_demo;
import '3_futurebuilder_demo.dart' as futurebuilder_demo;
import '4_photo_gallery_solution.dart' as gallery_demo;

void main() {
  runApp(const Session7App());
}

class Session7App extends StatelessWidget {
  const Session7App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Session 7: Async Programming & API Integration',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const Session7HomePage(),
    );
  }
}

class Session7HomePage extends StatelessWidget {
  const Session7HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session 7 Workshops'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🎯 Session Header
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Icon(
                        Icons.cloud_sync,
                        size: 40,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Session 7: Asynchronous Programming & API Integration',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Master async programming, HTTP requests, and real-world API integration',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 🎯 Learning Objectives
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.school,
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
                          'Understand asynchronous programming and why it prevents UI freezing',
                        ),
                        _ObjectiveItem(
                          'Master Future, async, and await keywords in Dart',
                        ),
                        _ObjectiveItem(
                          'Make HTTP requests to real-world REST APIs',
                        ),
                        _ObjectiveItem(
                          'Parse JSON data into strongly-typed Dart objects',
                        ),
                        _ObjectiveItem(
                          'Use FutureBuilder to handle loading, error, and success states',
                        ),
                        _ObjectiveItem(
                          'Build a complete photo gallery app with API integration',
                        ),
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

            // Workshop 1: Async Basics
            _WorkshopCard(
              title: '1. Async Programming Basics',
              subtitle: 'The coffee shop analogy',
              description:
                  'Learn the fundamentals of asynchronous programming using simple analogies. '
                  'Understand Future, async, and await through interactive demonstrations.',
              icon: Icons.timer,
              color: Colors.orange,
              concepts: const [
                'Future',
                'async/await',
                'UI Responsiveness',
                'Coffee Shop Analogy',
              ],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const async_demo.AsyncBasicsDemo(),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            // Workshop 2: HTTP API
            _WorkshopCard(
              title: '2. HTTP API Integration',
              subtitle: 'Talking to the internet',
              description:
                  'Make HTTP requests to real APIs and parse JSON data. '
                  'Learn about data models, error handling, and API service patterns.',
              icon: Icons.api,
              color: Colors.blue,
              concepts: const [
                'HTTP Requests',
                'JSON Parsing',
                'Data Models',
                'Error Handling',
              ],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const http_demo.HttpApiDemo(),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            // Workshop 3: FutureBuilder
            _WorkshopCard(
              title: '3. FutureBuilder UI Patterns',
              subtitle: 'Displaying API data gracefully',
              description:
                  'Master FutureBuilder widget to handle loading, error, and success states. '
                  'Learn professional UI patterns for async data display.',
              icon: Icons.build_circle,
              color: Colors.purple,
              concepts: const [
                'FutureBuilder',
                'ConnectionState',
                'Loading States',
                'Error UI',
              ],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const futurebuilder_demo.FutureBuilderDemo(),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            // Workshop 4: Photo Gallery
            _WorkshopCard(
              title: '4. Photo Gallery Solution',
              subtitle: 'Complete homework implementation',
              description:
                  'See the complete solution for the photo gallery homework. '
                  'Includes GridView, image loading, detail views, and professional error handling.',
              icon: Icons.photo_library,
              color: Colors.teal,
              concepts: const [
                'GridView',
                'Image Loading',
                'Navigation',
                'Complete App',
              ],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const gallery_demo.PhotoGalleryPage(),
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            // 💡 Async Programming Flow
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.timeline,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Async Programming Flow',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Column(
                      children: [
                        _FlowStep(
                          '1',
                          'Understand the Problem',
                          'Why synchronous operations freeze the UI',
                        ),
                        _FlowStep(
                          '2',
                          'Learn Async Concepts',
                          'Future, async, and await keywords',
                        ),
                        _FlowStep(
                          '3',
                          'Make HTTP Requests',
                          'Connect to real APIs and handle responses',
                        ),
                        _FlowStep(
                          '4',
                          'Parse JSON Data',
                          'Convert API responses to Dart objects',
                        ),
                        _FlowStep(
                          '5',
                          'Handle UI States',
                          'Use FutureBuilder for loading, error, success',
                        ),
                        _FlowStep(
                          '6',
                          'Build Complete Apps',
                          'Combine all concepts in real applications',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 🎯 Best Practices
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star, color: Theme.of(context).primaryColor),
                        const SizedBox(width: 8),
                        Text(
                          'Async Best Practices',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _BestPracticeItem(
                          'Always use async/await for long-running operations',
                        ),
                        _BestPracticeItem(
                          'Handle all possible states: loading, error, success, empty',
                        ),
                        _BestPracticeItem(
                          'Provide meaningful error messages to users',
                        ),
                        _BestPracticeItem(
                          'Show loading indicators during network requests',
                        ),
                        _BestPracticeItem(
                          'Use try/catch blocks for proper error handling',
                        ),
                        _BestPracticeItem(
                          'Create data models with fromJson factory constructors',
                        ),
                        _BestPracticeItem(
                          'Validate API responses before using data',
                        ),
                        _BestPracticeItem(
                          'Implement retry mechanisms for failed requests',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 🚀 Next Steps
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.rocket_launch,
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
                      'Complete the photo gallery homework and explore these advanced topics:',
                    ),
                    const SizedBox(height: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _NextStepItem(
                          '🏗️ State Management',
                          'Provider, Riverpod, or Bloc for complex apps',
                        ),
                        _NextStepItem(
                          '🔄 Caching',
                          'Cache API responses for better performance',
                        ),
                        _NextStepItem(
                          '📱 Offline Support',
                          'Handle network connectivity issues',
                        ),
                        _NextStepItem(
                          '🔐 Authentication',
                          'JWT tokens and secure API calls',
                        ),
                        _NextStepItem(
                          '📊 Pagination',
                          'Load large datasets efficiently',
                        ),
                        _NextStepItem(
                          '🎨 Advanced UI',
                          'Custom loading animations and transitions',
                        ),
                      ],
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

// 🏗️ Helper Widgets

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
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Icon(icon, color: color, size: 24),
                  ),
                  const SizedBox(width: 12),
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
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey[400],
                    size: 16,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(description, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 12),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: concepts.map((concept) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: color.withOpacity(0.3)),
                    ),
                    child: Text(
                      concept,
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(
                          255,
                          (color.red * 0.7).round(),
                          (color.green * 0.7).round(),
                          (color.blue * 0.7).round(),
                        ),
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

class _ObjectiveItem extends StatelessWidget {
  final String objective;

  const _ObjectiveItem(this.objective);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 20),
          const SizedBox(width: 8),
          Expanded(child: Text(objective)),
        ],
      ),
    );
  }
}

class _FlowStep extends StatelessWidget {
  final String step;
  final String title;
  final String description;

  const _FlowStep(this.step, this.title, this.description);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                step,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  description,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BestPracticeItem extends StatelessWidget {
  final String practice;

  const _BestPracticeItem(this.practice);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.arrow_right, color: Colors.blue, size: 16),
          const SizedBox(width: 4),
          Expanded(child: Text(practice, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}

class _NextStepItem extends StatelessWidget {
  final String title;
  final String description;

  const _NextStepItem(this.title, this.description);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              description,
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

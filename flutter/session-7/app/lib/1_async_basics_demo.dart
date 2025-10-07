import 'package:flutter/material.dart';

// ⏰ Module 1: The Problem of a Frozen App & The Async Solution
//
// This demo explains asynchronous programming concepts using simple analogies
// and demonstrates the difference between synchronous and asynchronous operations.
//
// Key concepts:
// - Synchronous vs Asynchronous operations
// - Future as a "promise" of future value
// - async/await keywords for handling Futures
// - Why async programming prevents UI freezing

void main() {
  runApp(const AsyncBasicsApp());
}

class AsyncBasicsApp extends StatelessWidget {
  const AsyncBasicsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Async Programming Basics',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const AsyncBasicsDemo(),
    );
  }
}

class AsyncBasicsDemo extends StatefulWidget {
  const AsyncBasicsDemo({super.key});

  @override
  State<AsyncBasicsDemo> createState() => _AsyncBasicsDemoState();
}

class _AsyncBasicsDemoState extends State<AsyncBasicsDemo> {
  String _syncResult = '';
  String _asyncResult = '';
  bool _isLoading = false;
  int _counter = 0;

  // 🔄 Simulate a synchronous operation (BLOCKS the UI)
  void _runSynchronousOperation() {
    setState(() {
      _syncResult = 'Starting synchronous operation...';
    });

    // This will FREEZE the UI for 3 seconds
    // DON'T DO THIS in real apps!
    final startTime = DateTime.now();
    while (DateTime.now().difference(startTime).inSeconds < 3) {
      // Busy waiting - blocks the UI thread
    }

    setState(() {
      _syncResult =
          'Synchronous operation completed! ✅\n'
          'UI was frozen during this time 😱';
    });
  }

  // ⚡ Simulate an asynchronous operation (DOESN'T block the UI)
  Future<void> _runAsynchronousOperation() async {
    setState(() {
      _asyncResult = 'Starting asynchronous operation...';
      _isLoading = true;
    });

    // This simulates a network request or file operation
    // The UI remains responsive during this time
    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      _asyncResult =
          'Asynchronous operation completed! ✅\n'
          'UI remained responsive during this time 😊';
      _isLoading = false;
    });
  }

  // ☕ Coffee shop analogy demonstration
  Future<String> _orderCoffee() async {
    // Step 1: Place order
    setState(() {
      _asyncResult =
          '☕ Ordering coffee...\n'
          'You can do other things while waiting!';
    });

    // Step 2: Wait for coffee (asynchronously)
    await Future.delayed(const Duration(seconds: 2));

    // Step 3: Coffee is ready
    return 'Your coffee is ready! ☕✨';
  }

  Future<void> _demonstrateCoffeeAnalogy() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // This is like getting the "buzzer" from the coffee shop
      final coffee = await _orderCoffee();

      setState(() {
        _asyncResult = coffee;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _asyncResult = 'Error: $error';
        _isLoading = false;
      });
    }
  }

  // 🔄 Multiple async operations
  Future<void> _runMultipleAsyncOperations() async {
    setState(() {
      _asyncResult = 'Running multiple async operations...\n';
      _isLoading = true;
    });

    // Run operations sequentially (one after another)
    final result1 = await _simulateNetworkCall('Operation 1', 1);
    setState(() {
      _asyncResult += '$result1\n';
    });

    final result2 = await _simulateNetworkCall('Operation 2', 1);
    setState(() {
      _asyncResult += '$result2\n';
    });

    final result3 = await _simulateNetworkCall('Operation 3', 1);
    setState(() {
      _asyncResult += '$result3\n';
      _asyncResult += 'All operations completed! 🎉';
      _isLoading = false;
    });
  }

  Future<void> _runParallelAsyncOperations() async {
    setState(() {
      _asyncResult = 'Running parallel async operations...\n';
      _isLoading = true;
    });

    // Run operations in parallel (all at the same time)
    final futures = [
      _simulateNetworkCall('Parallel Operation A', 2),
      _simulateNetworkCall('Parallel Operation B', 2),
      _simulateNetworkCall('Parallel Operation C', 2),
    ];

    final results = await Future.wait(futures);

    setState(() {
      _asyncResult += results.join('\n');
      _asyncResult += '\nAll parallel operations completed! 🚀';
      _isLoading = false;
    });
  }

  Future<String> _simulateNetworkCall(String operation, int seconds) async {
    await Future.delayed(Duration(seconds: seconds));
    return '$operation completed ✅';
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _clearResults() {
    setState(() {
      _syncResult = '';
      _asyncResult = '';
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Async Programming Basics'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: _clearResults,
            icon: const Icon(Icons.clear_all),
            tooltip: 'Clear Results',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📋 Introduction Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'The Coffee Shop Analogy',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '☕ Synchronous: You stand at the counter staring at the barista until your coffee is ready. '
                      'The entire line behind you is blocked.\n\n'
                      '⚡ Asynchronous: You get a buzzer and can sit down, check your phone, or chat with friends. '
                      'When your coffee is ready, the buzzer goes off!',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 🧪 UI Responsiveness Test
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.touch_app,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'UI Responsiveness Test',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Try tapping the counter button during different operations to see how async keeps the UI responsive!',
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: _incrementCounter,
                          icon: const Icon(Icons.add),
                          label: Text('Counter: $_counter'),
                        ),
                        const SizedBox(width: 16),
                        if (_isLoading)
                          const Row(
                            children: [
                              SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text('Operation running...'),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 🚫 Synchronous Operations (Bad Example)
            Card(
              color: Colors.red.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.block, color: Colors.red.shade700),
                        const SizedBox(width: 8),
                        Text(
                          'Synchronous Operations (DON\'T DO THIS)',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.red.shade700,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'This will FREEZE the UI for 3 seconds. Try tapping the counter button during this operation!',
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _runSynchronousOperation,
                      icon: const Icon(Icons.warning),
                      label: const Text('Run Sync Operation (Freezes UI)'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade100,
                        foregroundColor: Colors.red.shade700,
                      ),
                    ),
                    if (_syncResult.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.red.shade300),
                        ),
                        child: Text(
                          _syncResult,
                          style: TextStyle(color: Colors.red.shade700),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ✅ Asynchronous Operations (Good Example)
            Card(
              color: Colors.green.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green.shade700),
                        const SizedBox(width: 8),
                        Text(
                          'Asynchronous Operations (RECOMMENDED)',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade700,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'These operations keep the UI responsive. Try tapping the counter button during these operations!',
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ElevatedButton.icon(
                          onPressed: _isLoading
                              ? null
                              : _runAsynchronousOperation,
                          icon: const Icon(Icons.timer),
                          label: const Text('Simple Async'),
                        ),
                        ElevatedButton.icon(
                          onPressed: _isLoading
                              ? null
                              : _demonstrateCoffeeAnalogy,
                          icon: const Icon(Icons.coffee),
                          label: const Text('Coffee Analogy'),
                        ),
                        ElevatedButton.icon(
                          onPressed: _isLoading
                              ? null
                              : _runMultipleAsyncOperations,
                          icon: const Icon(Icons.list),
                          label: const Text('Sequential'),
                        ),
                        ElevatedButton.icon(
                          onPressed: _isLoading
                              ? null
                              : _runParallelAsyncOperations,
                          icon: const Icon(Icons.speed),
                          label: const Text('Parallel'),
                        ),
                      ],
                    ),
                    if (_asyncResult.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.green.shade300),
                        ),
                        child: Text(
                          _asyncResult,
                          style: TextStyle(color: Colors.green.shade700),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 🔧 Code Examples Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.code, color: Theme.of(context).primaryColor),
                        const SizedBox(width: 8),
                        Text(
                          'Code Examples',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const _CodeExample(
                      title: 'Synchronous (Bad)',
                      code: '''
// This BLOCKS the UI thread
void badFunction() {
  final result = heavyComputation(); // UI freezes here
  print(result);
}''',
                      isGood: false,
                    ),
                    const SizedBox(height: 16),
                    const _CodeExample(
                      title: 'Asynchronous (Good)',
                      code: '''
// This keeps UI responsive
Future<void> goodFunction() async {
  final result = await heavyComputation(); // UI stays responsive
  print(result);
}''',
                      isGood: true,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 💡 Key Concepts Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.lightbulb,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Key Concepts',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ConceptItem(
                          'Future',
                          'A "buzzer" that represents a value that will be available in the future',
                        ),
                        _ConceptItem(
                          'async',
                          'Marks a function as one that can work with Futures',
                        ),
                        _ConceptItem(
                          'await',
                          'Pauses execution until a Future completes, without blocking the UI',
                        ),
                        _ConceptItem(
                          'Future.wait()',
                          'Runs multiple async operations in parallel',
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

class _CodeExample extends StatelessWidget {
  final String title;
  final String code;
  final bool isGood;

  const _CodeExample({
    required this.title,
    required this.code,
    required this.isGood,
  });

  @override
  Widget build(BuildContext context) {
    final color = isGood ? Colors.green : Colors.red;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isGood ? Icons.check_circle : Icons.cancel,
                color: color.shade700,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              code,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _ConceptItem extends StatelessWidget {
  final String concept;
  final String description;

  const _ConceptItem(this.concept, this.description);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.arrow_right, color: Colors.blue, size: 20),
          const SizedBox(width: 4),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  TextSpan(
                    text: '$concept: ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: description),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 📚 Learning Notes:
//
// 1. SYNCHRONOUS VS ASYNCHRONOUS:
//    - Synchronous: Operations run one after another, blocking the UI
//    - Asynchronous: Operations can run concurrently, keeping UI responsive
//
// 2. FUTURE:
//    - Represents a value that will be available in the future
//    - Like a "promise" or "buzzer" from the coffee shop analogy
//    - Can be in three states: pending, completed, or error
//
// 3. ASYNC/AWAIT:
//    - async: Marks a function as asynchronous
//    - await: Pauses execution until Future completes
//    - Allows writing asynchronous code that looks synchronous
//
// 4. WHY ASYNC MATTERS:
//    - Prevents UI freezing during long operations
//    - Enables responsive user interfaces
//    - Essential for network requests, file I/O, database operations
//
// 5. COMMON PATTERNS:
//    - Sequential: await each operation one by one
//    - Parallel: use Future.wait() to run operations simultaneously
//    - Error handling: use try/catch with async/await
//
// 6. BEST PRACTICES:
//    - Always use async/await for long-running operations
//    - Handle errors with try/catch blocks
//    - Show loading indicators during async operations
//    - Use Future.wait() for parallel operations when possible

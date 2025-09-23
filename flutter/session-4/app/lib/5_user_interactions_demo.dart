import 'package:flutter/material.dart';

// Demo 5: User Interactions and State Management
// This demonstrates various user interaction patterns and state handling

void main() {
  runApp(const UserInteractionsDemo());
}

class UserInteractionsDemo extends StatelessWidget {
  const UserInteractionsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Interactions Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const InteractionsScreen(),
    );
  }
}

class InteractionsScreen extends StatefulWidget {
  const InteractionsScreen({super.key});

  @override
  State<InteractionsScreen> createState() => _InteractionsScreenState();
}

class _InteractionsScreenState extends State<InteractionsScreen> {
  // KEY CONCEPT 1: State Variables for Different Interactions
  int _counter = 0;
  bool _isLiked = false;
  double _sliderValue = 50.0;
  String _selectedChoice = 'None';
  bool _switchValue = false;
  String _textFieldValue = '';
  final List<String> _selectedItems = [];

  // KEY CONCEPT 2: Interaction Handlers
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    _showSnackBar('Counter incremented to $_counter');
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) _counter--;
    });
    _showSnackBar('Counter decremented to $_counter');
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
    });
    _showSnackBar(_isLiked ? 'Liked! ❤️' : 'Unliked 💔');
  }

  void _onSliderChanged(double value) {
    setState(() {
      _sliderValue = value;
    });
  }

  void _onChoiceSelected(String choice) {
    setState(() {
      _selectedChoice = choice;
    });
    _showSnackBar('Selected: $choice');
  }

  void _onSwitchChanged(bool value) {
    setState(() {
      _switchValue = value;
    });
    _showSnackBar('Switch ${value ? 'ON' : 'OFF'}');
  }

  void _onTextChanged(String value) {
    setState(() {
      _textFieldValue = value;
    });
  }

  void _toggleItemSelection(String item) {
    setState(() {
      if (_selectedItems.contains(item)) {
        _selectedItems.remove(item);
      } else {
        _selectedItems.add(item);
      }
    });
  }

  // KEY CONCEPT 3: Feedback Methods
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Dialog Example'),
          content: const Text('This is an example of a dialog box.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showSnackBar('Dialog confirmed!');
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Bottom Sheet Example',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text('This is a modal bottom sheet with options.'),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _showSnackBar('Option 1 selected');
                    },
                    child: const Text('Option 1'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _showSnackBar('Option 2 selected');
                    },
                    child: const Text('Option 2'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Interactions Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: () {
              // Reset all values
              setState(() {
                _counter = 0;
                _isLiked = false;
                _sliderValue = 50.0;
                _selectedChoice = 'None';
                _switchValue = false;
                _textFieldValue = '';
                _selectedItems.clear();
              });
              _showSnackBar('All values reset!');
            },
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset All',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // KEY CONCEPT 4: Counter Example
            _buildSection(
              'Counter Example',
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        '$_counter',
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: _decrementCounter,
                            icon: const Icon(Icons.remove),
                            label: const Text('Decrease'),
                          ),
                          ElevatedButton.icon(
                            onPressed: _incrementCounter,
                            icon: const Icon(Icons.add),
                            label: const Text('Increase'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // KEY CONCEPT 5: Like Button Example
            _buildSection(
              'Like Button Example',
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
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
                      const SizedBox(width: 8),
                      Text(
                        _isLiked ? 'Liked!' : 'Not liked',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // KEY CONCEPT 6: Slider Example
            _buildSection(
              'Slider Example',
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text('Value: ${_sliderValue.round()}'),
                      Slider(
                        value: _sliderValue,
                        min: 0,
                        max: 100,
                        divisions: 10,
                        label: _sliderValue.round().toString(),
                        onChanged: _onSliderChanged,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // KEY CONCEPT 7: Choice Chips Example
            _buildSection(
              'Choice Selection',
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text('Selected: $_selectedChoice'),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8.0,
                        children:
                            ['Flutter', 'Dart', 'Mobile', 'Web', 'Desktop']
                                .map(
                                  (choice) => ChoiceChip(
                                    label: Text(choice),
                                    selected: _selectedChoice == choice,
                                    onSelected: (selected) {
                                      if (selected) _onChoiceSelected(choice);
                                    },
                                  ),
                                )
                                .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // KEY CONCEPT 8: Switch Example
            _buildSection(
              'Switch Example',
              Card(
                child: SwitchListTile(
                  title: const Text('Enable Notifications'),
                  subtitle: const Text('Receive app notifications'),
                  value: _switchValue,
                  onChanged: _onSwitchChanged,
                  secondary: const Icon(Icons.notifications),
                ),
              ),
            ),

            // KEY CONCEPT 9: Text Input Example
            _buildSection(
              'Text Input Example',
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        onChanged: _onTextChanged,
                        decoration: const InputDecoration(
                          labelText: 'Enter your message',
                          hintText: 'Type something here...',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.message),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text('You typed: $_textFieldValue'),
                    ],
                  ),
                ),
              ),
            ),

            // KEY CONCEPT 10: Multi-Selection Example
            _buildSection(
              'Multi-Selection Example',
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Selected: ${_selectedItems.join(', ')}'),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8.0,
                        children:
                            ['Apple', 'Banana', 'Orange', 'Grape', 'Mango']
                                .map(
                                  (item) => FilterChip(
                                    label: Text(item),
                                    selected: _selectedItems.contains(item),
                                    onSelected: (selected) =>
                                        _toggleItemSelection(item),
                                    checkmarkColor: Colors.white,
                                  ),
                                )
                                .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // KEY CONCEPT 11: Dialog and Bottom Sheet Examples
            _buildSection(
              'Modals Example',
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ElevatedButton.icon(
                        onPressed: _showDialog,
                        icon: const Icon(Icons.open_in_new),
                        label: const Text('Show Dialog'),
                      ),
                      const SizedBox(height: 8),
                      OutlinedButton.icon(
                        onPressed: _showBottomSheet,
                        icon: const Icon(Icons.vertical_align_bottom),
                        label: const Text('Show Bottom Sheet'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // KEY CONCEPT 12: Helper Widget for Consistent Layout
  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        content,
        const SizedBox(height: 24),
      ],
    );
  }
}

/*
KEY LEARNING POINTS:

1. STATE MANAGEMENT:
   - Use setState() to update UI after state changes
   - Declare state variables at the class level
   - Initialize with appropriate default values

2. USER INTERACTION TYPES:
   - Tap gestures (buttons, icons)
   - Continuous input (sliders, text fields)
   - Toggle states (switches, checkboxes)
   - Selection (chips, radio buttons)

3. EVENT HANDLERS:
   - Create specific methods for each interaction
   - Update state within setState()
   - Provide immediate feedback to users

4. FEEDBACK MECHANISMS:
   - SnackBar for temporary messages
   - Visual state changes (colors, icons)
   - Dialog boxes for important actions
   - Bottom sheets for options

5. INPUT VALIDATION:
   - Check bounds (counter can't go below 0)
   - Handle edge cases gracefully
   - Provide clear error messages

6. UI PATTERNS:
   - Group related interactions in cards
   - Use consistent spacing and layout
   - Provide clear labels and instructions
   - Make interactive elements obvious

7. BEST PRACTICES:
   - Keep interaction handlers simple
   - Provide immediate visual feedback
   - Use appropriate input widgets for data type
   - Test all interaction paths

8. ACCESSIBILITY:
   - Use semantic labels and tooltips
   - Ensure sufficient contrast
   - Support keyboard navigation
   - Provide alternative input methods
*/

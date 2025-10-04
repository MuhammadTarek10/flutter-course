import 'package:flutter/material.dart';

// 📝 Module 1: The Building Blocks of a Form
//
// This demo introduces the most common input widgets and shows how to manage
// their individual state using controllers and setState.
//
// Key concepts:
// - Forms as "surveys" with different types of questions
// - TextField with InputDecoration
// - CheckboxListTile and SwitchListTile for boolean inputs
// - DropdownButtonFormField for multiple choice
// - State management with controllers and setState

void main() {
  runApp(const FormWidgetsApp());
}

class FormWidgetsApp extends StatelessWidget {
  const FormWidgetsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Widgets Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const FormWidgetSampler(),
    );
  }
}

class FormWidgetSampler extends StatefulWidget {
  const FormWidgetSampler({super.key});

  @override
  State<FormWidgetSampler> createState() => _FormWidgetSamplerState();
}

class _FormWidgetSamplerState extends State<FormWidgetSampler> {
  // 🎛️ Controllers and state variables for each input widget
  final TextEditingController _textFieldController = TextEditingController();
  final TextEditingController _multilineController = TextEditingController();
  bool _isChecked = false;
  bool _isSwitched = false;
  String? _selectedValue;
  double _sliderValue = 50.0;
  RangeValues _rangeValues = const RangeValues(20, 80);

  // 📋 Data for dropdown
  final List<String> _dropdownItems = [
    'Flutter',
    'React Native',
    'Native iOS',
    'Native Android',
    'Xamarin',
    'Ionic',
  ];

  @override
  void dispose() {
    // 🧹 Always dispose controllers to prevent memory leaks
    _textFieldController.dispose();
    _multilineController.dispose();
    super.dispose();
  }

  // 📊 Method to show current state in a dialog
  void _showCurrentState() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Current Form State'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _StateItem(
                'Name',
                _textFieldController.text.isEmpty
                    ? 'Not entered'
                    : _textFieldController.text,
              ),
              _StateItem(
                'Bio',
                _multilineController.text.isEmpty
                    ? 'Not entered'
                    : _multilineController.text,
              ),
              _StateItem(
                'Newsletter',
                _isChecked ? 'Subscribed' : 'Not subscribed',
              ),
              _StateItem('Notifications', _isSwitched ? 'Enabled' : 'Disabled'),
              _StateItem('Framework', _selectedValue ?? 'Not selected'),
              _StateItem('Experience', '${_sliderValue.round()}%'),
              _StateItem(
                'Salary Range',
                '\$${(_rangeValues.start * 1000).round()}K - \$${(_rangeValues.end * 1000).round()}K',
              ),
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

  // 🧹 Method to clear all form data
  void _clearForm() {
    setState(() {
      _textFieldController.clear();
      _multilineController.clear();
      _isChecked = false;
      _isSwitched = false;
      _selectedValue = null;
      _sliderValue = 50.0;
      _rangeValues = const RangeValues(20, 80);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Form cleared!'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Widget Sampler'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: _clearForm,
            icon: const Icon(Icons.clear_all),
            tooltip: 'Clear Form',
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
                        Icon(Icons.quiz, color: Theme.of(context).primaryColor),
                        const SizedBox(width: 8),
                        Text(
                          'Forms as Surveys',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Think of a form as a survey. Flutter gives us different types of questions we can ask: '
                      'open-text questions, yes/no questions, multiple-choice questions, and more!',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 1️⃣ TextField - Open-text input
            _SectionHeader(
              icon: Icons.text_fields,
              title: 'TextField: Open-text Questions',
              description: 'The most basic text input with decoration options',
            ),

            const SizedBox(height: 12),

            TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                hintText: 'Enter your full name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
                helperText: 'This will be displayed on your profile',
              ),
              onChanged: (value) {
                // 🔄 Optional: React to changes in real-time
                print('Name changed to: $value');
              },
            ),

            const SizedBox(height: 16),

            // Multiline TextField
            TextField(
              controller: _multilineController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Bio',
                hintText: 'Tell us about yourself...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.description),
                alignLabelWithHint: true,
              ),
            ),

            const SizedBox(height: 24),

            // 2️⃣ CheckboxListTile - Yes/No questions
            _SectionHeader(
              icon: Icons.check_box,
              title: 'CheckboxListTile: Yes/No Questions',
              description:
                  'Perfect for agreements, preferences, and boolean choices',
            ),

            const SizedBox(height: 12),

            Card(
              child: Column(
                children: [
                  CheckboxListTile(
                    title: const Text('Subscribe to Newsletter'),
                    subtitle: const Text(
                      'Get weekly updates about new features',
                    ),
                    value: _isChecked,
                    onChanged: (bool? newValue) {
                      setState(() {
                        _isChecked = newValue ?? false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    secondary: const Icon(Icons.email),
                  ),
                  if (_isChecked)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.green.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green.shade700,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Great! You\'ll receive our newsletter.',
                            style: TextStyle(color: Colors.green.shade700),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 3️⃣ SwitchListTile - Toggle settings
            _SectionHeader(
              icon: Icons.toggle_on,
              title: 'SwitchListTile: Toggle Settings',
              description: 'Great for enabling/disabling features',
            ),

            const SizedBox(height: 12),

            Card(
              child: SwitchListTile(
                title: const Text('Push Notifications'),
                subtitle: Text(
                  _isSwitched
                      ? 'You\'ll receive notifications'
                      : 'Notifications are disabled',
                ),
                value: _isSwitched,
                onChanged: (bool newValue) {
                  setState(() {
                    _isSwitched = newValue;
                  });
                },
                secondary: Icon(
                  _isSwitched
                      ? Icons.notifications_active
                      : Icons.notifications_off,
                  color: _isSwitched ? Colors.green : Colors.grey,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 4️⃣ DropdownButtonFormField - Multiple choice
            _SectionHeader(
              icon: Icons.arrow_drop_down_circle,
              title: 'DropdownButtonFormField: Multiple Choice',
              description: 'Let users select from predefined options',
            ),

            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              initialValue: _selectedValue,
              decoration: const InputDecoration(
                labelText: 'Preferred Framework',
                hintText: 'Choose your favorite',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.code),
              ),
              items: _dropdownItems.map<DropdownMenuItem<String>>((
                String value,
              ) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Row(
                    children: [
                      _getFrameworkIcon(value),
                      const SizedBox(width: 8),
                      Text(value),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedValue = newValue;
                });
              },
            ),

            const SizedBox(height: 24),

            // 5️⃣ Slider - Numeric input
            _SectionHeader(
              icon: Icons.tune,
              title: 'Slider: Numeric Input',
              description: 'Great for ratings, percentages, and ranges',
            ),

            const SizedBox(height: 12),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Experience Level: ${_sliderValue.round()}%',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Slider(
                      value: _sliderValue,
                      min: 0,
                      max: 100,
                      divisions: 10,
                      label: '${_sliderValue.round()}%',
                      onChanged: (double value) {
                        setState(() {
                          _sliderValue = value;
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Beginner',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          'Expert',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Range Slider
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Salary Range: \$${(_rangeValues.start * 1000).round()}K - \$${(_rangeValues.end * 1000).round()}K',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    RangeSlider(
                      values: _rangeValues,
                      min: 0,
                      max: 200,
                      divisions: 20,
                      labels: RangeLabels(
                        '\$${(_rangeValues.start * 1000).round()}K',
                        '\$${(_rangeValues.end * 1000).round()}K',
                      ),
                      onChanged: (RangeValues values) {
                        setState(() {
                          _rangeValues = values;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // 🎯 Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _showCurrentState,
                    icon: const Icon(Icons.visibility),
                    label: const Text('Show Current State'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _clearForm,
                    icon: const Icon(Icons.clear),
                    label: const Text('Clear Form'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

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
                          'TextEditingController',
                          'Manages text input and provides programmatic control',
                        ),
                        _ConceptItem(
                          'setState()',
                          'Updates the UI when form values change',
                        ),
                        _ConceptItem(
                          'InputDecoration',
                          'Adds labels, hints, icons, and styling to text fields',
                        ),
                        _ConceptItem(
                          'State Management',
                          'Each widget manages its own state independently',
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

  // 🎨 Helper method to get framework icons
  Widget _getFrameworkIcon(String framework) {
    switch (framework) {
      case 'Flutter':
        return const Icon(Icons.flutter_dash, color: Colors.blue);
      case 'React Native':
        return const Icon(Icons.javascript, color: Colors.yellow);
      case 'Native iOS':
        return const Icon(Icons.phone_iphone, color: Colors.black);
      case 'Native Android':
        return const Icon(Icons.android, color: Colors.green);
      default:
        return const Icon(Icons.code, color: Colors.grey);
    }
  }
}

// 🏗️ Helper Widgets

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _SectionHeader({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Theme.of(context).primaryColor),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
        ),
      ],
    );
  }
}

class _StateItem extends StatelessWidget {
  final String label;
  final String value;

  const _StateItem(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
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
// 1. FORM WIDGETS OVERVIEW:
//    - TextField: Basic text input with rich decoration options
//    - CheckboxListTile: Boolean input with title and subtitle
//    - SwitchListTile: Toggle input for settings
//    - DropdownButtonFormField: Single selection from options
//    - Slider/RangeSlider: Numeric input with visual feedback
//
// 2. STATE MANAGEMENT:
//    - Each widget manages its own state
//    - Use setState() to update UI when values change
//    - Controllers provide programmatic access to text fields
//
// 3. TEXTEDITING CONTROLLER:
//    - Provides full control over TextField
//    - Access text with controller.text
//    - Clear text with controller.clear()
//    - Always dispose controllers in dispose() method
//
// 4. INPUT DECORATION:
//    - labelText: Floating label
//    - hintText: Placeholder text
//    - helperText: Additional guidance
//    - prefixIcon/suffixIcon: Visual indicators
//    - border: Input field styling
//
// 5. BEST PRACTICES:
//    - Always dispose controllers
//    - Use appropriate keyboard types
//    - Provide clear labels and hints
//    - Give visual feedback for state changes
//    - Group related inputs logically

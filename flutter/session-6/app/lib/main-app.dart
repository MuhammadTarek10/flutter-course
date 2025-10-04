import 'package:flutter/material.dart';

import '1_form_widgets_demo.dart' as widgets_demo;
import '2_text_validation_demo.dart' as validation_demo;
import '3_login_form_demo.dart' as login_demo;
import '4_registration_form_solution.dart' as registration_demo;

// 📝 Session 6: Building Forms & Handling User Input - Workshop Navigation
//
// This app provides access to all the form building workshops:
// 1. Form Widgets Demo - Building blocks of forms
// 2. Text Validation Demo - Professional text input handling
// 3. Login Form Demo - Form widget with GlobalKey
// 4. Registration Form Solution - Complete homework solution

void main() {
  runApp(const FormsWorkshopApp());
}

class FormsWorkshopApp extends StatelessWidget {
  const FormsWorkshopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Session 6: Forms & User Input',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const WorkshopHomePage(),
    );
  }
}

class WorkshopHomePage extends StatelessWidget {
  const WorkshopHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forms & User Input Workshops'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📋 Session Overview
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.edit_document,
                          color: Theme.of(context).primaryColor,
                          size: 28,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Session 6: Building Forms & Handling User Input',
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Master the art of building professional forms in Flutter. '
                      'Learn input widgets, validation techniques, and form management strategies.',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 🎯 Learning Objectives
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.checklist,
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
                          'Use variety of input widgets (TextField, Checkbox, etc.)',
                        ),
                        _ObjectiveItem(
                          'Manage form state with controllers and setState',
                        ),
                        _ObjectiveItem(
                          'Implement robust user input validation',
                        ),
                        _ObjectiveItem(
                          'Master Form widget and GlobalKey for form management',
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

            // Workshop 1: Form Widgets
            _WorkshopCard(
              title: '1. Form Widget Sampler',
              subtitle: 'Building blocks of forms',
              description:
                  'Explore different input widgets like TextField, Checkbox, Switch, '
                  'and DropdownButton. Learn how to manage their state individually.',
              icon: Icons.widgets,
              color: Colors.blue,
              concepts: const [
                'TextField & InputDecoration',
                'CheckboxListTile',
                'SwitchListTile',
                'DropdownButtonFormField',
                'Sliders & Range inputs',
                'State management',
              ],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const widgets_demo.FormWidgetSampler(),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            // Workshop 2: Text Validation
            _WorkshopCard(
              title: '2. Text Input & Validation',
              subtitle: 'Professional text handling',
              description:
                  'Deep dive into TextEditingController and validation. '
                  'Learn TextFormField, validation functions, and input formatting.',
              icon: Icons.verified_user,
              color: Colors.green,
              concepts: const [
                'TextEditingController',
                'TextFormField vs TextField',
                'Validation functions',
                'Input formatters',
                'Keyboard types',
                'Password visibility',
              ],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const validation_demo.TextValidationDemo(),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            // Workshop 3: Login Form
            _WorkshopCard(
              title: '3. Login Form with GlobalKey',
              subtitle: 'Form widget as team captain',
              description:
                  'Learn how Form widget manages multiple fields at once. '
                  'Master GlobalKey, form validation, and data collection.',
              icon: Icons.login,
              color: Colors.purple,
              concepts: const [
                'Form widget',
                'GlobalKey<FormState>',
                'form.validate()',
                'form.save()',
                'onSaved callbacks',
                'Centralized form management',
              ],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const login_demo.LoginFormDemo(),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            // Workshop 4: Registration Form
            _WorkshopCard(
              title: '4. Registration Form Solution',
              subtitle: 'Complete homework implementation',
              description:
                  'See the complete solution for the registration form homework. '
                  'Includes all required fields, validation, and professional UI.',
              icon: Icons.assignment_turned_in,
              color: Colors.teal,
              concepts: const [
                'Complete form implementation',
                'Custom validation logic',
                'Professional UI design',
                'Loading states',
                'Success feedback',
                'Form reset functionality',
              ],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const registration_demo.RegistrationForm(),
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            // 💡 Form Development Flow
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
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
                          'Form Development Flow',
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
                          'Choose Input Widgets',
                          'Select appropriate widgets for your data types',
                        ),
                        _FlowStep(
                          '2',
                          'Add Controllers',
                          'Create TextEditingControllers for text fields',
                        ),
                        _FlowStep(
                          '3',
                          'Implement Validation',
                          'Add validator functions to TextFormFields',
                        ),
                        _FlowStep(
                          '4',
                          'Wrap in Form',
                          'Use Form widget with GlobalKey for management',
                        ),
                        _FlowStep(
                          '5',
                          'Handle Submission',
                          'Validate, save, and process form data',
                        ),
                        _FlowStep(
                          '6',
                          'Provide Feedback',
                          'Show loading states and success/error messages',
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
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star, color: Theme.of(context).primaryColor),
                        const SizedBox(width: 8),
                        Text(
                          'Form Best Practices',
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
                          'Always dispose TextEditingControllers',
                        ),
                        _BestPracticeItem(
                          'Use appropriate keyboard types for input',
                        ),
                        _BestPracticeItem(
                          'Provide clear, helpful error messages',
                        ),
                        _BestPracticeItem(
                          'Show loading states during form submission',
                        ),
                        _BestPracticeItem(
                          'Validate before processing form data',
                        ),
                        _BestPracticeItem(
                          'Give users feedback on success/failure',
                        ),
                        _BestPracticeItem(
                          'Use input formatters to guide user input',
                        ),
                        _BestPracticeItem('Group related fields logically'),
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
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_forward,
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
                      '1. Complete the registration form homework assignment\n'
                      '2. Practice building forms for different use cases\n'
                      '3. Experiment with custom input widgets\n'
                      '4. Learn about advanced form libraries (flutter_form_builder)\n'
                      '5. Explore form state management with Provider or Bloc',
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

// Helper Widgets

class _ObjectiveItem extends StatelessWidget {
  final String text;

  const _ObjectiveItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 20),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

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
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: color, size: 28),
                  ),
                  const SizedBox(width: 16),
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
                  Icon(Icons.arrow_forward_ios, color: Colors.grey[400]),
                ],
              ),
              const SizedBox(height: 16),
              Text(description),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: concepts.map((concept) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: color.withOpacity(0.3)),
                    ),
                    child: Text(
                      concept,
                      style: TextStyle(
                        color: color,
                        fontSize: 12,
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
                  style: const TextStyle(fontWeight: FontWeight.bold),
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
          const Icon(Icons.check_circle, color: Colors.green, size: 16),
          const SizedBox(width: 8),
          Expanded(child: Text(practice, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}

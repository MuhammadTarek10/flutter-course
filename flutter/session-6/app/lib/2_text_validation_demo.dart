import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📝 Module 2: Mastering Text Input & Validation
//
// This demo does a deep dive into handling text input professionally
// with controllers and validation using TextFormField.
//
// Key concepts:
// - TextEditingController for full control over text fields
// - TextFormField vs TextField
// - Validation functions that return null (valid) or String (error)
// - Form widget for managing multiple fields
// - Input formatters and keyboard types

void main() {
  runApp(const TextValidationApp());
}

class TextValidationApp extends StatelessWidget {
  const TextValidationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Input & Validation',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const TextValidationDemo(),
    );
  }
}

class TextValidationDemo extends StatefulWidget {
  const TextValidationDemo({super.key});

  @override
  State<TextValidationDemo> createState() => _TextValidationDemoState();
}

class _TextValidationDemoState extends State<TextValidationDemo> {
  // 🎛️ Form key for managing the entire form
  final _formKey = GlobalKey<FormState>();

  // 📝 Controllers for each text field
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();

  // 🔒 Password visibility toggles
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  // 📊 Form submission state
  bool _isSubmitting = false;

  @override
  void dispose() {
    // 🧹 Dispose all controllers
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _ageController.dispose();
    _websiteController.dispose();
    super.dispose();
  }

  // ✅ Validation methods
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return 'Name can only contain letters and spaces';
    }
    return null; // Valid
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }

    // More comprehensive email validation
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }

    // Remove all non-digit characters for validation
    final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');

    if (digitsOnly.length < 10) {
      return 'Phone number must be at least 10 digits';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
      return 'Password must contain at least one number';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? _validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your age';
    }

    final age = int.tryParse(value);
    if (age == null) {
      return 'Please enter a valid number';
    }
    if (age < 13) {
      return 'You must be at least 13 years old';
    }
    if (age > 120) {
      return 'Please enter a realistic age';
    }
    return null;
  }

  String? _validateWebsite(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Optional field
    }

    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );

    if (!urlRegex.hasMatch(value)) {
      return 'Please enter a valid URL (e.g., https://example.com)';
    }
    return null;
  }

  // 📤 Form submission
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isSubmitting = false;
      });

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Form Submitted Successfully!',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text('Name: ${_nameController.text}'),
                Text('Email: ${_emailController.text}'),
                Text('Phone: ${_phoneController.text}'),
                Text('Age: ${_ageController.text}'),
                if (_websiteController.text.isNotEmpty)
                  Text('Website: ${_websiteController.text}'),
              ],
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 4),
          ),
        );

        // Clear form
        _formKey.currentState!.reset();
        _clearControllers();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please correct the errors in the form'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _clearControllers() {
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    _ageController.clear();
    _websiteController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Input & Validation'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
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
                            Icons.verified_user,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Professional Text Validation',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'TextFormField provides powerful validation capabilities. '
                        'The validator function returns null for valid input or an error message string for invalid input.',
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 👤 Name Field
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name *',
                  hintText: 'Enter your full name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                  helperText: 'Letters and spaces only',
                ),
                textCapitalization: TextCapitalization.words,
                validator: _validateName,
              ),

              const SizedBox(height: 16),

              // 📧 Email Field
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email Address *',
                  hintText: 'example@domain.com',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: _validateEmail,
              ),

              const SizedBox(height: 16),

              // 📱 Phone Field
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number *',
                  hintText: '(555) 123-4567',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[\d\s\-\(\)\+]')),
                ],
                validator: _validatePhone,
              ),

              const SizedBox(height: 16),

              // 🔢 Age Field
              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Age *',
                  hintText: 'Enter your age',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.cake),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3),
                ],
                validator: _validateAge,
              ),

              const SizedBox(height: 16),

              // 🔒 Password Field
              TextFormField(
                controller: _passwordController,
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  labelText: 'Password *',
                  hintText: 'At least 8 characters',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                  helperText: 'Must contain uppercase, lowercase, and number',
                  helperMaxLines: 2,
                ),
                validator: _validatePassword,
                onChanged: (value) {
                  // Trigger validation for confirm password when password changes
                  if (_confirmPasswordController.text.isNotEmpty) {
                    _formKey.currentState!.validate();
                  }
                },
              ),

              const SizedBox(height: 16),

              // 🔒 Confirm Password Field
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: !_confirmPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Confirm Password *',
                  hintText: 'Re-enter your password',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _confirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _confirmPasswordVisible = !_confirmPasswordVisible;
                      });
                    },
                  ),
                ),
                validator: _validateConfirmPassword,
              ),

              const SizedBox(height: 16),

              // 🌐 Website Field (Optional)
              TextFormField(
                controller: _websiteController,
                keyboardType: TextInputType.url,
                decoration: const InputDecoration(
                  labelText: 'Website (Optional)',
                  hintText: 'https://example.com',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.language),
                ),
                validator: _validateWebsite,
              ),

              const SizedBox(height: 32),

              // 🎯 Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: _isSubmitting
                      ? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                            SizedBox(width: 12),
                            Text('Submitting...'),
                          ],
                        )
                      : const Text(
                          'Submit Form',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 24),

              // 💡 Validation Tips Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.tips_and_updates,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Validation Best Practices',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _ValidationTip('Return null for valid input'),
                          _ValidationTip(
                            'Return error message string for invalid input',
                          ),
                          _ValidationTip('Use appropriate keyboard types'),
                          _ValidationTip(
                            'Add input formatters to restrict input',
                          ),
                          _ValidationTip('Provide clear error messages'),
                          _ValidationTip('Use helper text for guidance'),
                          _ValidationTip('Validate related fields together'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // 🔧 Technical Details Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.code,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'TextFormField vs TextField',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _ComparisonRow(
                            'TextFormField',
                            'Has validator property, works with Form widget',
                          ),
                          _ComparisonRow(
                            'TextField',
                            'Basic text input, no built-in validation',
                          ),
                          _ComparisonRow(
                            'Form.validate()',
                            'Calls validator on all TextFormFields',
                          ),
                          _ComparisonRow(
                            'GlobalKey<FormState>',
                            'Provides access to form methods',
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
      ),
    );
  }
}

// 🏗️ Helper Widgets

class _ValidationTip extends StatelessWidget {
  final String tip;

  const _ValidationTip(this.tip);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 16),
          const SizedBox(width: 8),
          Expanded(child: Text(tip, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}

class _ComparisonRow extends StatelessWidget {
  final String feature;
  final String description;

  const _ComparisonRow(this.feature, this.description);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              feature,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(description)),
        ],
      ),
    );
  }
}

// 📚 Learning Notes:
//
// 1. TEXTFORMFIELD VS TEXTFIELD:
//    - TextFormField: Has validator property, designed for forms
//    - TextField: Basic text input without built-in validation
//    - Use TextFormField when you need validation
//
// 2. VALIDATION FUNCTION:
//    - Takes String? value as parameter
//    - Returns null if valid
//    - Returns String error message if invalid
//    - Called when form.validate() is invoked
//
// 3. TEXTEDITING CONTROLLER:
//    - Provides programmatic control over text fields
//    - Access text with controller.text
//    - Clear with controller.clear()
//    - Listen to changes with controller.addListener()
//
// 4. INPUT FORMATTERS:
//    - FilteringTextInputFormatter: Allow/deny specific characters
//    - LengthLimitingTextInputFormatter: Limit input length
//    - Custom formatters for specific formats (phone, credit card, etc.)
//
// 5. KEYBOARD TYPES:
//    - TextInputType.text: Default keyboard
//    - TextInputType.emailAddress: Email keyboard with @ symbol
//    - TextInputType.phone: Numeric keyboard with phone symbols
//    - TextInputType.number: Pure numeric keyboard
//    - TextInputType.url: URL keyboard with .com key
//
// 6. FORM VALIDATION FLOW:
//    - User fills form fields
//    - User taps submit button
//    - _formKey.currentState!.validate() is called
//    - Each TextFormField's validator is executed
//    - If all return null, form is valid
//    - If any return String, form is invalid and errors are shown
//
// 7. BEST PRACTICES:
//    - Always dispose controllers
//    - Use appropriate keyboard types
//    - Provide clear, helpful error messages
//    - Use input formatters to guide user input
//    - Validate related fields together (password confirmation)
//    - Show loading states during submission

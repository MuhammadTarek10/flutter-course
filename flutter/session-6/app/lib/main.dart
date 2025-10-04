import 'package:flutter/material.dart';

// 🎯 Module 4: Complete Registration Form - Homework Solution
//
// This is the complete solution for the homework assignment.
// It demonstrates all the concepts from the previous modules in a
// comprehensive registration form.
//
// Features:
// - All required form fields with validation
// - Custom checkbox validation
// - Professional UI design
// - Loading states and feedback
// - Form reset functionality

void main() {
  runApp(const RegistrationApp());
}

class RegistrationApp extends StatelessWidget {
  const RegistrationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration Form',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const RegistrationForm(),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  // 🔑 Form key for managing the entire form
  final _formKey = GlobalKey<FormState>();

  // 📊 Form data variables
  String _fullName = '';
  String _email = '';
  String _password = '';
  String? _selectedCountry;
  bool _agreedToTerms = false;

  // 🌍 Country options
  final List<String> _countries = [
    'United States',
    'Canada',
    'United Kingdom',
    'Australia',
    'Germany',
    'France',
    'Japan',
    'Brazil',
    'India',
    'Egypt',
    'South Africa',
    'Mexico',
    'Other',
  ];

  // 🔒 Password visibility
  bool _passwordVisible = false;

  // 📤 Loading state
  bool _isRegistering = false;

  // ✅ Registration method
  Future<void> _register() async {
    // First, check if terms are agreed (custom validation)
    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You must agree to the terms and conditions'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Validate all form fields
    if (_formKey.currentState!.validate()) {
      // Save form data
      _formKey.currentState!.save();

      // Show loading state
      setState(() {
        _isRegistering = true;
      });

      // Simulate API call
      await Future.delayed(const Duration(seconds: 3));

      setState(() {
        _isRegistering = false;
      });

      // Show success
      if (mounted) {
        _showRegistrationSuccess();
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

  void _showRegistrationSuccess() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.celebration, color: Colors.green, size: 28),
            SizedBox(width: 12),
            Text('Registration Successful!'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome to our platform! Here\'s your registration summary:',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              _SummaryItem('Full Name', _fullName),
              _SummaryItem('Email', _email),
              _SummaryItem('Country', _selectedCountry ?? 'Not specified'),
              _SummaryItem('Terms Accepted', _agreedToTerms ? 'Yes' : 'No'),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green.shade700),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'A confirmation email has been sent to $_email',
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetForm();
            },
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    setState(() {
      _fullName = '';
      _email = '';
      _password = '';
      _selectedCountry = null;
      _agreedToTerms = false;
      _passwordVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: _resetForm,
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset Form',
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 🎨 Header Section
              Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withAlpha(2),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Icon(
                      Icons.person_add,
                      size: 40,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Join Our Community',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Create your account to get started',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // 👤 Full Name Field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Full Name *',
                  hintText: 'Enter your full name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person_outline),
                ),
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  if (value.trim().length < 2) {
                    return 'Name must be at least 2 characters';
                  }
                  if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                    return 'Name can only contain letters and spaces';
                  }
                  return null;
                },
                onSaved: (value) {
                  _fullName = value?.trim() ?? '';
                },
              ),

              const SizedBox(height: 16),

              // 📧 Email Field
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email Address *',
                  hintText: 'example@domain.com',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email address';
                  }

                  final emailRegex = RegExp(
                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                  );

                  if (!emailRegex.hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value?.trim() ?? '';
                },
              ),

              const SizedBox(height: 16),

              // 🔒 Password Field
              TextFormField(
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  labelText: 'Password *',
                  hintText: 'Create a strong password',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock_outline),
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
                  helperText:
                      'At least 8 characters with uppercase, lowercase, and number',
                  helperMaxLines: 2,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  if (RegExp(r'(?=.*[a-z])').hasMatch(value) == false) {
                    return 'Password must contain at least one lowercase letter';
                  }
                  if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
                    return 'Password must contain at least one uppercase letter';
                  }
                  if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
                    return 'Password must contain at least one number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value ?? '';
                },
              ),

              const SizedBox(height: 16),

              // 🌍 Country Dropdown
              DropdownButtonFormField<String>(
                initialValue: _selectedCountry,
                decoration: const InputDecoration(
                  labelText: 'Country *',
                  hintText: 'Select your country',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.public),
                ),
                items: _countries.map((String country) {
                  return DropdownMenuItem<String>(
                    value: country,
                    child: Text(country),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCountry = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your country';
                  }
                  return null;
                },
                onSaved: (value) {
                  _selectedCountry = value;
                },
              ),

              const SizedBox(height: 24),

              // ✅ Terms and Conditions
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CheckboxListTile(
                        title: const Text(
                          'I agree to the Terms and Conditions',
                        ),
                        subtitle: const Text('Required to create an account'),
                        value: _agreedToTerms,
                        onChanged: (bool? value) {
                          setState(() {
                            _agreedToTerms = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      ),
                      if (!_agreedToTerms)
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16.0,
                            bottom: 8.0,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                size: 16,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'You must agree to continue',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // 🚀 Register Button
              ElevatedButton(
                onPressed: _isRegistering ? null : _register,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                ),
                child: _isRegistering
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Text('Creating Account...'),
                        ],
                      )
                    : const Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),

              const SizedBox(height: 16),

              // 🔗 Sign In Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Sign in feature would go here'),
                        ),
                      );
                    },
                    child: const Text('Sign In'),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // 📋 Form Requirements Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
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
                            'Registration Requirements',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _RequirementItem(
                            'Full name (letters and spaces only)',
                          ),
                          _RequirementItem('Valid email address'),
                          _RequirementItem(
                            'Strong password (8+ chars, mixed case, number)',
                          ),
                          _RequirementItem('Country selection'),
                          _RequirementItem('Agreement to terms and conditions'),
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

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryItem(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class _RequirementItem extends StatelessWidget {
  final String requirement;

  const _RequirementItem(this.requirement);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline, color: Colors.green, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(requirement, style: const TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }
}

// 📚 Learning Notes:
//
// 1. COMPLETE FORM IMPLEMENTATION:
//    - All required fields with proper validation
//    - Custom validation for checkbox (not a TextFormField)
//    - Professional UI with clear visual hierarchy
//    - Loading states and user feedback
//
// 2. VALIDATION STRATEGIES:
//    - TextFormField validation for form fields
//    - Custom validation for non-form widgets (checkbox)
//    - Comprehensive validation rules (regex, length, etc.)
//    - Clear, helpful error messages
//
// 3. USER EXPERIENCE:
//    - Visual feedback for all actions
//    - Loading states during submission
//    - Success dialog with summary
//    - Form reset functionality
//    - Clear requirements explanation
//
// 4. FORM STRUCTURE:
//    - Logical field grouping
//    - Consistent spacing and styling
//    - Appropriate input types and keyboards
//    - Helper text for complex requirements
//
// 5. DATA HANDLING:
//    - Form validation before processing
//    - Data collection via onSaved callbacks
//    - Proper state management
//    - Clean form reset after success
//
// 6. ACCESSIBILITY:
//    - Clear labels and hints
//    - Proper semantic structure
//    - Visual indicators for required fields
//    - Helpful error messages
//
// 7. HOMEWORK REQUIREMENTS MET:
//    ✅ Full Name TextFormField with validation
//    ✅ Email TextFormField with validation
//    ✅ Password TextFormField with validation
//    ✅ Country DropdownButtonFormField
//    ✅ Terms CheckboxListTile with validation
//    ✅ Single Form widget with GlobalKey
//    ✅ Complete validation for all fields
//    ✅ Register button with form validation
//    ✅ Success feedback on valid submission

import 'package:flutter/material.dart';

// 📝 Module 3: The Form Widget - The Team Captain
//
// This demo shows how to use the Form widget with GlobalKey to manage
// validation and submission for the entire form at once.
//
// Key concepts:
// - Form widget as the "team captain"
// - GlobalKey<FormState> for form management
// - form.validate() to check all fields at once
// - form.save() to collect all field data
// - onSaved callbacks for data collection

void main() {
  runApp(const LoginFormApp());
}

class LoginFormApp extends StatelessWidget {
  const LoginFormApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Form Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginFormDemo(),
    );
  }
}

class LoginFormDemo extends StatefulWidget {
  const LoginFormDemo({super.key});

  @override
  State<LoginFormDemo> createState() => _LoginFormDemoState();
}

class _LoginFormDemoState extends State<LoginFormDemo> {
  // 🔑 The GlobalKey - Our "permanent ID card" for the Form
  // This key allows us to access the Form's state from anywhere,
  // specifically to validate and save all fields at once
  final _formKey = GlobalKey<FormState>();

  // 📊 Variables to store the form data
  String _email = '';
  String _password = '';
  bool _rememberMe = false;

  // 🔒 Password visibility
  bool _passwordVisible = false;

  // 📤 Loading state
  bool _isLoading = false;

  // ✅ Login method - The "Team Captain" in action
  Future<void> _login() async {
    // Step 1: Validate the entire form
    // This calls the validator function for every TextFormField inside this Form
    if (_formKey.currentState!.validate()) {
      // Step 2: Save the form data
      // This calls the onSaved callback for every TextFormField
      _formKey.currentState!.save();

      // Step 3: Show loading state
      setState(() {
        _isLoading = true;
      });

      // Step 4: Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      // Step 5: Show success and navigate or handle result
      if (mounted) {
        _showSuccessDialog();
      }
    } else {
      // Form is invalid - errors are automatically shown by TextFormField
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please correct the errors above'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 8),
            Text('Login Successful!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Welcome back! Here\'s what we collected:'),
            const SizedBox(height: 16),
            _InfoRow('Email', _email),
            _InfoRow('Password', '•' * _password.length),
            _InfoRow('Remember Me', _rememberMe ? 'Yes' : 'No'),
          ],
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
      _email = '';
      _password = '';
      _rememberMe = false;
      _passwordVisible = false;
    });
  }

  // 🔄 Demo method to show form state
  void _showFormState() {
    // Check if form is valid without showing errors
    final isValid = _formKey.currentState?.validate() ?? false;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Current Form State'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _InfoRow('Form Valid', isValid ? 'Yes' : 'No'),
            _InfoRow(
              'Current Email',
              _email.isEmpty ? 'Not saved yet' : _email,
            ),
            _InfoRow(
              'Current Password',
              _password.isEmpty ? 'Not saved yet' : '•' * _password.length,
            ),
            _InfoRow('Remember Me', _rememberMe ? 'Yes' : 'No'),
            const SizedBox(height: 16),
            const Text(
              'Note: Data is only saved to variables when form.save() is called (usually on submit).',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Form - Team Captain'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: _showFormState,
            icon: const Icon(Icons.info_outline),
            tooltip: 'Show Form State',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
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
                          Icons.supervisor_account,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Form Widget as Team Captain',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'The Form widget acts as a "team captain" that can validate and save all its TextFormField children at once. '
                      'The GlobalKey gives us a permanent ID to access the form from anywhere.',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // 🏠 Login Form
            Form(
              // Step 1: Assign the GlobalKey to the Form
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 🎨 Welcome Header
                  Text(
                    'Welcome Back!',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Sign in to your account',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 32),

                  // 📧 Email Field
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                      hintText: 'Enter your email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    // Validator: Returns null if valid, error string if invalid
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@') || !value.contains('.')) {
                        return 'Please enter a valid email address';
                      }
                      return null; // Valid!
                    },
                    // onSaved: Called when _formKey.currentState!.save() is invoked
                    onSaved: (value) {
                      _email = value ?? '';
                    },
                  ),

                  const SizedBox(height: 16),

                  // 🔒 Password Field
                  TextFormField(
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.lock_outlined),
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
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _password = value ?? '';
                    },
                  ),

                  const SizedBox(height: 16),

                  // ✅ Remember Me Checkbox
                  CheckboxListTile(
                    title: const Text('Remember me'),
                    subtitle: const Text('Stay signed in on this device'),
                    value: _rememberMe,
                    onChanged: (bool? value) {
                      setState(() {
                        _rememberMe = value ?? false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                  ),

                  const SizedBox(height: 32),

                  // 🚀 Login Button
                  ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    child: _isLoading
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
                              Text('Signing In...'),
                            ],
                          )
                        : const Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),

                  const SizedBox(height: 16),

                  // 🔗 Additional Actions
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Forgot password feature would go here',
                              ),
                            ),
                          );
                        },
                        child: const Text('Forgot Password?'),
                      ),
                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Sign up feature would go here'),
                            ),
                          );
                        },
                        child: const Text('Create Account'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

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
                          Icons.engineering,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'How the Team Captain Works',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _TechnicalStep(
                          '1',
                          'GlobalKey<FormState> created',
                          'Provides unique ID for the Form',
                        ),
                        _TechnicalStep(
                          '2',
                          'Key assigned to Form widget',
                          'Form becomes accessible via the key',
                        ),
                        _TechnicalStep(
                          '3',
                          'TextFormFields added as children',
                          'Each field has validator and onSaved',
                        ),
                        _TechnicalStep(
                          '4',
                          'form.validate() called',
                          'Runs all validators, shows errors if any',
                        ),
                        _TechnicalStep(
                          '5',
                          'form.save() called',
                          'Runs all onSaved callbacks if valid',
                        ),
                        _TechnicalStep(
                          '6',
                          'Data processed',
                          'Use collected data for API calls, navigation, etc.',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 💡 Best Practices Card
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
                          'Form Best Practices',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _BestPractice('Always validate before saving'),
                        _BestPractice('Use onSaved for data collection'),
                        _BestPractice('Show loading states during submission'),
                        _BestPractice('Provide clear success/error feedback'),
                        _BestPractice('Reset form after successful submission'),
                        _BestPractice('Use appropriate keyboard types'),
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

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow(this.label, this.value);

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

class _TechnicalStep extends StatelessWidget {
  final String step;
  final String title;
  final String description;

  const _TechnicalStep(this.step, this.title, this.description);

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

class _BestPractice extends StatelessWidget {
  final String practice;

  const _BestPractice(this.practice);

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

// 📚 Learning Notes:
//
// 1. GLOBALKEY<FORMSTATE>:
//    - Provides unique identifier for Form widget
//    - Allows access to form methods from anywhere
//    - Created once and assigned to Form's key property
//    - Access via _formKey.currentState!
//
// 2. FORM VALIDATION FLOW:
//    - User fills form and taps submit
//    - _formKey.currentState!.validate() is called
//    - Each TextFormField's validator function runs
//    - If all return null, validation passes
//    - If any return String, validation fails and errors show
//
// 3. FORM SAVE FLOW:
//    - Only called if validation passes
//    - _formKey.currentState!.save() is called
//    - Each TextFormField's onSaved callback runs
//    - Data is collected into state variables
//    - Ready for processing (API calls, navigation, etc.)
//
// 4. VALIDATOR FUNCTION:
//    - Takes String? value parameter
//    - Returns null for valid input
//    - Returns String error message for invalid input
//    - Automatically displays errors below field
//
// 5. ONSAVED CALLBACK:
//    - Called only when form.save() is invoked
//    - Used to collect field data into variables
//    - Only runs if validation passes
//    - Receives the current field value
//
// 6. FORM WIDGET BENEFITS:
//    - Centralized validation management
//    - Batch operations on all fields
//    - Consistent error handling
//    - Clean separation of validation and data collection
//
// 7. COMMON PATTERNS:
//    - Validate → Save → Process → Show Result
//    - Show loading states during processing
//    - Reset form after successful submission
//    - Provide clear feedback to users

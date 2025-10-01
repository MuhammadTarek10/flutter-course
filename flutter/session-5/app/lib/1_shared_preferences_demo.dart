import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 🎯 Module 1: Shared Preferences - Theme Switcher Demo
//
// This demo shows how to use shared_preferences to persist simple data
// like user preferences across app launches.
//
// Key concepts:
// - Why local storage matters (app amnesia problem)
// - shared_preferences as a simple "notepad" for your app
// - Saving and loading boolean values
// - Persisting theme choice between app launches

void main() {
  runApp(const ThemeSwitcherApp());
}

class ThemeSwitcherApp extends StatefulWidget {
  const ThemeSwitcherApp({super.key});

  @override
  State<ThemeSwitcherApp> createState() => _ThemeSwitcherAppState();
}

class _ThemeSwitcherAppState extends State<ThemeSwitcherApp> {
  bool _isDarkMode = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  // 📖 Load the saved theme preference when app starts
  _loadThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get the saved value, default to false if not found
    bool isDarkMode = prefs.getBool('isDarkMode') ?? false;

    setState(() {
      _isDarkMode = isDarkMode;
      _isLoading = false;
    });

    print('🔄 Loaded theme preference: ${isDarkMode ? 'Dark' : 'Light'} mode');
  }

  // 💾 Save the theme preference when user toggles
  _saveThemePreference(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);

    print('💾 Saved theme preference: ${value ? 'Dark' : 'Light'} mode');
  }

  // 🔄 Toggle between light and dark theme
  _toggleTheme(bool value) {
    setState(() {
      _isDarkMode = value;
    });
    _saveThemePreference(value);
  }

  @override
  Widget build(BuildContext context) {
    // Show loading indicator while loading preferences
    if (_isLoading) {
      return const MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }

    return MaterialApp(
      title: 'Theme Switcher Demo',
      // 🎨 Apply theme based on saved preference
      theme: _isDarkMode ? _darkTheme : _lightTheme,
      home: ThemeSwitcherHomePage(
        isDarkMode: _isDarkMode,
        onThemeChanged: _toggleTheme,
      ),
    );
  }

  // 🌞 Light theme configuration
  ThemeData get _lightTheme => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
  );

  // 🌙 Dark theme configuration
  ThemeData get _darkTheme => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[900],
      foregroundColor: Colors.white,
    ),
  );
}

class ThemeSwitcherHomePage extends StatelessWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;

  const ThemeSwitcherHomePage({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Theme Switcher'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📋 Explanation Card
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
                          'About This Demo',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'This app demonstrates how to use shared_preferences to save simple data like user preferences. Your theme choice is automatically saved and restored when you restart the app.',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // 🎛️ Theme Switch Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          isDarkMode ? Icons.dark_mode : Icons.light_mode,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Theme Settings',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Theme Toggle Switch
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dark Mode',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              isDarkMode ? 'Enabled' : 'Disabled',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                        Switch(value: isDarkMode, onChanged: onThemeChanged),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // 🔄 Test Instructions
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.science,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Try This!',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '1. Toggle the theme switch above\n'
                      '2. Close the app completely\n'
                      '3. Reopen the app\n'
                      '4. Notice your theme choice is remembered!',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // 🧠 Behind the Scenes
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.psychology,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Behind the Scenes',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Current theme: ${isDarkMode ? 'Dark' : 'Light'}\n'
                      'Stored key: "isDarkMode"\n'
                      'Stored value: $isDarkMode',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(fontFamily: 'monospace'),
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

// 📚 Learning Notes:
//
// 1. SHARED PREFERENCES BASICS:
//    - Think of it as a simple "notepad" for your app
//    - Perfect for saving simple settings and preferences
//    - Uses key-value pairs (like a dictionary)
//    - Data persists between app launches
//
// 2. COMMON USE CASES:
//    - User preferences (theme, language, notifications)
//    - Simple settings (sound on/off, tutorial completed)
//    - High scores or simple game state
//    - User's name or basic profile info
//
// 3. WHAT NOT TO STORE:
//    - Large amounts of data (use databases instead)
//    - Complex objects (use Hive or JSON files)
//    - Sensitive information (use secure storage)
//
// 4. KEY METHODS:
//    - getBool(), getString(), getInt(), getDouble()
//    - setBool(), setString(), setInt(), setDouble()
//    - remove() to delete a key
//    - clear() to delete all data
//
// 5. ASYNC/AWAIT:
//    - SharedPreferences operations are asynchronous
//    - Always use await when getting/setting values
//    - Handle loading states in your UI

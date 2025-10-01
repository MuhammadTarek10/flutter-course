# 📱 Session 5: Local Storage Workshops

This Flutter app contains three comprehensive workshops demonstrating different approaches to local data storage in Flutter applications.

## 🎯 What You'll Learn

- **SharedPreferences**: Simple key-value storage for user preferences
- **Hive NoSQL Database**: Fast object storage with code generation
- **SQLite Database**: Structured relational database with SQL queries
- **Data Persistence**: How to save and retrieve data across app launches
- **UI Reactivity**: Automatic UI updates when data changes

## 🛠️ Setup Instructions

### 1. Install Dependencies

```bash
# Navigate to the app directory
cd flutter/session-5/app

# Install all dependencies
flutter pub get
```

### 2. Generate Hive Type Adapters (Required for Hive Workshop)

```bash
# Generate the Note model adapter
flutter packages pub run build_runner build

# If you make changes to the Note model later, use:
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### 3. Run the App

```bash
# Start the app
flutter run

# Or run on a specific device
flutter run -d chrome  # For web
flutter run -d ios     # For iOS simulator
flutter run -d android # For Android emulator
```

## 📚 Workshop Structure

### 🏠 Main Navigation (`main.dart`)

- Workshop selection menu
- Learning objectives overview
- Storage solutions comparison
- Navigation to individual workshops

### 1️⃣ SharedPreferences Demo (`1_shared_preferences_demo.dart`)

**Theme Switcher Application**

- Toggle between light and dark themes
- Save theme preference automatically
- Restore theme on app restart
- Demonstrate "app amnesia" problem and solution

**Key Concepts:**

- Async operations with SharedPreferences
- Loading and saving simple data types
- UI state management
- Theme persistence

### 2️⃣ Hive NoSQL Demo (`2_hive_notes_demo.dart`)

**Quick Notes Application**

- Add, edit, and view notes
- Real-time UI updates with ValueListenableBuilder
- Object storage with type adapters
- Fast read/write operations

**Key Concepts:**

- NoSQL database principles
- Hive boxes as "filing cabinets"
- Type adapters and code generation
- Reactive UI with database changes
- CRUD operations (Create, Read, Update, Delete\*)

\*Delete functionality is part of the homework assignment

### 3️⃣ SQLite Demo (`3_sqflite_notes_demo.dart`)

**SQL Notes Application**

- Same functionality as Hive demo but using SQL
- Raw SQL queries for all operations
- Database schema management
- Search functionality

**Key Concepts:**

- SQL database principles
- Table creation and schema design
- Raw SQL queries (CREATE, INSERT, SELECT, UPDATE, DELETE)
- Database helper patterns
- Structured data relationships

## 📁 Project Structure

```
lib/
├── main.dart                          # Navigation and workshop selection
├── 1_shared_preferences_demo.dart     # Theme switcher workshop
├── 2_hive_notes_demo.dart            # Hive NoSQL workshop
├── 3_sqflite_notes_demo.dart         # SQLite SQL workshop
└── models/
    ├── note.dart                     # Note model for Hive
    └── note.g.dart                   # Generated Hive adapter
```

## 🔧 Dependencies Used

```yaml
dependencies:
  # Local Storage
  shared_preferences: ^2.2.2 # Simple key-value storage
  hive: ^2.2.3 # NoSQL database
  hive_flutter: ^1.1.0 # Hive Flutter integration
  sqflite: ^2.3.0 # SQLite database
  path: ^1.8.3 # Path utilities

dev_dependencies:
  # Code Generation (for Hive)
  hive_generator: ^2.0.1 # Generates type adapters
  build_runner: ^2.4.7 # Code generation runner
```

## 🚀 Getting Started Guide

### For Instructors

1. **Start with SharedPreferences Demo**

   - Demonstrate the "app amnesia" problem
   - Show theme switching and persistence
   - Explain key-value storage concepts

2. **Move to Hive Demo**

   - Compare NoSQL vs SQL concepts
   - Show object storage capabilities
   - Demonstrate reactive UI updates
   - Assign homework (add delete functionality)

3. **Compare with SQLite Demo**
   - Show structured data approach
   - Demonstrate SQL query power
   - Compare development complexity
   - Discuss when to use each approach

### For Students

1. **Run Each Workshop**

   - Explore all three storage solutions
   - Compare the user experience
   - Note the code differences

2. **Experiment**

   - Add more data to each app
   - Restart apps to see persistence
   - Try breaking things to understand error handling

3. **Complete Homework**
   - Focus on the Hive notes app
   - Add delete functionality
   - Test thoroughly

## 📖 Learning Path

```
Start Here → SharedPreferences → Hive NoSQL → SQLite → Homework
     ↓              ↓               ↓          ↓         ↓
   Simple      Object Storage   Structured   Compare   Practice
   Storage     & Reactive UI      Data      Solutions   Skills
```

## 🐛 Troubleshooting

### Common Issues

**"Note adapter not found" Error**

```bash
# Solution: Generate the Hive adapter
flutter packages pub run build_runner build
```

**Build Runner Issues**

```bash
# Clean and regenerate
flutter packages pub run build_runner clean
flutter packages pub run build_runner build --delete-conflicting-outputs
```

**Hot Reload Not Working**

- Restart the app completely
- Some database operations require full restart

**Database Not Persisting**

- Check if you're using correct async/await
- Ensure proper initialization in main()

### Performance Tips

- **Hive**: Very fast, good for frequent read/write
- **SharedPreferences**: Best for small, simple data
- **SQLite**: Best for complex queries and relationships

## 🎯 Workshop Objectives Checklist

After completing all workshops, you should be able to:

- [ ] Explain why local storage is important
- [ ] Use SharedPreferences for simple settings
- [ ] Understand NoSQL vs SQL differences
- [ ] Build apps with Hive database
- [ ] Write basic SQL queries
- [ ] Choose appropriate storage for different use cases
- [ ] Implement reactive UI with database changes
- [ ] Handle async operations properly

## 📝 Homework Assignment

See `HOMEWORK_INSTRUCTIONS.md` for detailed homework requirements focusing on enhancing the Hive notes app with delete functionality.

## 🌟 Next Steps

After mastering these concepts:

1. **Advanced Hive**: Encryption, relationships, migrations
2. **Advanced SQL**: Joins, indexes, complex queries
3. **State Management**: Bloc/Provider with databases
4. **Cloud Storage**: Firebase, REST APIs
5. **Offline-First**: Sync strategies, conflict resolution

---

**Happy coding! 🚀**

_This workshop is part of the IEEE Flutter Course - Session 5_

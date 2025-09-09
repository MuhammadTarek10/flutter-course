# 📊 Data Structures in Dart - Workshop

## 📋 Workshop Overview

**Duration**: 60 minutes  
**Difficulty**: Beginner to Intermediate  
**Prerequisites**: Basic Dart syntax, variables, and functions

## 🎯 Learning Objectives

By the end of this workshop, you will be able to:

- ✅ Create and manipulate Lists in Dart
- ✅ Work with Maps for key-value relationships
- ✅ Use Sets for unique collections
- ✅ Iterate through collections using for-in loops
- ✅ Apply generic types (`List<T>`, `Map<K,V>`, `Set<T>`)
- ✅ Perform common collection operations

## 📚 Concepts Covered

### 1. Lists - Ordered Collections

```dart
// Creating lists
List<int> numbers = [1, 2, 3, 4, 5];
List<String> names = ['Alice', 'Bob', 'Charlie'];

// List operations
numbers.add(6);           // Add element
numbers.remove(3);        // Remove element
numbers.length;           // Get length
numbers[0];              // Access by index
```

### 2. Maps - Key-Value Pairs

```dart
// Creating maps
Map<String, int> ages = {'Alice': 25, 'Bob': 30};
Map<int, String> positions = {1: 'First', 2: 'Second'};

// Map operations
ages['Charlie'] = 28;     // Add/update
ages.remove('Bob');       // Remove
ages.containsKey('Alice'); // Check key exists
ages.keys;               // Get all keys
ages.values;             // Get all values
```

### 3. Sets - Unique Collections

```dart
// Creating sets
Set<int> uniqueNumbers = {1, 2, 3, 4, 5};
Set<String> uniqueNames = {'Alice', 'Bob', 'Alice'}; // Only one 'Alice'

// Set operations
uniqueNumbers.add(6);     // Add element
uniqueNumbers.contains(3); // Check if exists
uniqueNumbers.union(otherSet); // Combine sets
```

### 4. Iteration Patterns

```dart
// For-in loops
for (String name in names) {
  print('Hello, $name');
}

// Map iteration
for (String key in ages.keys) {
  print('$key is ${ages[key]} years old');
}
```

## 🎓 Workshop Challenge: Student Grade Manager

### Task Description

Build a comprehensive student grade management system that demonstrates all data structure concepts!

### System Requirements

1. **Student Management**: Store student information
2. **Grade Tracking**: Track multiple grades per student
3. **Subject Management**: Handle different subjects
4. **Statistics**: Calculate averages and find top performers
5. **Search Functions**: Find students by various criteria
6. **Data Display**: Present information in organized formats

### Step-by-Step Implementation Guide

#### Step 1: Set Up Data Structures

```dart
// TODO: Define your data structures
class GradeManager {
  // Student names
  List<String> students = [];

  // Student grades: Map student name to list of grades
  Map<String, List<double>> studentGrades = {};

  // Subject names (unique)
  Set<String> subjects = {};

  // Subject grades: Map subject to map of student grades
  Map<String, Map<String, double>> subjectGrades = {};
}
```

#### Step 2: Core Functions Implementation

**Function 1: Add Student**

```dart
void addStudent(String studentName) {
  if (!students.contains(studentName)) {
    students.add(studentName);
    studentGrades[studentName] = [];
    print('✅ Student $studentName added successfully!');
  } else {
    print('⚠️ Student $studentName already exists!');
  }
}
```

**Function 2: Add Grade**

```dart
void addGrade(String studentName, String subject, double grade) {
  // Validate student exists
  if (!students.contains(studentName)) {
    print('❌ Student $studentName not found!');
    return;
  }

  // Validate grade range
  if (grade < 0 || grade > 100) {
    print('❌ Grade must be between 0 and 100!');
    return;
  }

  // Add grade to student's overall grades
  studentGrades[studentName]!.add(grade);

  // Add subject to subjects set
  subjects.add(subject);

  // Add grade to subject-specific tracking
  if (!subjectGrades.containsKey(subject)) {
    subjectGrades[subject] = {};
  }
  subjectGrades[subject]![studentName] = grade;

  print('✅ Grade $grade added for $studentName in $subject');
}
```

**Function 3: Calculate Student Average**

```dart
double calculateStudentAverage(String studentName) {
  if (!studentGrades.containsKey(studentName) ||
      studentGrades[studentName]!.isEmpty) {
    return 0.0;
  }

  List<double> grades = studentGrades[studentName]!;
  double sum = 0;

  for (double grade in grades) {
    sum += grade;
  }

  return sum / grades.length;
}
```

**Function 4: Find Top Student**

```dart
String findTopStudent() {
  if (students.isEmpty) return 'No students found';

  String topStudent = students[0];
  double topAverage = calculateStudentAverage(topStudent);

  for (String student in students) {
    double average = calculateStudentAverage(student);
    if (average > topAverage) {
      topAverage = average;
      topStudent = student;
    }
  }

  return topStudent;
}
```

#### Step 3: Advanced Features

**Function 5: Subject Statistics**

```dart
void displaySubjectStatistics(String subject) {
  if (!subjects.contains(subject)) {
    print('❌ Subject $subject not found!');
    return;
  }

  Map<String, double> subjectData = subjectGrades[subject]!;

  if (subjectData.isEmpty) {
    print('No grades recorded for $subject');
    return;
  }

  // Calculate statistics
  List<double> grades = subjectData.values.toList();
  double sum = 0;
  double highest = grades[0];
  double lowest = grades[0];

  for (double grade in grades) {
    sum += grade;
    if (grade > highest) highest = grade;
    if (grade < lowest) lowest = grade;
  }

  double average = sum / grades.length;

  print('\n📊 $subject Statistics:');
  print('   Average: ${average.toStringAsFixed(2)}');
  print('   Highest: $highest');
  print('   Lowest: $lowest');
  print('   Number of students: ${grades.length}');
}
```

**Function 6: Search Students by Grade Range**

```dart
List<String> findStudentsByGradeRange(double minGrade, double maxGrade) {
  List<String> result = [];

  for (String student in students) {
    double average = calculateStudentAverage(student);
    if (average >= minGrade && average <= maxGrade) {
      result.add(student);
    }
  }

  return result;
}
```

#### Step 4: Complete Main Function

```dart
void main() {
  GradeManager manager = GradeManager();

  // Sample data
  print('🎓 Setting up Student Grade Manager...\n');

  // Add students
  manager.addStudent('Alice');
  manager.addStudent('Bob');
  manager.addStudent('Charlie');
  manager.addStudent('Diana');

  print('\n📝 Adding grades...');

  // Add grades for different subjects
  manager.addGrade('Alice', 'Math', 95.0);
  manager.addGrade('Alice', 'Science', 88.5);
  manager.addGrade('Alice', 'English', 92.0);

  manager.addGrade('Bob', 'Math', 87.5);
  manager.addGrade('Bob', 'Science', 91.0);
  manager.addGrade('Bob', 'English', 85.5);

  manager.addGrade('Charlie', 'Math', 78.0);
  manager.addGrade('Charlie', 'Science', 82.5);
  manager.addGrade('Charlie', 'English', 88.0);

  manager.addGrade('Diana', 'Math', 93.5);
  manager.addGrade('Diana', 'Science', 96.0);
  manager.addGrade('Diana', 'English', 89.5);

  // Display results
  print('\n📋 Student Averages:');
  for (String student in manager.students) {
    double average = manager.calculateStudentAverage(student);
    print('   $student: ${average.toStringAsFixed(2)}');
  }

  print('\n🏆 Top Student: ${manager.findTopStudent()}');

  // Subject statistics
  for (String subject in manager.subjects) {
    manager.displaySubjectStatistics(subject);
  }

  // Search examples
  print('\n🔍 Students with average 85-90:');
  List<String> goodStudents = manager.findStudentsByGradeRange(85.0, 90.0);
  for (String student in goodStudents) {
    print('   $student');
  }

  print('\n📚 All subjects: ${manager.subjects}');
  print('👥 Total students: ${manager.students.length}');
}
```

### 🏆 Challenge Extensions

Once you complete the basic system, try these enhancements:

1. **Grade Categories**: Add weighted categories (homework, tests, projects)
2. **Letter Grades**: Convert numeric grades to letter grades (A, B, C, D, F)
3. **Class Ranking**: Sort students by performance
4. **Data Export**: Save data to a file format
5. **Semester System**: Track grades across multiple semesters
6. **Subject Prerequisites**: Track which subjects students have completed

### Expected Output Example

```
🎓 Setting up Student Grade Manager...

✅ Student Alice added successfully!
✅ Student Bob added successfully!
✅ Student Charlie added successfully!
✅ Student Diana added successfully!

📝 Adding grades...
✅ Grade 95.0 added for Alice in Math
✅ Grade 88.5 added for Alice in Science
✅ Grade 92.0 added for Alice in English
... (more grades)

📋 Student Averages:
   Alice: 91.83
   Bob: 88.00
   Charlie: 82.83
   Diana: 93.00

🏆 Top Student: Diana

📊 Math Statistics:
   Average: 88.50
   Highest: 95.0
   Lowest: 78.0
   Number of students: 4

📊 Science Statistics:
   Average: 89.50
   Highest: 96.0
   Lowest: 82.5
   Number of students: 4

📊 English Statistics:
   Average: 88.75
   Highest: 92.0
   Lowest: 85.5
   Number of students: 4

🔍 Students with average 85-90:
   Bob

📚 All subjects: {Math, Science, English}
👥 Total students: 4
```

## 🔧 How to Run Your Code

1. **Navigate to the folder**:

   ```bash
   cd "2. data-structures"
   ```

2. **Run your program**:

   ```bash
   dart main.dart
   ```

3. **Test with different data**: Modify the sample data to test edge cases

## ✅ Self-Assessment Checklist

Before moving to the next workshop, ensure you can:

- [ ] Create and manipulate Lists with various data types
- [ ] Use Maps to store key-value relationships
- [ ] Work with Sets for unique collections
- [ ] Iterate through collections using for-in loops
- [ ] Apply generic types correctly (`List<T>`, `Map<K,V>`, `Set<T>`)
- [ ] Perform common operations (add, remove, contains, length)
- [ ] Choose the appropriate collection type for different use cases
- [ ] Handle edge cases (empty collections, missing keys)

## 🎯 Key Takeaways

1. **Lists** are ordered collections that allow duplicates
2. **Maps** store key-value pairs for fast lookups
3. **Sets** maintain unique elements automatically
4. **Generic types** provide type safety and clarity
5. **For-in loops** are ideal for iterating through collections
6. **Collection choice** depends on your specific use case
7. **Data organization** is crucial for efficient programs

## 🔗 Next Steps

Once you've mastered data structures, you're ready for:

- **Workshop 3**: Object-Oriented Programming (Classes and Objects)
- Creating custom data types
- Encapsulating data and behavior

---

### 💡 Pro Tips

- **Choose Wisely**: Use List for ordered data, Map for lookups, Set for uniqueness
- **Type Safety**: Always specify generic types for better code quality
- **Performance**: Maps provide O(1) average lookup time vs O(n) for Lists
- **Immutability**: Consider using `const` for collections that won't change
- **Null Safety**: Handle cases where keys might not exist in Maps

**Happy Coding! 🎉**

# 🏗️ Object-Oriented Programming in Dart - Workshop

## 📋 Workshop Overview

**Duration**: 60 minutes  
**Difficulty**: Intermediate  
**Prerequisites**: Variables, functions, data structures

## 🎯 Learning Objectives

By the end of this workshop, you will be able to:

- ✅ Create classes with properties and methods
- ✅ Implement constructors (default, positional, named)
- ✅ Understand encapsulation and data hiding
- ✅ Override methods like `toString()`
- ✅ Create and manage multiple objects
- ✅ Design object relationships and interactions
- ✅ Apply OOP principles in real-world scenarios

## 📚 Concepts Covered

### 1. Class Definition and Structure

```dart
class Person {
  // Properties (instance variables)
  String name;
  int age;
  String email;

  // Constructor
  Person(this.name, this.age, this.email);

  // Methods
  void introduce() {
    print('Hi, I\'m $name, $age years old.');
  }

  // Getter
  String get info => 'Name: $name, Age: $age';

  // Setter
  set updateAge(int newAge) {
    if (newAge > 0) age = newAge;
  }
}
```

### 2. Constructor Variations

```dart
class Book {
  String title;
  String author;
  int pages;
  bool isAvailable;

  // Positional constructor
  Book(this.title, this.author, this.pages, [this.isAvailable = true]);

  // Named constructor
  Book.createUnavailable(this.title, this.author, this.pages)
    : isAvailable = false;

  // Named constructor with factory pattern
  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(map['title'], map['author'], map['pages']);
  }
}
```

### 3. Method Overriding

```dart
class Vehicle {
  String brand;
  String model;

  Vehicle(this.brand, this.model);

  @override
  String toString() {
    return '$brand $model';
  }

  @override
  bool operator ==(Object other) {
    if (other is Vehicle) {
      return brand == other.brand && model == other.model;
    }
    return false;
  }
}
```

## 📚 Workshop Challenge: Library Management System

### Task Description

Build a comprehensive library management system that demonstrates OOP principles through real-world book and library operations!

### System Requirements

1. **Book Management**: Create and manage book objects
2. **Library Operations**: Add, remove, search, and organize books
3. **Borrowing System**: Track book availability and borrowing history
4. **User Management**: Handle library members and their activities
5. **Search Functionality**: Find books by various criteria
6. **Reporting**: Generate statistics and reports

### Step-by-Step Implementation Guide

#### Step 1: Define the Book Class

```dart
class Book {
  // Properties
  String title;
  String author;
  String isbn;
  String category;
  int publicationYear;
  bool isAvailable;
  String? borrowedBy;
  DateTime? borrowDate;
  DateTime? dueDate;

  // Constructor
  Book({
    required this.title,
    required this.author,
    required this.isbn,
    required this.category,
    required this.publicationYear,
    this.isAvailable = true,
    this.borrowedBy,
    this.borrowDate,
    this.dueDate,
  });

  // Named constructor for quick book creation
  Book.quick(this.title, this.author, this.isbn)
    : category = 'General',
      publicationYear = DateTime.now().year,
      isAvailable = true;

  // Methods
  void borrowBook(String borrowerName) {
    if (!isAvailable) {
      print('❌ Book "$title" is already borrowed!');
      return;
    }

    isAvailable = false;
    borrowedBy = borrowerName;
    borrowDate = DateTime.now();
    dueDate = DateTime.now().add(Duration(days: 14)); // 2 weeks loan

    print('✅ Book "$title" borrowed by $borrowerName');
    print('   Due date: ${dueDate!.day}/${dueDate!.month}/${dueDate!.year}');
  }

  void returnBook() {
    if (isAvailable) {
      print('❌ Book "$title" is not currently borrowed!');
      return;
    }

    String previousBorrower = borrowedBy!;
    isAvailable = true;
    borrowedBy = null;
    borrowDate = null;
    dueDate = null;

    print('✅ Book "$title" returned by $previousBorrower');
  }

  bool isOverdue() {
    if (isAvailable || dueDate == null) return false;
    return DateTime.now().isAfter(dueDate!);
  }

  int daysUntilDue() {
    if (isAvailable || dueDate == null) return 0;
    return dueDate!.difference(DateTime.now()).inDays;
  }

  @override
  String toString() {
    String status = isAvailable ? '📗 Available' : '📕 Borrowed';
    String borrowInfo = isAvailable ? '' : ' (by $borrowedBy)';
    return '$status "$title" by $author [$category, $publicationYear]$borrowInfo';
  }

  @override
  bool operator ==(Object other) {
    if (other is Book) {
      return isbn == other.isbn;
    }
    return false;
  }

  @override
  int get hashCode => isbn.hashCode;
}
```

#### Step 2: Define the Library Member Class

```dart
class LibraryMember {
  String name;
  String memberId;
  String email;
  DateTime memberSince;
  List<String> borrowedBooks;
  List<String> borrowingHistory;

  LibraryMember({
    required this.name,
    required this.memberId,
    required this.email,
  }) : memberSince = DateTime.now(),
       borrowedBooks = [],
       borrowingHistory = [];

  void addBorrowedBook(String bookTitle) {
    borrowedBooks.add(bookTitle);
    borrowingHistory.add(bookTitle);
  }

  void removeBorrowedBook(String bookTitle) {
    borrowedBooks.remove(bookTitle);
  }

  int get totalBooksRead => borrowingHistory.length;
  int get currentlyBorrowed => borrowedBooks.length;

  @override
  String toString() {
    return '👤 $name (ID: $memberId) - Member since ${memberSince.year}';
  }
}
```

#### Step 3: Create the Library Class

```dart
class Library {
  String name;
  String address;
  List<Book> books;
  List<LibraryMember> members;
  Map<String, String> borrowingRecords; // ISBN -> Member ID

  Library(this.name, this.address)
    : books = [],
      members = [],
      borrowingRecords = {};

  // Book management methods
  void addBook(Book book) {
    // Check if book already exists
    if (books.contains(book)) {
      print('⚠️ Book with ISBN ${book.isbn} already exists!');
      return;
    }

    books.add(book);
    print('✅ Added "${book.title}" to the library');
  }

  void removeBook(String isbn) {
    Book? bookToRemove = findBookByISBN(isbn);
    if (bookToRemove == null) {
      print('❌ Book with ISBN $isbn not found!');
      return;
    }

    if (!bookToRemove.isAvailable) {
      print('❌ Cannot remove "${bookToRemove.title}" - currently borrowed!');
      return;
    }

    books.remove(bookToRemove);
    print('✅ Removed "${bookToRemove.title}" from the library');
  }

  // Search methods
  Book? findBookByISBN(String isbn) {
    for (Book book in books) {
      if (book.isbn == isbn) return book;
    }
    return null;
  }

  List<Book> findBooksByTitle(String title) {
    List<Book> results = [];
    String lowerTitle = title.toLowerCase();

    for (Book book in books) {
      if (book.title.toLowerCase().contains(lowerTitle)) {
        results.add(book);
      }
    }

    return results;
  }

  List<Book> findBooksByAuthor(String author) {
    List<Book> results = [];
    String lowerAuthor = author.toLowerCase();

    for (Book book in books) {
      if (book.author.toLowerCase().contains(lowerAuthor)) {
        results.add(book);
      }
    }

    return results;
  }

  List<Book> findBooksByCategory(String category) {
    List<Book> results = [];
    String lowerCategory = category.toLowerCase();

    for (Book book in books) {
      if (book.category.toLowerCase() == lowerCategory) {
        results.add(book);
      }
    }

    return results;
  }

  List<Book> getAvailableBooks() {
    List<Book> available = [];
    for (Book book in books) {
      if (book.isAvailable) available.add(book);
    }
    return available;
  }

  List<Book> getBorrowedBooks() {
    List<Book> borrowed = [];
    for (Book book in books) {
      if (!book.isAvailable) borrowed.add(book);
    }
    return borrowed;
  }

  List<Book> getOverdueBooks() {
    List<Book> overdue = [];
    for (Book book in books) {
      if (book.isOverdue()) overdue.add(book);
    }
    return overdue;
  }

  // Member management
  void addMember(LibraryMember member) {
    // Check if member ID already exists
    for (LibraryMember existingMember in members) {
      if (existingMember.memberId == member.memberId) {
        print('⚠️ Member with ID ${member.memberId} already exists!');
        return;
      }
    }

    members.add(member);
    print('✅ Added member: ${member.name}');
  }

  LibraryMember? findMemberById(String memberId) {
    for (LibraryMember member in members) {
      if (member.memberId == memberId) return member;
    }
    return null;
  }

  // Borrowing operations
  void borrowBook(String isbn, String memberId) {
    Book? book = findBookByISBN(isbn);
    LibraryMember? member = findMemberById(memberId);

    if (book == null) {
      print('❌ Book with ISBN $isbn not found!');
      return;
    }

    if (member == null) {
      print('❌ Member with ID $memberId not found!');
      return;
    }

    if (member.currentlyBorrowed >= 5) {
      print('❌ ${member.name} has reached the borrowing limit (5 books)!');
      return;
    }

    book.borrowBook(member.name);
    if (!book.isAvailable) {
      member.addBorrowedBook(book.title);
      borrowingRecords[isbn] = memberId;
    }
  }

  void returnBook(String isbn) {
    Book? book = findBookByISBN(isbn);

    if (book == null) {
      print('❌ Book with ISBN $isbn not found!');
      return;
    }

    if (book.isAvailable) {
      print('❌ Book "${book.title}" is not currently borrowed!');
      return;
    }

    String? memberId = borrowingRecords[isbn];
    if (memberId != null) {
      LibraryMember? member = findMemberById(memberId);
      if (member != null) {
        member.removeBorrowedBook(book.title);
      }
      borrowingRecords.remove(isbn);
    }

    book.returnBook();
  }

  // Statistics and reporting
  void displayStatistics() {
    print('\n📊 Library Statistics for "$name"');
    print('   📍 Location: $address');
    print('   📚 Total books: ${books.length}');
    print('   📗 Available books: ${getAvailableBooks().length}');
    print('   📕 Borrowed books: ${getBorrowedBooks().length}');
    print('   ⏰ Overdue books: ${getOverdueBooks().length}');
    print('   👥 Total members: ${members.length}');

    // Category breakdown
    Map<String, int> categoryCount = {};
    for (Book book in books) {
      categoryCount[book.category] = (categoryCount[book.category] ?? 0) + 1;
    }

    print('\n   📂 Books by category:');
    for (String category in categoryCount.keys) {
      print('      $category: ${categoryCount[category]}');
    }
  }

  void displayOverdueBooks() {
    List<Book> overdueBooks = getOverdueBooks();

    if (overdueBooks.isEmpty) {
      print('✅ No overdue books!');
      return;
    }

    print('\n⏰ Overdue Books:');
    for (Book book in overdueBooks) {
      int daysOverdue = DateTime.now().difference(book.dueDate!).inDays;
      print('   📕 "${book.title}" by ${book.borrowedBy} ($daysOverdue days overdue)');
    }
  }

  void displayMemberActivity() {
    print('\n👥 Member Activity:');
    for (LibraryMember member in members) {
      print('   ${member.toString()}');
      print('      Currently borrowed: ${member.currentlyBorrowed} books');
      print('      Total books read: ${member.totalBooksRead} books');
      if (member.borrowedBooks.isNotEmpty) {
        print('      Current books: ${member.borrowedBooks.join(", ")}');
      }
      print('');
    }
  }

  @override
  String toString() {
    return '🏛️ $name Library ($address) - ${books.length} books, ${members.length} members';
  }
}
```

#### Step 4: Complete Main Function with Demo

```dart
void main() {
  // Create library
  Library library = Library('IEEE University Library', '123 Campus Drive');

  print('🏛️ Welcome to the ${library.name}!\n');

  // Add books
  print('📚 Adding books to the library...');
  library.addBook(Book(
    title: 'Clean Code',
    author: 'Robert C. Martin',
    isbn: '978-0132350884',
    category: 'Programming',
    publicationYear: 2008,
  ));

  library.addBook(Book(
    title: 'The Pragmatic Programmer',
    author: 'David Thomas',
    isbn: '978-0201616224',
    category: 'Programming',
    publicationYear: 1999,
  ));

  library.addBook(Book(
    title: 'Design Patterns',
    author: 'Gang of Four',
    isbn: '978-0201633612',
    category: 'Programming',
    publicationYear: 1994,
  ));

  library.addBook(Book.quick(
    'Dart Programming',
    'John Doe',
    '978-1234567890'
  ));

  library.addBook(Book(
    title: 'Data Structures and Algorithms',
    author: 'Thomas H. Cormen',
    isbn: '978-0262033848',
    category: 'Computer Science',
    publicationYear: 2009,
  ));

  // Add members
  print('\n👥 Adding library members...');
  library.addMember(LibraryMember(
    name: 'Alice Johnson',
    memberId: 'M001',
    email: 'alice@example.com',
  ));

  library.addMember(LibraryMember(
    name: 'Bob Smith',
    memberId: 'M002',
    email: 'bob@example.com',
  ));

  library.addMember(LibraryMember(
    name: 'Charlie Brown',
    memberId: 'M003',
    email: 'charlie@example.com',
  ));

  // Demonstrate borrowing
  print('\n📖 Borrowing books...');
  library.borrowBook('978-0132350884', 'M001'); // Alice borrows Clean Code
  library.borrowBook('978-0201616224', 'M002'); // Bob borrows Pragmatic Programmer
  library.borrowBook('978-1234567890', 'M001'); // Alice borrows Dart Programming

  // Try to borrow already borrowed book
  library.borrowBook('978-0132350884', 'M003'); // Should fail

  // Display current status
  print('\n📋 Current library status:');
  for (Book book in library.books) {
    print('   $book');
  }

  // Search demonstrations
  print('\n🔍 Search demonstrations:');

  print('\n   Books by "Robert":');
  List<Book> robertBooks = library.findBooksByAuthor('Robert');
  for (Book book in robertBooks) {
    print('     $book');
  }

  print('\n   Programming books:');
  List<Book> programmingBooks = library.findBooksByCategory('Programming');
  for (Book book in programmingBooks) {
    print('     $book');
  }

  print('\n   Books with "Code" in title:');
  List<Book> codeBooks = library.findBooksByTitle('Code');
  for (Book book in codeBooks) {
    print('     $book');
  }

  // Return a book
  print('\n📤 Returning books...');
  library.returnBook('978-0201616224'); // Bob returns Pragmatic Programmer

  // Display statistics
  library.displayStatistics();
  library.displayMemberActivity();
  library.displayOverdueBooks();

  print('\n✨ Library management system demo completed!');
}
```

### 🏆 Challenge Extensions

Once you complete the basic system, try these enhancements:

1. **Inheritance**: Create specialized book types (TextBook, Fiction, Reference)
2. **Fine System**: Calculate and track late fees for overdue books
3. **Reservation System**: Allow members to reserve books
4. **Digital Books**: Add support for e-books with download limits
5. **Staff Management**: Create Librarian class with special privileges
6. **Advanced Search**: Implement search by multiple criteria
7. **Data Persistence**: Save/load library data to/from files

### Expected Output Example

```
🏛️ Welcome to the IEEE University Library!

📚 Adding books to the library...
✅ Added "Clean Code" to the library
✅ Added "The Pragmatic Programmer" to the library
✅ Added "Design Patterns" to the library
✅ Added "Dart Programming" to the library
✅ Added "Data Structures and Algorithms" to the library

👥 Adding library members...
✅ Added member: Alice Johnson
✅ Added member: Bob Smith
✅ Added member: Charlie Brown

📖 Borrowing books...
✅ Book "Clean Code" borrowed by Alice Johnson
   Due date: 15/12/2024
✅ Book "The Pragmatic Programmer" borrowed by Bob Smith
   Due date: 15/12/2024
✅ Book "Dart Programming" borrowed by Alice Johnson
   Due date: 15/12/2024
❌ Book "Clean Code" is already borrowed!

📋 Current library status:
   📕 "Clean Code" by Robert C. Martin [Programming, 2008] (by Alice Johnson)
   📕 "The Pragmatic Programmer" by David Thomas [Programming, 1999] (by Bob Smith)
   📗 "Design Patterns" by Gang of Four [Programming, 1994]
   📕 "Dart Programming" by John Doe [General, 2024] (by Alice Johnson)
   📗 "Data Structures and Algorithms" by Thomas H. Cormen [Computer Science, 2009]

🔍 Search demonstrations:

   Books by "Robert":
     📕 "Clean Code" by Robert C. Martin [Programming, 2008] (by Alice Johnson)

   Programming books:
     📕 "Clean Code" by Robert C. Martin [Programming, 2008] (by Alice Johnson)
     📕 "The Pragmatic Programmer" by David Thomas [Programming, 1999] (by Bob Smith)
     📗 "Design Patterns" by Gang of Four [Programming, 1994]

   Books with "Code" in title:
     📕 "Clean Code" by Robert C. Martin [Programming, 2008] (by Alice Johnson)

📤 Returning books...
✅ Book "The Pragmatic Programmer" returned by Bob Smith

📊 Library Statistics for "IEEE University Library"
   📍 Location: 123 Campus Drive
   📚 Total books: 5
   📗 Available books: 3
   📕 Borrowed books: 2
   ⏰ Overdue books: 0
   👥 Total members: 3

   📂 Books by category:
      Programming: 3
      General: 1
      Computer Science: 1

👥 Member Activity:
   👤 Alice Johnson (ID: M001) - Member since 2024
      Currently borrowed: 2 books
      Total books read: 2 books
      Current books: Clean Code, Dart Programming

   👤 Bob Smith (ID: M002) - Member since 2024
      Currently borrowed: 0 books
      Total books read: 1 books

   👤 Charlie Brown (ID: M003) - Member since 2024
      Currently borrowed: 0 books
      Total books read: 0 books

✅ No overdue books!

✨ Library management system demo completed!
```

## 🔧 How to Run Your Code

1. **Navigate to the folder**:

   ```bash
   cd "3. oop"
   ```

2. **Run your program**:

   ```bash
   dart main.dart
   ```

3. **Experiment**: Try adding your own books, members, and operations

## ✅ Self-Assessment Checklist

Before moving to the next workshop, ensure you can:

- [ ] Create classes with properties and methods
- [ ] Implement various constructor types (positional, named, factory)
- [ ] Use the `this` keyword correctly
- [ ] Override methods like `toString()` and `operator ==`
- [ ] Create and manage object relationships
- [ ] Apply encapsulation principles
- [ ] Handle object interactions and dependencies
- [ ] Design classes that model real-world entities

## 🎯 Key Takeaways

1. **Classes** define the blueprint for objects
2. **Constructors** initialize object state
3. **Methods** define object behavior
4. **Encapsulation** protects and organizes data
5. **Override** customizes inherited behavior
6. **Object relationships** model real-world interactions
7. **Design patterns** solve common problems

## 🔗 Next Steps

Once you've mastered OOP concepts, you're ready for:

- **Workshop 4**: Calculator Project (Integration of all concepts)
- Applying OOP in larger applications
- Advanced Dart features and patterns

---

### 💡 Pro Tips

- **Single Responsibility**: Each class should have one main purpose
- **Meaningful Names**: Use descriptive names for classes, methods, and properties
- **Constructor Convenience**: Use named constructors for different creation patterns
- **Method Organization**: Group related functionality together
- **Error Handling**: Always validate inputs and handle edge cases
- **Documentation**: Use comments to explain complex logic

**Happy Coding! 🎉**

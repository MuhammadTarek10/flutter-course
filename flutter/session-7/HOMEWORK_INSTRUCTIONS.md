# 📸 Session 7 Homework: Photo Gallery App

## 🎯 Objective

Build a complete photo gallery app that fetches and displays photos from a REST API. This homework combines all the concepts from Session 7: asynchronous programming, HTTP requests, JSON parsing, and FutureBuilder UI patterns.

## 📋 Requirements

### Core Features (Required)

1. **📸 Photo Model**

   - Create a `Photo` class with properties: `id`, `title`, `thumbnailUrl`
   - Include a `fromJson` factory constructor for JSON parsing
   - Add helper methods like `shortTitle` for display

2. **🌐 API Integration**

   - Fetch photos from: `https://jsonplaceholder.typicode.com/photos`
   - Limit results to 100 photos using `?_limit=100` query parameter
   - Handle HTTP errors gracefully with try/catch

3. **🏗️ FutureBuilder Implementation**

   - Use `FutureBuilder<List<Photo>>` to manage async data
   - Handle all connection states properly:
     - `ConnectionState.waiting` → Show loading indicator
     - `snapshot.hasError` → Show error message with retry button
     - `snapshot.hasData` → Display photo grid
     - Empty data → Show "no photos found" message

4. **📱 GridView Display**
   - Display photos in a responsive `GridView`
   - Show thumbnail images using `Image.network()`
   - Include photo titles and IDs
   - Handle image loading errors gracefully

### Bonus Features (Optional)

5. **🔄 Pull-to-Refresh**

   - Implement `RefreshIndicator` for manual refresh
   - Show loading state during refresh

6. **🔍 Photo Detail View**

   - Navigate to detail page when photo is tapped
   - Show full-size image and complete photo information
   - Include proper loading states for full-size images

7. **📊 Loading Progress**
   - Show progress indicators for individual image loading
   - Display success/error states for the overall API call

## 🏗️ Project Structure

```
lib/
├── main.dart                 # Main app entry point
├── models/
│   └── photo.dart           # Photo data model
├── services/
│   └── photo_service.dart   # API service (optional)
└── screens/
    ├── photo_gallery_page.dart    # Main gallery screen
    └── photo_detail_page.dart     # Detail screen (bonus)
```

## 📝 Step-by-Step Guide

### Step 1: Setup Dependencies

Add the HTTP package to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0
```

### Step 2: Create the Photo Model

```dart
class Photo {
  final int id;
  final String title;
  final String thumbnailUrl;

  const Photo({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String? ?? '',
      thumbnailUrl: json['thumbnailUrl'] as String? ?? '',
    );
  }

  String get shortTitle {
    if (title.length <= 30) return title;
    return '${title.substring(0, 27)}...';
  }
}
```

### Step 3: Create the API Service Function

```dart
Future<List<Photo>> fetchPhotos() async {
  final uri = Uri.https(
    'jsonplaceholder.typicode.com',
    '/photos',
    {'_limit': '100'}, // Limit to 100 photos
  );

  final response = await http.get(uri);

  if (response.statusCode != 200) {
    throw Exception('Failed to load photos (HTTP ${response.statusCode})');
  }

  final List<dynamic> jsonList = jsonDecode(response.body) as List<dynamic>;
  return jsonList
      .map((json) => Photo.fromJson(json as Map<String, dynamic>))
      .toList();
}
```

### Step 4: Implement FutureBuilder UI

```dart
class PhotoGalleryPage extends StatefulWidget {
  @override
  State<PhotoGalleryPage> createState() => _PhotoGalleryPageState();
}

class _PhotoGalleryPageState extends State<PhotoGalleryPage> {
  late Future<List<Photo>> _photosFuture;

  @override
  void initState() {
    super.initState();
    _photosFuture = fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Photo Gallery')),
      body: FutureBuilder<List<Photo>>(
        future: _photosFuture,
        builder: (context, snapshot) {
          // Handle different states here
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return _buildErrorState(snapshot.error.toString());
          }

          if (snapshot.hasData) {
            return _buildPhotoGrid(snapshot.data!);
          }

          return const Center(child: Text('No data'));
        },
      ),
    );
  }
}
```

### Step 5: Create the GridView

```dart
Widget _buildPhotoGrid(List<Photo> photos) {
  return GridView.builder(
    padding: const EdgeInsets.all(8),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 1,
    ),
    itemCount: photos.length,
    itemBuilder: (context, index) {
      final photo = photos[index];
      return Card(
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                photo.thumbnailUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Icon(Icons.broken_image));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                photo.shortTitle,
                style: const TextStyle(fontSize: 12),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    },
  );
}
```

## ✅ Evaluation Criteria

### Required Features (70 points)

- **Photo Model (10 points)**

  - ✅ Proper class structure with required fields
  - ✅ `fromJson` factory constructor
  - ✅ Helper methods for display

- **API Integration (20 points)**

  - ✅ Correct API endpoint usage
  - ✅ Proper HTTP request implementation
  - ✅ Error handling with try/catch
  - ✅ JSON parsing to Photo objects

- **FutureBuilder Implementation (25 points)**

  - ✅ Proper FutureBuilder usage
  - ✅ All connection states handled
  - ✅ Loading indicators shown
  - ✅ Error states with retry functionality
  - ✅ Empty state handling

- **GridView Display (15 points)**
  - ✅ Responsive grid layout
  - ✅ Image loading with error handling
  - ✅ Photo information display
  - ✅ Proper UI styling

### Bonus Features (30 points)

- **Pull-to-Refresh (10 points)**

  - ✅ RefreshIndicator implementation
  - ✅ Proper state management during refresh

- **Photo Detail View (15 points)**

  - ✅ Navigation to detail screen
  - ✅ Full-size image display
  - ✅ Complete photo information
  - ✅ Loading states for images

- **Advanced UI/UX (5 points)**
  - ✅ Loading progress indicators
  - ✅ Professional error messages
  - ✅ Smooth transitions and animations

## 🚨 Common Mistakes to Avoid

### 1. **Forgetting Error Handling**

```dart
// ❌ Bad: No error handling
final response = await http.get(uri);
final data = jsonDecode(response.body);

// ✅ Good: Proper error handling
try {
  final response = await http.get(uri);
  if (response.statusCode != 200) {
    throw Exception('HTTP ${response.statusCode}');
  }
  final data = jsonDecode(response.body);
} catch (error) {
  throw Exception('Network error: $error');
}
```

### 2. **Not Handling All FutureBuilder States**

```dart
// ❌ Bad: Missing states
if (snapshot.hasData) {
  return buildSuccess(snapshot.data!);
}
return CircularProgressIndicator(); // What about errors?

// ✅ Good: All states handled
if (snapshot.connectionState == ConnectionState.waiting) {
  return buildLoading();
}
if (snapshot.hasError) {
  return buildError(snapshot.error);
}
if (snapshot.hasData) {
  return buildSuccess(snapshot.data!);
}
return buildFallback();
```

### 3. **Poor Image Error Handling**

```dart
// ❌ Bad: No image error handling
Image.network(photo.thumbnailUrl)

// ✅ Good: Proper image error handling
Image.network(
  photo.thumbnailUrl,
  errorBuilder: (context, error, stackTrace) {
    return const Icon(Icons.broken_image);
  },
)
```

### 4. **Not Limiting API Results**

```dart
// ❌ Bad: Loading all 5000 photos
Uri.https('jsonplaceholder.typicode.com', '/photos')

// ✅ Good: Limiting results
Uri.https('jsonplaceholder.typicode.com', '/photos', {'_limit': '100'})
```

## 🎯 Testing Your App

### Manual Testing Checklist

1. **App Launch**

   - [ ] App starts without crashes
   - [ ] Loading indicator appears immediately
   - [ ] Photos load and display correctly

2. **Error Scenarios**

   - [ ] Turn off internet → Should show error message
   - [ ] Tap retry button → Should attempt to reload
   - [ ] Invalid images → Should show broken image icon

3. **UI Responsiveness**

   - [ ] Scroll through grid smoothly
   - [ ] Images load progressively
   - [ ] App remains responsive during loading

4. **Bonus Features (if implemented)**
   - [ ] Pull-to-refresh works correctly
   - [ ] Photo detail navigation works
   - [ ] Full-size images load properly

## 📚 Learning Resources

### Key Concepts Review

1. **Asynchronous Programming**

   - `Future<T>` represents a value available in the future
   - `async` marks functions that return Futures
   - `await` pauses execution until Future completes

2. **HTTP Requests**

   - Use `http.get()` for API calls
   - Always check `response.statusCode`
   - Handle network errors with try/catch

3. **JSON Parsing**

   - Use `jsonDecode()` to parse JSON strings
   - Create model classes with `fromJson` constructors
   - Handle null values safely

4. **FutureBuilder**
   - Automatically rebuilds when Future state changes
   - Check `snapshot.connectionState` for current state
   - Use `snapshot.hasData` and `snapshot.hasError`

### Helpful Documentation

- [Flutter HTTP Package](https://pub.dev/packages/http)
- [FutureBuilder Widget](https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html)
- [GridView Widget](https://api.flutter.dev/flutter/widgets/GridView-class.html)
- [JSONPlaceholder API](https://jsonplaceholder.typicode.com/)

## 🎉 Submission Guidelines

### What to Submit

1. **Complete Flutter Project**

   - All source code files
   - `pubspec.yaml` with dependencies
   - README with setup instructions

2. **Screenshots**

   - App loading state
   - Photo grid display
   - Error state (if possible)
   - Bonus features (if implemented)

3. **Brief Report (Optional)**
   - Challenges faced and solutions
   - Bonus features implemented
   - What you learned

### Submission Format

```
session7_homework_[your_name]/
├── lib/
│   ├── main.dart
│   ├── models/photo.dart
│   └── [other files]
├── pubspec.yaml
├── screenshots/
│   ├── loading_state.png
│   ├── photo_grid.png
│   └── error_state.png
└── README.md
```

## 🏆 Success Criteria

**Minimum Viable Product (MVP):**

- ✅ App fetches and displays photos from API
- ✅ Proper loading and error states
- ✅ GridView with image thumbnails
- ✅ Basic error handling

**Excellent Implementation:**

- ✅ All MVP features plus bonus features
- ✅ Professional UI/UX design
- ✅ Comprehensive error handling
- ✅ Smooth performance and responsiveness

## 💡 Tips for Success

1. **Start Simple**

   - Get basic API call working first
   - Add UI states one by one
   - Test frequently during development

2. **Use the Solution as Reference**

   - Check the provided solution for patterns
   - Don't copy-paste, understand the concepts
   - Adapt the code to your own style

3. **Debug Effectively**

   - Use `print()` statements to debug API calls
   - Check Flutter Inspector for UI issues
   - Test on different devices/screen sizes

4. **Ask for Help**
   - Use the course discussion forum
   - Reference Flutter documentation
   - Check Stack Overflow for common issues

**Good luck with your photo gallery app! 🚀**

---

_This homework is part of the IEEE Flutter Course - Session 7: Asynchronous Programming & API Integration_

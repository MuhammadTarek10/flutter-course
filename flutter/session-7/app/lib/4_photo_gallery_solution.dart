import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/photo.dart';

// 📸 Module 4: Photo Gallery App - Homework Solution
//
// This is the complete solution for the homework assignment.
// It demonstrates all concepts from previous modules in a real-world photo gallery app.
//
// Features:
// - Fetches photos from JSONPlaceholder API
// - Displays photos in a responsive GridView
// - Handles loading, error, and empty states
// - Image loading with progress indicators
// - Photo detail view with full-size images
// - Pull-to-refresh functionality

void main() {
  runApp(const PhotoGalleryApp());
}

class PhotoGalleryApp extends StatelessWidget {
  const PhotoGalleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Gallery',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const PhotoGalleryPage(),
    );
  }
}

class PhotoGalleryPage extends StatefulWidget {
  const PhotoGalleryPage({super.key});

  @override
  State<PhotoGalleryPage> createState() => _PhotoGalleryPageState();
}

class _PhotoGalleryPageState extends State<PhotoGalleryPage> {
  late Future<List<Photo>> _photosFuture;
  static const int _photosLimit = 100; // Limit to avoid loading all 5000 photos

  @override
  void initState() {
    super.initState();
    _photosFuture = _fetchPhotos();
  }

  // 📸 Fetch photos from JSONPlaceholder API
  Future<List<Photo>> _fetchPhotos() async {
    try {
      // Add a small delay to show loading state
      await Future.delayed(const Duration(milliseconds: 500));

      final uri = Uri.https(
        'jsonplaceholder.typicode.com',
        '/photos',
        {'_limit': '$_photosLimit'}, // Limit the number of photos
      );

      final response = await http.get(
        uri,
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to load photos (HTTP ${response.statusCode})');
      }

      final List<dynamic> jsonList = jsonDecode(response.body) as List<dynamic>;
      return jsonList
          .map((json) => Photo.fromJson(json as Map<String, dynamic>))
          .where(
            (photo) => photo.hasValidUrls,
          ) // Filter out photos with invalid URLs
          .toList();
    } catch (error) {
      throw Exception('Network error: ${error.toString()}');
    }
  }

  // 🔄 Refresh photos
  Future<void> _refreshPhotos() async {
    setState(() {
      _photosFuture = _fetchPhotos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Gallery'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: _refreshPhotos,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh Photos',
          ),
        ],
      ),
      body: FutureBuilder<List<Photo>>(
        future: _photosFuture,
        builder: (context, snapshot) {
          // 1️⃣ Loading State
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoadingState();
          }

          // 2️⃣ Error State
          if (snapshot.hasError) {
            return _buildErrorState(snapshot.error.toString());
          }

          // 3️⃣ Success State
          if (snapshot.hasData) {
            final photos = snapshot.data!;

            if (photos.isEmpty) {
              return _buildEmptyState();
            }

            return _buildPhotoGrid(photos);
          }

          // 4️⃣ Fallback State
          return _buildFallbackState();
        },
      ),
    );
  }

  // 🎨 UI State Builders

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(
            'Loading photos...',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Fetching $_photosLimit photos from the gallery',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red.shade400),
            const SizedBox(height: 16),
            Text(
              'Failed to load photos',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: Colors.red.shade700),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Text(
                error,
                style: TextStyle(color: Colors.red.shade700, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _refreshPhotos,
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade100,
                foregroundColor: Colors.red.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.photo_library_outlined,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No photos found',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 8),
          Text(
            'The gallery appears to be empty',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade500),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _refreshPhotos,
            icon: const Icon(Icons.refresh),
            label: const Text('Refresh'),
          ),
        ],
      ),
    );
  }

  Widget _buildFallbackState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.help_outline, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'Something unexpected happened',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _refreshPhotos,
            icon: const Icon(Icons.refresh),
            label: const Text('Refresh'),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoGrid(List<Photo> photos) {
    return RefreshIndicator(
      onRefresh: _refreshPhotos,
      child: Column(
        children: [
          // Success Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.photo_library, color: Colors.green.shade700),
                const SizedBox(width: 8),
                Text(
                  'Gallery loaded: ${photos.length} photos',
                  style: TextStyle(
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Text(
                  'Pull to refresh',
                  style: TextStyle(color: Colors.green.shade600, fontSize: 12),
                ),
              ],
            ),
          ),

          // Photo Grid
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Responsive grid: adjust columns based on screen width
                final crossAxisCount = (constraints.maxWidth / 150)
                    .floor()
                    .clamp(2, 4);

                return GridView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1, // Square tiles
                  ),
                  itemCount: photos.length,
                  itemBuilder: (context, index) {
                    final photo = photos[index];
                    return _PhotoTile(
                      photo: photo,
                      onTap: () => _showPhotoDetail(photo),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showPhotoDetail(Photo photo) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => _PhotoDetailPage(photo: photo)),
    );
  }
}

// 🖼️ Individual Photo Tile Widget
class _PhotoTile extends StatelessWidget {
  final Photo photo;
  final VoidCallback onTap;

  const _PhotoTile({required this.photo, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Photo Image
            Expanded(
              child: Image.network(
                photo.thumbnailUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;

                  return Container(
                    color: Colors.grey.shade100,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                        strokeWidth: 2,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.broken_image,
                          color: Colors.grey.shade400,
                          size: 32,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Failed to load',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Photo Title
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    photo.shortTitle,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'ID: ${photo.id}',
                    style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 🔍 Photo Detail Page
class _PhotoDetailPage extends StatelessWidget {
  final Photo photo;

  const _PhotoDetailPage({required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo ${photo.id}'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Full Size Image
            Card(
              clipBehavior: Clip.antiAlias,
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.network(
                  photo.url,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;

                    return Container(
                      color: Colors.grey.shade100,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                  : null,
                            ),
                            const SizedBox(height: 16),
                            const Text('Loading full-size image...'),
                          ],
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade200,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.broken_image,
                              color: Colors.grey.shade400,
                              size: 64,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Failed to load image',
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Photo Information
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info, color: Theme.of(context).primaryColor),
                        const SizedBox(width: 8),
                        Text(
                          'Photo Information',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _DetailRow('ID', photo.id.toString()),
                    _DetailRow('Album ID', photo.albumId.toString()),
                    _DetailRow('Title', photo.title),
                    const SizedBox(height: 16),
                    Text(
                      'URLs',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _DetailRow('Thumbnail', photo.thumbnailUrl),
                    _DetailRow('Full Size', photo.url),
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

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
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
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontFamily: value.startsWith('http') ? 'monospace' : null,
                fontSize: value.startsWith('http') ? 11 : 14,
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
// 1. COMPLETE APP STRUCTURE:
//    - Main app with proper theming
//    - Stateful widget for data management
//    - Separate pages for different views
//    - Reusable widget components
//
// 2. API INTEGRATION:
//    - HTTP requests with query parameters
//    - JSON parsing with error handling
//    - Data filtering and validation
//    - Proper error propagation
//
// 3. UI PATTERNS:
//    - FutureBuilder for async data
//    - GridView for photo layout
//    - RefreshIndicator for pull-to-refresh
//    - Navigation between screens
//
// 4. IMAGE HANDLING:
//    - Network images with loading states
//    - Error handling for failed images
//    - Progress indicators for loading
//    - Different image sizes (thumbnail vs full)
//
// 5. RESPONSIVE DESIGN:
//    - LayoutBuilder for screen size detection
//    - Dynamic grid column count
//    - Proper aspect ratios
//    - Scalable UI components
//
// 6. USER EXPERIENCE:
//    - Loading states with progress
//    - Error states with retry options
//    - Empty states with helpful messages
//    - Pull-to-refresh functionality
//    - Detailed photo view
//
// 7. BEST PRACTICES:
//    - Proper error handling throughout
//    - Resource management (image loading)
//    - Code organization with private widgets
//    - Consistent styling and theming
//    - Accessibility considerations

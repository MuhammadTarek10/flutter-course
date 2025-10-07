// 📸 Photo Model for Gallery App
//
// This file demonstrates creating models for different API endpoints.
// Shows how to handle optional fields and provide default values.

class Photo {
  final int id;
  final int albumId;
  final String title;
  final String url;
  final String thumbnailUrl;

  const Photo({
    required this.id,
    required this.albumId,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  /// Factory constructor to create a Photo from JSON data
  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: (json['id'] as num?)?.toInt() ?? 0,
      albumId: (json['albumId'] as num?)?.toInt() ?? 0,
      title: json['title'] as String? ?? 'Untitled',
      url: json['url'] as String? ?? '',
      thumbnailUrl: json['thumbnailUrl'] as String? ?? '',
    );
  }

  /// Convert Photo back to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'albumId': albumId,
      'title': title,
      'url': url,
      'thumbnailUrl': thumbnailUrl,
    };
  }

  /// Get a short title for display (max 30 characters)
  String get shortTitle {
    if (title.length <= 30) return title;
    return '${title.substring(0, 27)}...';
  }

  /// Check if the photo has valid URLs
  bool get hasValidUrls {
    return url.isNotEmpty && thumbnailUrl.isNotEmpty;
  }

  @override
  String toString() {
    return 'Photo(id: $id, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Photo && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

// 📚 Learning Notes:
//
// 1. OPTIONAL FIELDS:
//    - Use ?? operator to provide default values
//    - Handle null values gracefully in fromJson
//    - Consider what makes sense as a default
//
// 2. HELPER METHODS:
//    - Add computed properties for common operations
//    - Provide validation methods (hasValidUrls)
//    - Format data for display (shortTitle)
//
// 3. EQUALITY AND HASHING:
//    - Override == operator for object comparison
//    - Override hashCode when overriding ==
//    - Usually based on unique identifier (id)
//
// 4. JSON SAFETY:
//    - Always handle potential null values
//    - Use explicit type casting with null checks
//    - Provide sensible defaults for missing data
//
// 5. MODEL BEST PRACTICES:
//    - Keep models simple and focused
//    - Add helper methods for common operations
//    - Include validation where appropriate
//    - Make fields final for immutability

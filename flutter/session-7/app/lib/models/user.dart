// 👤 User Model for API Integration
//
// This file demonstrates how to create data models for API responses.
// It shows JSON parsing and type-safe data handling.

class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;
  final Address address;
  final Company company;

  const User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
    required this.address,
    required this.company,
  });

  /// Factory constructor to create a User from JSON data
  /// This is the standard pattern for parsing API responses
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      username: json['username'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      website: json['website'] as String? ?? '',
      address: Address.fromJson(json['address'] as Map<String, dynamic>? ?? {}),
      company: Company.fromJson(json['company'] as Map<String, dynamic>? ?? {}),
    );
  }

  /// Convert User back to JSON (useful for sending data to APIs)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'phone': phone,
      'website': website,
      'address': address.toJson(),
      'company': company.toJson(),
    };
  }

  /// Get user's initials for avatar display
  String get initials {
    final names = name.split(' ');
    if (names.isEmpty) return '?';
    if (names.length == 1) return names[0][0].toUpperCase();
    return '${names[0][0]}${names[1][0]}'.toUpperCase();
  }

  /// Get formatted full address
  String get fullAddress {
    return '${address.street}, ${address.city}';
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email)';
  }
}

class Address {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final Geo geo;

  const Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'] as String? ?? '',
      suite: json['suite'] as String? ?? '',
      city: json['city'] as String? ?? '',
      zipcode: json['zipcode'] as String? ?? '',
      geo: Geo.fromJson(json['geo'] as Map<String, dynamic>? ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'suite': suite,
      'city': city,
      'zipcode': zipcode,
      'geo': geo.toJson(),
    };
  }
}

class Geo {
  final String lat;
  final String lng;

  const Geo({required this.lat, required this.lng});

  factory Geo.fromJson(Map<String, dynamic> json) {
    return Geo(
      lat: json['lat'] as String? ?? '0',
      lng: json['lng'] as String? ?? '0',
    );
  }

  Map<String, dynamic> toJson() {
    return {'lat': lat, 'lng': lng};
  }
}

class Company {
  final String name;
  final String catchPhrase;
  final String bs;

  const Company({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      name: json['name'] as String? ?? '',
      catchPhrase: json['catchPhrase'] as String? ?? '',
      bs: json['bs'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'catchPhrase': catchPhrase, 'bs': bs};
  }
}

// 📚 Learning Notes:
//
// 1. MODEL CLASSES:
//    - Represent data structures from APIs
//    - Provide type safety and code completion
//    - Make code more maintainable and less error-prone
//
// 2. FACTORY CONSTRUCTORS:
//    - Named constructors that return instances of the class
//    - Perfect for parsing JSON data from APIs
//    - Handle type conversion and null safety
//
// 3. JSON PARSING PATTERNS:
//    - Always handle null values with ?? operator
//    - Cast types explicitly (json['id'] as num).toInt()
//    - Parse nested objects recursively
//
// 4. BEST PRACTICES:
//    - Include null safety with String? ?? ''
//    - Add helper methods for common operations (initials, fullAddress)
//    - Include toJson() for sending data back to APIs
//    - Add toString() for debugging
//
// 5. NESTED OBJECTS:
//    - Parse complex JSON with nested objects
//    - Each nested object should have its own model class
//    - Use factory constructors for all model classes

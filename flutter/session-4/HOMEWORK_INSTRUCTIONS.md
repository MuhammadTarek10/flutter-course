# Flutter Social Media App - Session 4 Assignment

## 📋 Assignment Overview

Build a complete Flutter social media application that demonstrates navigation, state management, and complex UI layouts. This assignment will help you practice bottom navigation, page views, named routes, and creating multiple interconnected screens.

## 🎯 Learning Objectives

By completing this assignment, you will:

- Master **Bottom Navigation** and **PageView** widgets
- Implement **Named Routes** for navigation between screens
- Practice creating **ListView.builder** for dynamic content
- Work with **StatefulWidget** and state management across multiple screens
- Design responsive layouts with **Cards**, **ListTiles**, and custom widgets
- Handle user interactions and navigation patterns
- Create a professional-looking multi-screen application

## 📱 Required Features

### Core Features (Must Have)

1. **Bottom Navigation Bar**: 3 tabs - Feed, Messages, Profile
2. **PageView Integration**: Smooth swiping between tabs with synchronized navigation
3. **Feed Page**: Scrollable list of social media posts with mock data
4. **Messages Page**: List of conversations with user avatars and last messages
5. **Profile Page**: User profile with stats and edit functionality
6. **Post Details Screen**: Detailed view accessible via named routes
7. **Interactive Elements**: Buttons, navigation, and user feedback

### Navigation Requirements

- **Bottom Navigation Bar** with proper state management
- **PageView** controller for smooth page transitions
- **Named Routes** for navigation to post details
- **Arguments passing** between screens
- Synchronized navigation between bottom bar and page view

### UI Requirements

- Clean, modern social media interface
- Consistent color scheme and theming
- Responsive design for different screen sizes
- Proper use of Material Design components
- Smooth animations and transitions
- Loading states and user feedback

## 🏗️ App Structure

Your app should have the following structure:

```
SocialMediaApp (MaterialApp)
├── MainScreen (StatefulWidget)
│   ├── Bottom Navigation Bar (3 tabs)
│   ├── PageView Controller
│   └── Pages:
│       ├── FeedPage (ListView of posts)
│       ├── MessagesPage (ListView of conversations)
│       └── ProfilePage (User profile with stats)
└── PostDetailsScreen (Named route)
```

## 📋 Step-by-Step Implementation Guide

### Step 1: Project Setup and Main App Structure

1. Create the main `SocialMediaApp` with `MaterialApp`
2. Set up named routes configuration:
   - `'/'` → `MainScreen`
   - `'/post-details'` → `PostDetailsScreen`
3. Apply consistent theming with Material 3

### Step 2: Main Screen with Bottom Navigation

1. Create `MainScreen` as a `StatefulWidget`
2. Implement state variables:
   - `_currentIndex` for tracking active tab
   - `PageController` for managing page view
3. Create bottom navigation bar with 3 items:
   - Feed (Home icon)
   - Messages (Message icon)
   - Profile (Person icon)

### Step 3: PageView Integration

1. Add `PageView` widget with controller
2. Implement `_onTabTapped()` method for bottom navigation
3. Implement `_onPageChanged()` method for page swiping
4. Ensure both navigation methods are synchronized
5. Add smooth animations with `Duration` and `Curves`

### Step 4: Feed Page Implementation

1. Create mock data structure for posts:

   ```dart
   static const List<Map<String, dynamic>> posts = [
     {
       'id': 1,
       'author': 'John Doe',
       'content': 'Post content...',
       'likes': 42,
       'comments': 8,
       'time': '2 hours ago',
       'avatar': '👨‍💻',
     },
     // Add more posts...
   ];
   ```

2. Implement `ListView.builder` for displaying posts
3. Create post cards with:
   - User avatar and name
   - Post timestamp
   - Post content
   - Like and comment counts
   - Navigation to post details

### Step 5: Messages Page Implementation

1. Create mock conversation data
2. Use `ListView.builder` with `ListTile` widgets
3. Include user avatars, names, last messages, and timestamps
4. Add tap functionality with `SnackBar` feedback

### Step 6: Profile Page Implementation

1. Create user profile layout with:
   - Large profile avatar
   - User name and username
   - Bio/description text
   - Statistics row (Posts, Followers, Following)
   - Edit profile button
2. Use `SingleChildScrollView` for scrollable content
3. Create helper method `_buildStatColumn()` for statistics

### Step 7: Post Details Screen

1. Implement named route navigation
2. Receive post data via `ModalRoute.of(context)!.settings.arguments`
3. Create detailed post view with:
   - Larger user information
   - Full post content
   - Like and comment buttons
   - Mock comments section
4. Add back navigation with `AppBar`

### Step 8: Polish and Testing

1. Add consistent styling and theming
2. Test all navigation flows
3. Ensure responsive design
4. Add loading states and error handling
5. Test on different screen sizes

## 📝 Technical Requirements

### Required Widgets

- `MaterialApp` with named routes
- `StatefulWidget` for main screen
- `PageController` and `PageView`
- `BottomNavigationBar`
- `ListView.builder` for dynamic lists
- `Card` widgets for post display
- `ListTile` for message items
- `CircleAvatar` for user avatars
- `SingleChildScrollView` for profile page
- `AppBar` for navigation
- `ElevatedButton` and `OutlinedButton`
- `SnackBar` for user feedback

### Key Concepts to Implement

- **State Management**: Use `setState()` for UI updates
- **Navigation**: Named routes and argument passing
- **Controllers**: PageController for synchronized navigation
- **Event Handling**: Tab taps, page changes, button presses
- **Data Structures**: Working with Lists and Maps
- **Layout Management**: Responsive design with Flex widgets

## 🎨 Design Guidelines

### Color Scheme

- Primary: Blue (`Colors.blue`)
- Backgrounds: Light colors with proper contrast
- Text: Dark for readability, grey for secondary text
- Interactive elements: Consistent button styling

### Layout Principles

- Consistent padding and margins (8.0, 16.0, 20.0)
- Card elevation for depth (elevation: 2)
- Proper spacing between elements
- Responsive design considerations

### User Experience

- Smooth animations (300ms duration)
- Visual feedback for all interactions
- Clear navigation patterns
- Intuitive iconography

## 📊 Mock Data Structure

### Posts Data

```dart
{
  'id': int,
  'author': String,
  'content': String,
  'likes': int,
  'comments': int,
  'time': String,
  'avatar': String (emoji),
}
```

### Messages Data

```dart
{
  'name': String,
  'lastMessage': String,
  'time': String,
  'avatar': String (emoji),
}
```

## 🚀 Bonus Features (Optional)

If you finish early, try adding these extra features:

- **Pull-to-refresh** on feed page
- **Search functionality** in messages
- **Like button animation** with state changes
- **Image support** in posts
- **Dark theme** toggle
- **Persistent navigation** state
- **Custom transitions** between screens
- **Floating action button** for new posts

## 📋 Submission Checklist

Before submitting, ensure your app has:

- [ ] Working bottom navigation with 3 tabs
- [ ] PageView with smooth transitions
- [ ] Feed page with scrollable post list
- [ ] Messages page with conversation list
- [ ] Profile page with user information and stats
- [ ] Post details screen accessible via navigation
- [ ] Named routes properly configured
- [ ] Consistent UI design and theming
- [ ] No runtime errors or warnings
- [ ] Proper code formatting and organization
- [ ] All interactive elements provide feedback

## 🔍 Testing Scenarios

Test these user flows:

1. **Tab Navigation**: Switch between all three tabs using bottom navigation
2. **Page Swiping**: Swipe left/right to change pages and verify bottom navigation updates
3. **Post Details**: Tap on posts to navigate to details screen
4. **Back Navigation**: Use back button from post details
5. **Message Interactions**: Tap on conversations and verify snackbar appears
6. **Profile Actions**: Tap edit profile button and verify feedback
7. **Responsive Design**: Test in different orientations and screen sizes

## 📚 Key Learning Resources

### Flutter Widgets Documentation

- [BottomNavigationBar](https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html)
- [PageView](https://api.flutter.dev/flutter/widgets/PageView-class.html)
- [ListView.builder](https://api.flutter.dev/flutter/widgets/ListView/ListView.builder.html)
- [Named Routes](https://docs.flutter.dev/development/ui/navigation/named-routes)

### Code Structure Example

```dart
class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _onTabTapped(int index) {
    setState(() => _currentIndex = index);
    _pageController.animateToPage(index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut);
  }

  // ... rest of implementation
}
```

## ⏰ Estimated Timeline

- **Day 1**: Project setup, main structure, and navigation framework
- **Day 2**: Feed page implementation with mock data
- **Day 3**: Messages and Profile pages
- **Day 4**: Post details screen and named routes
- **Day 5**: Polish, testing, and bonus features

## 🆘 Common Issues and Solutions

### Navigation Issues

- **Problem**: Bottom navigation not syncing with PageView
- **Solution**: Ensure both `_onTabTapped()` and `_onPageChanged()` update `_currentIndex`

### Layout Issues

- **Problem**: Content overflow or improper sizing
- **Solution**: Use `Expanded`, `Flexible`, or `SingleChildScrollView` appropriately

### State Management

- **Problem**: UI not updating after state changes
- **Solution**: Always wrap state changes in `setState()`

## 🎉 Success Criteria

Your assignment will be successful if:

- The app runs smoothly without crashes
- All navigation patterns work correctly
- The UI is professional and user-friendly
- Code is well-organized and readable
- You can demonstrate understanding of the concepts used

## 📝 Code Quality Guidelines

- Use meaningful variable and method names
- Add comments for complex logic
- Follow Flutter/Dart naming conventions
- Organize code into logical sections
- Remove unused imports and variables

Remember: Focus on understanding the navigation patterns and state management concepts. This project demonstrates real-world app architecture patterns that you'll use in professional development!

---

**Good luck with your social media app! 🚀**

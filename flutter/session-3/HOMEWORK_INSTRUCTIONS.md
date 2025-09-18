# Flutter Quiz App - Homework Instructions

## 📋 Assignment Overview

Build a complete Flutter quiz application that tests users' knowledge about Flutter development. This assignment will help you practice state management, UI design, and user interaction handling.

## 🎯 Learning Objectives

By completing this assignment, you will:

- Practice using StatefulWidget and state management
- Learn to handle user interactions
- Work with lists and data structures
- Implement conditional UI rendering
- Create responsive and attractive layouts

## 📱 Required Features

### Core Features (Must Have)

1. **Quiz Questions**: Display at least 4 multiple-choice questions
2. **Answer Selection**: Allow users to select answers with buttons
3. **Score Tracking**: Keep track of correct answers and total score
4. **Progress Indication**: Show current question number (e.g., "Question 2 of 5")
5. **Results Screen**: Display final score and percentage at the end
6. **Restart Functionality**: Allow users to retake the quiz

### UI Requirements

- Clean and professional appearance
- Easy-to-read text and buttons
- Consistent color scheme
- Responsive layout that works on different screen sizes
- Clear visual feedback for user interactions

## 🏗️ Step-by-Step Implementation Guide

### Step 1: Project Setup

1. Create a new Flutter project
2. Set up the basic app structure with MaterialApp
3. Create your main quiz screen as a StatefulWidget

### Step 2: Data Structure

Create a data structure to store your quiz questions. Each question should have:

- Question text
- Multiple answer options
- Correct answer indication or scoring system

**Hint**: Consider using a List of Maps or create a custom Question class.

### Step 3: State Variables

Identify what state your app needs to track:

- Current question index
- User's total score
- Any other relevant data

### Step 4: UI Layout

Design your quiz interface:

- Question display area
- Answer buttons
- Progress indicator
- Navigation elements

### Step 5: Logic Implementation

Implement the core functionality:

- Method to handle answer selection
- Score calculation logic
- Navigation between questions
- Quiz completion detection

### Step 6: Results Screen

Create a results page that shows:

- Final score
- Percentage or grade
- Encouraging message based on performance
- Option to restart the quiz

### Step 7: Styling and Polish

- Apply consistent theming
- Add appropriate spacing and padding
- Ensure good visual hierarchy
- Test on different screen sizes

## 📝 Technical Requirements

### Widgets You Should Use

- `StatefulWidget` for the main quiz screen
- `Column` and `Row` for layout
- `Container` for styling and spacing
- `ElevatedButton` or similar for answer options
- `Text` widgets for questions and information
- `AppBar` for the top navigation

### Key Concepts to Implement

- **State Management**: Use `setState()` to update the UI
- **Conditional Rendering**: Show different screens based on quiz state
- **Event Handling**: Respond to button presses
- **Data Manipulation**: Work with lists and iterate through questions

## 🎨 Design Guidelines

### Color Scheme

Choose a consistent color palette with:

- Primary color for main elements
- Secondary color for accents
- Neutral colors for text and backgrounds
- Success/error colors for feedback

### Typography

- Clear, readable fonts
- Appropriate font sizes (larger for questions, smaller for details)
- Good contrast between text and background

### Layout Principles

- Adequate spacing between elements
- Centered content where appropriate
- Consistent button sizes and styles
- Logical information hierarchy

## 📊 Sample Questions (You Can Use These or Create Your Own)

1. **What is the main building block of a Flutter UI?**

   - Functions
   - Widgets ✓
   - Classes
   - Methods

2. **Which method triggers a UI rebuild in StatefulWidget?**

   - rebuild()
   - refresh()
   - setState() ✓
   - update()

3. **What programming language does Flutter use?**

   - Java
   - Dart ✓
   - JavaScript
   - Python

4. **Which company developed Flutter?**
   - Facebook
   - Apple
   - Google ✓
   - Microsoft

## 🚀 Bonus Features (Optional)

If you finish early, try adding these extra features:

- **Timer**: Add a countdown timer for each question
- **Question Shuffle**: Randomize question order
- **Multiple Categories**: Different quiz topics
- **Difficulty Levels**: Easy, Medium, Hard questions
- **Animations**: Smooth transitions between questions
- **Sound Effects**: Audio feedback for interactions
- **High Score**: Save and display best scores

## 📋 Submission Checklist

Before submitting, make sure your app has:

- [ ] At least 4 quiz questions
- [ ] Working answer selection
- [ ] Score tracking and display
- [ ] Progress indication
- [ ] Results screen with final score
- [ ] Ability to restart the quiz
- [ ] Clean, professional UI
- [ ] No runtime errors
- [ ] Proper code formatting

## 🔍 Testing Your App

Test these scenarios:

1. **Complete Quiz**: Answer all questions and reach results screen
2. **Restart Functionality**: Use the restart button and verify it works
3. **Different Answers**: Try different answer combinations
4. **UI Responsiveness**: Test on different screen orientations
5. **Edge Cases**: What happens with no questions or empty data?

## 📚 Resources and Hints

### Useful Flutter Widgets

```dart
// For layout
Column, Row, Container, SizedBox, Padding

// For user interaction
ElevatedButton, TextButton, GestureDetector

// For styling
BoxDecoration, BorderRadius, Colors

// For navigation
Navigator (if you want multiple screens)
```

### State Management Pattern

```dart
// Example structure (don't copy exactly!)
class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // Your state variables here

  void _handleAnswer(/* parameters */) {
    setState(() {
      // Update your state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Your UI here
    );
  }
}
```

## ⏰ Timeline Suggestion

- **Day 1-2**: Project setup and data structure
- **Day 3-4**: Basic UI and question display
- **Day 5-6**: Answer handling and score tracking
- **Day 7-8**: Results screen and restart functionality
- **Day 9-10**: Styling, testing, and polish

## 🆘 Getting Help

If you're stuck:

1. Review the Flutter documentation
2. Check the course materials and examples
3. Ask specific questions during class
4. Use Flutter's hot reload to test changes quickly
5. Debug step by step - add print statements to understand the flow

## 🎉 Success Criteria

Your assignment will be considered successful if:

- The app runs without crashes
- All required features work correctly
- The code is well-organized and readable
- The UI is clean and user-friendly
- You can explain how your code works

Remember: The goal is learning, not perfection. Focus on understanding the concepts and implementing them step by step. Good luck! 🚀

---

**Due Date**: [Insert your due date here]  
**Submission**: [Insert submission instructions here]

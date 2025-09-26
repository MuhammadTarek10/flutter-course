# Flutter Quiz App - Homework Assignment

## Overview

This is a complete Flutter quiz application that demonstrates key concepts covered in our Flutter course. The app presents multiple-choice questions about Flutter development and provides immediate feedback with scoring.

## What You'll Learn

By studying and working with this code, you'll understand:

- **StatefulWidget** vs **StatelessWidget**
- **State management** with `setState()`
- **UI composition** with various Flutter widgets
- **Event handling** with button presses
- **Conditional rendering** based on app state
- **List manipulation** and **data structures**
- **Styling** and **theming** in Flutter

## App Features

- ✅ Multiple-choice quiz questions
- ✅ Score tracking
- ✅ Progress indicator
- ✅ Results screen with performance feedback
- ✅ Ability to retake the quiz
- ✅ Beautiful, responsive UI design

## Code Structure

### Main Components

#### 1. `QuizApp` (StatelessWidget)

- The root widget of the application
- Sets up the MaterialApp with theme and home screen

#### 2. `QuizScreen` (StatefulWidget)

- The main screen containing all quiz functionality
- Manages the app's state (current question, score)

#### 3. `_QuizScreenState`

- Contains the app's business logic
- Manages two main states: quiz questions and results

### Key State Variables

```dart
int _questionIndex = 0;    // Tracks current question
int _totalScore = 0;       // Tracks user's total score
```

### Data Structure

The quiz questions are stored in a `List<Map<String, Object>>`:

```dart
final List<Map<String, Object>> questions = [
  {
    'questionText': 'What is the main building block of a Flutter UI?',
    'answers': [
      {'text': 'Functions', 'score': 0},
      {'text': 'Widgets', 'score': 10},
      {'text': 'Classes', 'score': 0},
    ],
  },
  // ... more questions
];
```

## Key Methods Explained

### `_answerQuestion(int score)`

- Called when user selects an answer
- Updates the total score and moves to next question
- Uses `setState()` to trigger UI rebuild

### `_resetQuiz()`

- Resets the quiz to initial state
- Sets question index back to 0 and score to 0

### `_buildQuestion()`

- Returns the UI for displaying questions and answer options
- Uses `Column`, `Container`, and `ElevatedButton` widgets
- Dynamically generates answer buttons from the data

### `_buildResults()`

- Shows the final results screen
- Calculates percentage and provides feedback
- Includes option to restart the quiz

## Important Flutter Concepts Demonstrated

### 1. State Management

```dart
void _answerQuestion(int score) {
  setState(() {  // This triggers a UI rebuild
    _totalScore += score;
    _questionIndex++;
  });
}
```

### 2. Conditional Rendering

```dart
body: _questionIndex < questions.length
    ? _buildQuestion()    // Show questions
    : _buildResults(),    // Show results
```

### 3. Dynamic Widget Generation

```dart
...(questions[_questionIndex]['answers'] as List<Map<String, Object>>)
    .map((answer) {
      return ElevatedButton(/* ... */);
    }).toList(),
```

### 4. Styling and Theming

- Uses `Container` with `BoxDecoration` for custom styling
- Implements consistent color schemes
- Responsive padding and margins

## Homework Tasks

### Beginner Level

1. **Modify Questions**: Add 2 new questions to the quiz
2. **Change Styling**: Update the color scheme to use your favorite colors
3. **Customize Messages**: Change the result messages to your own text

### Intermediate Level

1. **Add Timer**: Implement a countdown timer for each question
2. **Question Shuffle**: Randomize the order of questions each time
3. **Answer Feedback**: Show correct/incorrect immediately after selection

### Advanced Level

1. **Categories**: Add different question categories with filtering
2. **Difficulty Levels**: Implement easy/medium/hard difficulty settings
3. **Local Storage**: Save high scores using shared_preferences
4. **Animations**: Add smooth transitions between questions

## Running the App

1. Make sure you have Flutter installed
2. Navigate to the project directory
3. Run the following commands:

```bash
flutter pub get
flutter run
```

## Key Learning Points

### Widget Hierarchy

```
Scaffold
├── AppBar
└── Body
    ├── _buildQuestion() OR _buildResults()
    ├── Column
    │   ├── Container (Question Card)
    │   └── ElevatedButton (Answer Options)
    └── Center (Results Screen)
```

### State Flow

1. App starts with `_questionIndex = 0`
2. User selects answer → `_answerQuestion()` called
3. Score updated, question index incremented
4. UI rebuilds with `setState()`
5. When all questions answered → show results
6. User can reset and start over

## Best Practices Demonstrated

- ✅ Proper widget composition
- ✅ Separation of UI and logic
- ✅ Consistent naming conventions
- ✅ Clean code structure
- ✅ Responsive design
- ✅ User-friendly interface

## Tips for Students

1. **Study the data structure** - understand how questions and answers are organized
2. **Trace the state changes** - follow how `_questionIndex` and `_totalScore` change
3. **Experiment with styling** - modify colors, fonts, and layouts
4. **Break down complex widgets** - understand how `_buildQuestion()` creates the UI
5. **Practice with setState()** - this is crucial for Flutter development

## Common Mistakes to Avoid

- Forgetting to call `setState()` when updating state variables
- Not handling edge cases (like empty question lists)
- Mixing UI and business logic
- Not using `const` constructors where possible
- Ignoring responsive design principles

## Next Steps

After understanding this code, you should be able to:

- Create your own quiz app with different topics
- Implement basic state management in Flutter
- Design responsive UIs with proper styling
- Handle user interactions effectively

Good luck with your homework! Remember to experiment and make the app your own. 🚀

---

_Happy Coding!_ 💻✨

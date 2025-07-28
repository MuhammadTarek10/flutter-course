# Session 3: State, Interaction, and Data Flow

## 🎯 Core Objectives

- Understand the concept of **state** and why it's necessary for dynamic apps.
- Learn the critical difference between a `StatelessWidget` and a `StatefulWidget`.
- Master the use of `setState()` to update the UI in response to user input.
- Grasp the basic data flow: state data is held in the `State` object and flows into the `build` method to create the UI.

## ✅ Prerequisites

- Comfortable building a static UI with core layout widgets (from Session 2).

---

## **Module 1: The "Why" - Introducing State**

**Goal:** Explain why `StatelessWidget` has limitations and introduce the concept of state in a simple, non-technical way.

1.  **The Problem:** Start by referencing the static apps from Session 2. Pose the question: _"What if we wanted to add a 'Like' counter that updates when we tap it? With only a `StatelessWidget`, we can't. Why? Because stateless widgets are like printed photographs—they are immutable and cannot change after they are created."_
2.  **Define State:** Use a simple analogy.
    - **Analogy:** "Think of **state** as the memory of your app. It's any data that can change over time. The current number on a counter, the text typed into a search bar, or whether a switch is on or off—that's all state."
3.  **Introduce `StatefulWidget`:**
    - Explain this is Flutter's special widget for handling data that changes.
    - Describe its two-part structure:
      1.  **The Widget Part:** The immutable configuration (e.g., `class MyCounterPage extends StatefulWidget`).
      2.  **The State Part:** The mutable worker that holds the data and the `build` method (e.g., `class _MyCounterPageState extends State<MyCounterPage>`).
4.  **The Magic of `setState()`:**
    - Stress this is the most critical concept of the session.
    - Explain its two jobs: "When you call `setState()`, you're telling Flutter two things: 1) 'I'm about to change some data,' and 2) 'After I'm done, please re-run the `build` method so the user can see the changes.'"

---

## **Module 2: Building a Stateful App**

**Goal:** Put theory into practice by building two simple, fun, and interactive stateful apps from scratch.

**(0:45 - 1:30) | Live Coding Pt. 1: The Classic Counter**

- **Action:** Build the standard Flutter counter app to demonstrate the core loop: User Action -> `setState()` -> Rebuild.
- **Steps:**
  1.  Create a new `StatefulWidget`.
  2.  In the `State` class, define the state variable: `int _counter = 0;`.
  3.  In the `build` method, display the `_counter` value in a `Text` widget.
  4.  Add a button (like `FloatingActionButton` or `ElevatedButton`) with an `onPressed` property.
  5.  Inside `onPressed`, call `setState()` to update the counter.

**(1:30 - 2:15) | Live Coding Pt. 2: The Dice Roller**

- **Action:** Build a more visual app to solidify the concept.
- **Steps:**
  1.  **Add Assets:** How to add image assets (e.g., `dice-1.png`, `dice-2.png`) to the project by creating an `assets/images/` folder and declaring it in `pubspec.yaml`.
  2.  **Create the UI:** Build a `StatefulWidget` that displays a dice image and a "Roll Dice" button.
  3.  **Manage State:** The state variable will be the current dice number: `int _diceNumber = 1;`.
  4.  **Display the Image:** Use `Image.asset('assets/images/dice-$_diceNumber.png')` to dynamically show the correct dice face.
  5.  **Add Logic:** In the button's `onPressed`, generate a random number from 1 to 6 and use `setState()` to update `_diceNumber`. _(Requires importing `dart:math`)_.

---

## **Module 3: Homework & What's Next**

### 🚀 The Simple Quiz App

**Goal:** Build a complete, stateful quiz app. This will test your ability to manage state that changes based on user decisions and to work with more complex data structures.

**Project Description:**
Create an app that presents the user with a series of multiple-choice questions. The app will keep track of the user's score and show a results screen at the end.

**Core Requirements:**

1.  **Question Data:** The app should have at least 3 questions hard-coded into it. Use a `List` of `Map`s to structure your quiz data.
2.  **Display:** Show only one question at a time, with its corresponding answer choices displayed as buttons.
3.  **State Management:** You will need to manage two key pieces of state:
    - The current question index (`_questionIndex`).
    - The user's total score (`_totalScore`).
4.  **Interaction:** When the user taps an answer button:
    - The score should be updated based on their answer.
    - The app should automatically move to the next question.
5.  **End State:** After the last question is answered, the app should stop showing questions and instead display a "Quiz Complete!" message along with the user's final score.

**Suggested Data Structure:**
To practice the data structures from Session 1, organize your questions like this in your code:

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
  {
    'questionText': 'Which method do you call to trigger a UI rebuild in a StatefulWidget?',
    'answers': [
      {'text': 'rebuild()', 'score': 0},
      {'text': 'refresh()', 'score': 0},
      {'text': 'setState()', 'score': 10},
    ],
  },
  // Add at least one more question here!
];
```

**Bonus Challenge:**
Instead of just showing the final score, can you add a "Reset Quiz" button to the results screen? This button should set the `_questionIndex` and `_totalScore` back to 0, allowing the user to take the quiz again from the beginning.

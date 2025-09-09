# 🚀 Getting Started with Dart - Workshop

## 📋 Workshop Overview

**Duration**: 60 minutes  
**Prerequisites**: Basic programming concepts

## 🎯 Learning Objectives

By the end of this workshop, you will be able to:

- ✅ Declare and use variables in Dart
- ✅ Create and call functions with parameters
- ✅ Implement conditional logic with if-else statements
- ✅ Use loops for repetitive tasks
- ✅ Apply string interpolation for output formatting

## 📚 Concepts Covered

### 1. Variables and Data Types

```dart
int age = 25;
double height = 5.9;
String name = "John";
bool isStudent = true;
```

### 2. Functions

```dart
// Function with parameters and return value
int add(int a, int b) {
  return a + b;
}

// Void function (no return value)
void greetUser(String name) {
  print('Hello, $name!');
}
```

### 3. Control Structures

```dart
// If-else statements
if (age >= 18) {
  print('You are an adult');
} else {
  print('You are a minor');
}
```

### 4. Loops

```dart
// For loop
for (int i = 0; i < 5; i++) {
  print('Count: $i');
}

// While loop
int counter = 0;
while (counter < 3) {
  print('Counter: $counter');
  counter++;
}
```

## 🎮 Workshop Challenge: Number Guessing Game

### Task Description

Create an interactive number guessing game that demonstrates all the concepts you've learned!

### Game Requirements

1. **Generate Random Number**: Create a function that generates a random number between 1-100
2. **User Input**: Get user guesses from the console
3. **Game Logic**: Implement the guessing logic with hints
4. **Loop Control**: Allow multiple attempts (maximum 7)
5. **Feedback System**: Provide "too high", "too low", or "correct" feedback
6. **Play Again**: Ask if the user wants to play another round

### Step-by-Step Implementation Guide

#### Step 1: Set Up the Basic Structure

```dart
import 'dart:io';
import 'dart:math';

// TODO: Create function to generate random number
int generateRandomNumber() {
  // Your code here
}

// TODO: Create function to get player guess
int getPlayerGuess() {
  // Your code here
}

// TODO: Create function to check guess
String checkGuess(int guess, int target) {
  // Your code here
}

void main() {
  // TODO: Implement main game loop
}
```

#### Step 2: Implement Each Function

**Function 1: Generate Random Number**

```dart
int generateRandomNumber() {
  Random random = Random();
  return random.nextInt(100) + 1; // Returns 1-100
}
```

**Function 2: Get Player Guess**

```dart
int getPlayerGuess() {
  stdout.write('Enter your guess (1-100): ');
  String? input = stdin.readLineSync();
  return int.parse(input ?? '0');
}
```

**Function 3: Check Guess**

```dart
String checkGuess(int guess, int target) {
  if (guess < target) {
    return 'Too low! Try a higher number.';
  } else if (guess > target) {
    return 'Too high! Try a lower number.';
  } else {
    return 'Congratulations! You guessed it!';
  }
}
```

#### Step 3: Implement Main Game Logic

```dart
void main() {
  bool playAgain = true;

  while (playAgain) {
    // Game setup
    int targetNumber = generateRandomNumber();
    int attempts = 0;
    int maxAttempts = 7;
    bool hasWon = false;

    print('\n🎮 Welcome to the Number Guessing Game!');
    print('I\'m thinking of a number between 1 and 100.');
    print('You have $maxAttempts attempts to guess it!\n');

    // Game loop
    while (attempts < maxAttempts && !hasWon) {
      attempts++;
      print('Attempt $attempts of $maxAttempts');

      int guess = getPlayerGuess();
      String result = checkGuess(guess, targetNumber);

      print(result);

      if (guess == targetNumber) {
        hasWon = true;
        print('🎉 You won in $attempts attempts!');
      } else if (attempts == maxAttempts) {
        print('😔 Game over! The number was $targetNumber');
      }

      print(''); // Empty line for readability
    }

    // Play again logic
    stdout.write('Do you want to play again? (y/n): ');
    String? response = stdin.readLineSync();
    playAgain = response?.toLowerCase() == 'y';
  }

  print('Thanks for playing! 👋');
}
```

### 🏆 Challenge Extensions

Once you complete the basic game, try these enhancements:

1. **Difficulty Levels**: Add easy (1-50), medium (1-100), hard (1-200) modes
2. **Score System**: Track wins, losses, and average attempts
3. **Input Validation**: Handle invalid inputs gracefully
4. **Hints System**: Provide additional hints (even/odd, divisible by certain numbers)
5. **High Score**: Track the best performance (fewest attempts)

### Example Game Flow

```
🎮 Welcome to the Number Guessing Game!
I'm thinking of a number between 1 and 100.
You have 7 attempts to guess it!

Attempt 1 of 7
Enter your guess (1-100): 50
Too high! Try a lower number.

Attempt 2 of 7
Enter your guess (1-100): 25
Too low! Try a higher number.

Attempt 3 of 7
Enter your guess (1-100): 37
Too low! Try a higher number.

Attempt 4 of 7
Enter your guess (1-100): 43
Congratulations! You guessed it!
🎉 You won in 4 attempts!

Do you want to play again? (y/n): n
Thanks for playing! 👋
```

## 🔧 How to Run Your Code

1. **Navigate to the folder**:

   ```bash
   cd "1. getting-started"
   ```

2. **Run your program**:

   ```bash
   dart main.dart
   ```

3. **Test thoroughly**: Try different inputs and edge cases

## ✅ Self-Assessment Checklist

Before moving to the next workshop, ensure you can:

- [ ] Declare variables of different types (`int`, `double`, `String`, `bool`)
- [ ] Create functions with parameters and return values
- [ ] Use string interpolation (`$variable` and `${expression}`)
- [ ] Implement if-else conditional logic
- [ ] Write and control for loops and while loops
- [ ] Handle user input and output
- [ ] Structure a complete program with multiple functions

## 🎯 Key Takeaways

1. **Variables** store data and have specific types
2. **Functions** organize code into reusable blocks
3. **Control structures** make decisions in your program
4. **Loops** repeat actions efficiently
5. **String interpolation** creates dynamic output
6. **Program structure** matters for readability and maintenance

## 🔗 Next Steps

Once you've mastered these concepts, you're ready for:

- **Workshop 2**: Data Structures (Lists, Maps, Sets)
- Working with collections of data
- More complex data organization

---

### 💡 Pro Tips

- **Experiment**: Modify the code to see what happens
- **Debug**: Use `print()` statements to understand program flow
- **Practice**: Try creating variations of the guessing game
- **Ask Questions**: Don't hesitate to seek help when stuck

**Happy Coding! 🎉**

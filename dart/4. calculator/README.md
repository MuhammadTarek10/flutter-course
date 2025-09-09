# 🧮 Advanced Calculator Project - Workshop

## 📋 Workshop Overview

**Duration**: 90 minutes  
**Difficulty**: Intermediate to Advanced  
**Prerequisites**: All previous workshops (variables, functions, data structures, OOP)

## 🎯 Learning Objectives

By the end of this workshop, you will be able to:

- ✅ Integrate all Dart concepts into a comprehensive project
- ✅ Implement advanced calculator operations
- ✅ Handle user input and validation
- ✅ Create a menu-driven application
- ✅ Implement error handling and edge cases
- ✅ Build a calculator with memory and history features
- ✅ Apply OOP principles in a real-world scenario

## 📚 Project Requirements Review

### Basic Requirements (From task.md)

- ✅ Create a `Calculator` class with OOP principles
- ✅ Implement basic operations (add, subtract, multiply, divide)
- ✅ Handle user input and output
- ✅ Implement error handling for division by zero and invalid operators

### Advanced Requirements (Workshop Extension)

- 🚀 Scientific operations (power, square root, percentage)
- 🚀 Memory functions (store, recall, clear)
- 🚀 Calculation history with display and management
- 🚀 Menu-driven interface
- 🚀 Input validation and error handling
- 🚀 Continuous calculation mode
- 🚀 Advanced mathematical functions

## 🏗️ Workshop Challenge: Scientific Calculator with Advanced Features

### Task Description

Build a comprehensive scientific calculator that demonstrates mastery of all Dart concepts through a feature-rich, user-friendly application!

### Step-by-Step Implementation Guide

#### Step 1: Enhanced Calculator Base Class

```dart
import 'dart:io';
import 'dart:math';

abstract class CalculatorOperations {
  // Basic operations
  double add(double a, double b);
  double subtract(double a, double b);
  double multiply(double a, double b);
  double? divide(double a, double b);

  // Scientific operations
  double power(double base, double exponent);
  double squareRoot(double number);
  double percentage(double number, double percent);
}

class ScientificCalculator implements CalculatorOperations {
  // Memory storage
  double _memory = 0;

  // Calculation history
  List<CalculationRecord> _history = [];

  // Last result for continuous calculations
  double _lastResult = 0;

  // Constructor
  ScientificCalculator();

  // Getters
  double get memory => _memory;
  double get lastResult => _lastResult;
  List<CalculationRecord> get history => List.unmodifiable(_history);

  // Basic Operations Implementation
  @override
  double add(double a, double b) {
    double result = a + b;
    _recordCalculation('$a + $b', result);
    _lastResult = result;
    return result;
  }

  @override
  double subtract(double a, double b) {
    double result = a - b;
    _recordCalculation('$a - $b', result);
    _lastResult = result;
    return result;
  }

  @override
  double multiply(double a, double b) {
    double result = a * b;
    _recordCalculation('$a × $b', result);
    _lastResult = result;
    return result;
  }

  @override
  double? divide(double a, double b) {
    if (b == 0) {
      print('❌ Error: Division by zero is not allowed!');
      return null;
    }
    double result = a / b;
    _recordCalculation('$a ÷ $b', result);
    _lastResult = result;
    return result;
  }

  // Scientific Operations Implementation
  @override
  double power(double base, double exponent) {
    double result = pow(base, exponent).toDouble();
    _recordCalculation('$base ^ $exponent', result);
    _lastResult = result;
    return result;
  }

  @override
  double squareRoot(double number) {
    if (number < 0) {
      throw ArgumentError('Cannot calculate square root of negative number');
    }
    double result = sqrt(number);
    _recordCalculation('√$number', result);
    _lastResult = result;
    return result;
  }

  @override
  double percentage(double number, double percent) {
    double result = (number * percent) / 100;
    _recordCalculation('$percent% of $number', result);
    _lastResult = result;
    return result;
  }

  // Advanced Mathematical Operations
  double factorial(int n) {
    if (n < 0) throw ArgumentError('Factorial is not defined for negative numbers');
    if (n == 0 || n == 1) return 1;

    double result = 1;
    for (int i = 2; i <= n; i++) {
      result *= i;
    }

    _recordCalculation('$n!', result);
    _lastResult = result;
    return result;
  }

  double sine(double angleInDegrees) {
    double angleInRadians = angleInDegrees * pi / 180;
    double result = sin(angleInRadians);
    _recordCalculation('sin($angleInDegrees°)', result);
    _lastResult = result;
    return result;
  }

  double cosine(double angleInDegrees) {
    double angleInRadians = angleInDegrees * pi / 180;
    double result = cos(angleInRadians);
    _recordCalculation('cos($angleInDegrees°)', result);
    _lastResult = result;
    return result;
  }

  double tangent(double angleInDegrees) {
    double angleInRadians = angleInDegrees * pi / 180;
    double result = tan(angleInRadians);
    _recordCalculation('tan($angleInDegrees°)', result);
    _lastResult = result;
    return result;
  }

  double logarithm(double number, [double base = 10]) {
    if (number <= 0) throw ArgumentError('Logarithm is not defined for non-positive numbers');

    double result = log(number) / log(base);
    String baseStr = base == 10 ? '' : '_$base';
    _recordCalculation('log$baseStr($number)', result);
    _lastResult = result;
    return result;
  }

  // Memory Operations
  void memoryStore(double value) {
    _memory = value;
    print('✅ Stored $value in memory');
  }

  double memoryRecall() {
    print('📋 Memory recall: $_memory');
    return _memory;
  }

  void memoryClear() {
    _memory = 0;
    print('🗑️ Memory cleared');
  }

  void memoryAdd(double value) {
    _memory += value;
    print('✅ Added $value to memory. New value: $_memory');
  }

  void memorySubtract(double value) {
    _memory -= value;
    print('✅ Subtracted $value from memory. New value: $_memory');
  }

  // History Management
  void _recordCalculation(String expression, double result) {
    _history.add(CalculationRecord(expression, result, DateTime.now()));

    // Keep only last 50 calculations
    if (_history.length > 50) {
      _history.removeAt(0);
    }
  }

  void displayHistory([int? count]) {
    if (_history.isEmpty) {
      print('📝 No calculation history available');
      return;
    }

    int itemsToShow = count ?? _history.length;
    itemsToShow = itemsToShow > _history.length ? _history.length : itemsToShow;

    print('\n📜 Calculation History (Last $itemsToShow):');
    print('${'─' * 50}');

    for (int i = _history.length - itemsToShow; i < _history.length; i++) {
      CalculationRecord record = _history[i];
      String timeStr = '${record.timestamp.hour.toString().padLeft(2, '0')}:'
                      '${record.timestamp.minute.toString().padLeft(2, '0')}:'
                      '${record.timestamp.second.toString().padLeft(2, '0')}';

      print('${i + 1}. [$timeStr] ${record.expression} = ${_formatResult(record.result)}');
    }
    print('${'─' * 50}');
  }

  void clearHistory() {
    _history.clear();
    print('🗑️ Calculation history cleared');
  }

  CalculationRecord? getLastCalculation() {
    return _history.isNotEmpty ? _history.last : null;
  }

  // Utility Methods
  String _formatResult(double result) {
    // Format result to remove unnecessary decimal places
    if (result == result.roundToDouble()) {
      return result.toInt().toString();
    } else {
      return result.toStringAsFixed(6).replaceAll(RegExp(r'0*$'), '').replaceAll(RegExp(r'\.$'), '');
    }
  }

  double? performOperation(double a, String operator, double b) {
    switch (operator) {
      case '+':
        return add(a, b);
      case '-':
        return subtract(a, b);
      case '*':
      case '×':
        return multiply(a, b);
      case '/':
      case '÷':
        return divide(a, b);
      case '^':
      case '**':
        return power(a, b);
      case '%':
        return percentage(a, b);
      default:
        print('❌ Error: Invalid operator "$operator"');
        return null;
    }
  }

  // Statistics
  Map<String, dynamic> getStatistics() {
    if (_history.isEmpty) {
      return {'totalCalculations': 0, 'averageResult': 0, 'mostUsedOperation': 'None'};
    }

    double sum = 0;
    Map<String, int> operationCount = {};

    for (CalculationRecord record in _history) {
      sum += record.result;

      // Count operations
      for (String op in ['+', '-', '×', '÷', '^', '√', '%']) {
        if (record.expression.contains(op)) {
          operationCount[op] = (operationCount[op] ?? 0) + 1;
          break;
        }
      }
    }

    String mostUsedOp = 'None';
    int maxCount = 0;
    operationCount.forEach((op, count) {
      if (count > maxCount) {
        maxCount = count;
        mostUsedOp = op;
      }
    });

    return {
      'totalCalculations': _history.length,
      'averageResult': sum / _history.length,
      'mostUsedOperation': mostUsedOp,
      'operationBreakdown': operationCount,
    };
  }
}
```

#### Step 2: Calculation Record Class

```dart
class CalculationRecord {
  final String expression;
  final double result;
  final DateTime timestamp;

  CalculationRecord(this.expression, this.result, this.timestamp);

  @override
  String toString() {
    return '$expression = $result (${timestamp.toString().substring(11, 19)})';
  }
}
```

#### Step 3: User Interface and Menu System

```dart
class CalculatorInterface {
  final ScientificCalculator _calculator = ScientificCalculator();

  void run() {
    print('🧮 Welcome to the Advanced Scientific Calculator!');
    print('${'═' * 50}');

    while (true) {
      _displayMainMenu();
      String? choice = _getInput('\n👉 Enter your choice');

      if (choice == null) continue;

      switch (choice.toLowerCase()) {
        case '1':
          _basicCalculatorMode();
          break;
        case '2':
          _scientificCalculatorMode();
          break;
        case '3':
          _memoryOperations();
          break;
        case '4':
          _historyOperations();
          break;
        case '5':
          _displayStatistics();
          break;
        case '6':
          _continuousCalculationMode();
          break;
        case '0':
        case 'exit':
        case 'quit':
          print('\n👋 Thank you for using the Scientific Calculator!');
          return;
        default:
          print('❌ Invalid choice. Please try again.');
      }
    }
  }

  void _displayMainMenu() {
    print('\n${'═' * 50}');
    print('📋 MAIN MENU');
    print('${'═' * 50}');
    print('1️⃣  Basic Calculator');
    print('2️⃣  Scientific Calculator');
    print('3️⃣  Memory Operations');
    print('4️⃣  History Management');
    print('5️⃣  Statistics');
    print('6️⃣  Continuous Calculation Mode');
    print('0️⃣  Exit');
    print('${'═' * 50}');
  }

  void _basicCalculatorMode() {
    print('\n🧮 Basic Calculator Mode');
    print('Available operations: +, -, *, /, ^, %');
    print('Type "back" to return to main menu\n');

    while (true) {
      String? input = _getInput('Enter calculation (e.g., "5 + 3") or "back"');
      if (input == null) continue;

      if (input.toLowerCase() == 'back') break;

      _processBasicCalculation(input);
    }
  }

  void _scientificCalculatorMode() {
    print('\n🔬 Scientific Calculator Mode');
    print('Available functions:');
    print('• sqrt(x) - Square root');
    print('• sin(x), cos(x), tan(x) - Trigonometric functions (degrees)');
    print('• log(x) - Logarithm base 10');
    print('• ln(x) - Natural logarithm');
    print('• fact(x) - Factorial');
    print('Type "back" to return to main menu\n');

    while (true) {
      String? input = _getInput('Enter function (e.g., "sqrt(25)") or "back"');
      if (input == null) continue;

      if (input.toLowerCase() == 'back') break;

      _processScientificCalculation(input);
    }
  }

  void _processBasicCalculation(String input) {
    try {
      // Parse input like "5 + 3"
      List<String> parts = input.split(' ');
      if (parts.length != 3) {
        print('❌ Invalid format. Use: number operator number');
        return;
      }

      double num1 = double.parse(parts[0]);
      String operator = parts[1];
      double num2 = double.parse(parts[2]);

      double? result = _calculator.performOperation(num1, operator, num2);
      if (result != null) {
        print('✅ Result: ${_formatResult(result)}');
      }
    } catch (e) {
      print('❌ Error: Invalid input format or numbers');
    }
  }

  void _processScientificCalculation(String input) {
    try {
      input = input.toLowerCase().replaceAll(' ', '');

      if (input.startsWith('sqrt(') && input.endsWith(')')) {
        String numStr = input.substring(5, input.length - 1);
        double number = double.parse(numStr);
        double result = _calculator.squareRoot(number);
        print('✅ Result: ${_formatResult(result)}');
      } else if (input.startsWith('sin(') && input.endsWith(')')) {
        String numStr = input.substring(4, input.length - 1);
        double number = double.parse(numStr);
        double result = _calculator.sine(number);
        print('✅ Result: ${_formatResult(result)}');
      } else if (input.startsWith('cos(') && input.endsWith(')')) {
        String numStr = input.substring(4, input.length - 1);
        double number = double.parse(numStr);
        double result = _calculator.cosine(number);
        print('✅ Result: ${_formatResult(result)}');
      } else if (input.startsWith('tan(') && input.endsWith(')')) {
        String numStr = input.substring(4, input.length - 1);
        double number = double.parse(numStr);
        double result = _calculator.tangent(number);
        print('✅ Result: ${_formatResult(result)}');
      } else if (input.startsWith('log(') && input.endsWith(')')) {
        String numStr = input.substring(4, input.length - 1);
        double number = double.parse(numStr);
        double result = _calculator.logarithm(number);
        print('✅ Result: ${_formatResult(result)}');
      } else if (input.startsWith('ln(') && input.endsWith(')')) {
        String numStr = input.substring(3, input.length - 1);
        double number = double.parse(numStr);
        double result = _calculator.logarithm(number, e);
        print('✅ Result: ${_formatResult(result)}');
      } else if (input.startsWith('fact(') && input.endsWith(')')) {
        String numStr = input.substring(5, input.length - 1);
        int number = int.parse(numStr);
        double result = _calculator.factorial(number);
        print('✅ Result: ${_formatResult(result)}');
      } else {
        print('❌ Unknown function. Available: sqrt, sin, cos, tan, log, ln, fact');
      }
    } catch (e) {
      print('❌ Error: Invalid input or calculation error');
    }
  }

  void _memoryOperations() {
    print('\n💾 Memory Operations');
    print('Current memory value: ${_formatResult(_calculator.memory)}');
    print('Available operations:');
    print('• store <number> - Store number in memory');
    print('• recall - Recall memory value');
    print('• clear - Clear memory');
    print('• add <number> - Add to memory');
    print('• subtract <number> - Subtract from memory');
    print('Type "back" to return to main menu\n');

    while (true) {
      String? input = _getInput('Enter memory operation or "back"');
      if (input == null) continue;

      if (input.toLowerCase() == 'back') break;

      _processMemoryOperation(input);
    }
  }

  void _processMemoryOperation(String input) {
    List<String> parts = input.toLowerCase().split(' ');

    try {
      switch (parts[0]) {
        case 'store':
          if (parts.length != 2) {
            print('❌ Usage: store <number>');
            return;
          }
          double value = double.parse(parts[1]);
          _calculator.memoryStore(value);
          break;
        case 'recall':
          _calculator.memoryRecall();
          break;
        case 'clear':
          _calculator.memoryClear();
          break;
        case 'add':
          if (parts.length != 2) {
            print('❌ Usage: add <number>');
            return;
          }
          double value = double.parse(parts[1]);
          _calculator.memoryAdd(value);
          break;
        case 'subtract':
          if (parts.length != 2) {
            print('❌ Usage: subtract <number>');
            return;
          }
          double value = double.parse(parts[1]);
          _calculator.memorySubtract(value);
          break;
        default:
          print('❌ Unknown memory operation');
      }
    } catch (e) {
      print('❌ Error: Invalid number format');
    }
  }

  void _historyOperations() {
    print('\n📜 History Management');
    print('Available operations:');
    print('• show [count] - Show history (optionally specify count)');
    print('• clear - Clear history');
    print('• last - Show last calculation');
    print('Type "back" to return to main menu\n');

    while (true) {
      String? input = _getInput('Enter history operation or "back"');
      if (input == null) continue;

      if (input.toLowerCase() == 'back') break;

      _processHistoryOperation(input);
    }
  }

  void _processHistoryOperation(String input) {
    List<String> parts = input.toLowerCase().split(' ');

    switch (parts[0]) {
      case 'show':
        if (parts.length == 1) {
          _calculator.displayHistory();
        } else {
          try {
            int count = int.parse(parts[1]);
            _calculator.displayHistory(count);
          } catch (e) {
            print('❌ Invalid count. Usage: show [count]');
          }
        }
        break;
      case 'clear':
        _calculator.clearHistory();
        break;
      case 'last':
        CalculationRecord? last = _calculator.getLastCalculation();
        if (last != null) {
          print('📝 Last calculation: ${last.toString()}');
        } else {
          print('📝 No calculations in history');
        }
        break;
      default:
        print('❌ Unknown history operation');
    }
  }

  void _displayStatistics() {
    print('\n📊 Calculator Statistics');
    print('${'─' * 40}');

    Map<String, dynamic> stats = _calculator.getStatistics();

    print('Total calculations: ${stats['totalCalculations']}');
    if (stats['totalCalculations'] > 0) {
      print('Average result: ${_formatResult(stats['averageResult'])}');
      print('Most used operation: ${stats['mostUsedOperation']}');

      print('\nOperation breakdown:');
      Map<String, int> breakdown = stats['operationBreakdown'];
      breakdown.forEach((op, count) {
        print('  $op: $count times');
      });
    }

    print('Current memory: ${_formatResult(_calculator.memory)}');
    print('Last result: ${_formatResult(_calculator.lastResult)}');
    print('${'─' * 40}');

    _getInput('\nPress Enter to continue');
  }

  void _continuousCalculationMode() {
    print('\n🔄 Continuous Calculation Mode');
    print('Start with a number, then enter operations.');
    print('Use "ans" to reference the last result.');
    print('Type "exit" to return to main menu\n');

    double currentResult = 0;
    bool hasResult = false;

    while (true) {
      String prompt = hasResult ?
        'Current result: ${_formatResult(currentResult)} | Next operation' :
        'Enter starting number';

      String? input = _getInput(prompt);
      if (input == null) continue;

      if (input.toLowerCase() == 'exit') break;

      if (!hasResult) {
        // First number
        try {
          currentResult = double.parse(input);
          hasResult = true;
          print('✅ Starting with: ${_formatResult(currentResult)}');
        } catch (e) {
          print('❌ Please enter a valid number');
        }
      } else {
        // Process operation
        _processContinuousOperation(input, currentResult, (result) {
          currentResult = result;
        });
      }
    }
  }

  void _processContinuousOperation(String input, double currentResult, Function(double) updateResult) {
    try {
      // Replace "ans" with current result
      input = input.replaceAll('ans', currentResult.toString());

      // Parse operation like "+ 5" or "* 3"
      List<String> parts = input.trim().split(' ');
      if (parts.length == 2) {
        String operator = parts[0];
        double operand = double.parse(parts[1]);

        double? result = _calculator.performOperation(currentResult, operator, operand);
        if (result != null) {
          updateResult(result);
          print('✅ Result: ${_formatResult(result)}');
        }
      } else {
        print('❌ Invalid format. Use: operator number (e.g., "+ 5")');
      }
    } catch (e) {
      print('❌ Error: Invalid operation format');
    }
  }

  String? _getInput(String prompt) {
    stdout.write('$prompt: ');
    return stdin.readLineSync()?.trim();
  }

  String _formatResult(double result) {
    if (result == result.roundToDouble()) {
      return result.toInt().toString();
    } else {
      return result.toStringAsFixed(6).replaceAll(RegExp(r'0*$'), '').replaceAll(RegExp(r'\.$'), '');
    }
  }
}
```

#### Step 4: Main Function

```dart
void main() {
  try {
    CalculatorInterface interface = CalculatorInterface();
    interface.run();
  } catch (e) {
    print('💥 Fatal error: $e');
    print('Please restart the calculator.');
  }
}
```

### 🏆 Challenge Extensions

Once you complete the advanced calculator, try these enhancements:

1. **Expression Parser**: Parse complex expressions like "(5 + 3) \* 2"
2. **Unit Converter**: Add temperature, length, weight conversions
3. **Graphing**: Simple ASCII art graphs for functions
4. **Programmable**: Allow users to define custom functions
5. **File I/O**: Save/load calculations to/from files
6. **Complex Numbers**: Support for complex number arithmetic
7. **Matrix Operations**: Basic matrix calculations
8. **Currency Converter**: Real-time exchange rates (if internet available)

### Expected Features Summary

✅ **Basic Operations**: +, -, \*, /, ^, %  
✅ **Scientific Functions**: sqrt, sin, cos, tan, log, ln, factorial  
✅ **Memory Operations**: store, recall, clear, add, subtract  
✅ **History Management**: display, clear, search  
✅ **Statistics**: usage analytics and operation breakdown  
✅ **Continuous Mode**: chain calculations seamlessly  
✅ **Error Handling**: comprehensive validation and error messages  
✅ **User Interface**: intuitive menu system  
✅ **Data Persistence**: maintain state during session

## 🔧 How to Run Your Code

1. **Navigate to the folder**:

   ```bash
   cd "4. calculator"
   ```

2. **Run your program**:

   ```bash
   dart main.dart
   ```

3. **Test thoroughly**: Try all features and edge cases

## ✅ Final Assessment Checklist

Ensure your calculator can:

- [ ] Perform all basic mathematical operations
- [ ] Handle scientific calculations (trigonometry, logarithms, etc.)
- [ ] Manage memory operations (store, recall, modify)
- [ ] Track and display calculation history
- [ ] Provide usage statistics and analytics
- [ ] Handle errors gracefully (division by zero, invalid input)
- [ ] Offer multiple interaction modes (basic, scientific, continuous)
- [ ] Validate all user inputs
- [ ] Format results appropriately
- [ ] Provide helpful user feedback and instructions

## 🎯 Key Integration Points

This project demonstrates:

1. **Variables & Data Types**: Numbers, strings, booleans
2. **Functions**: Methods with parameters and return values
3. **Control Structures**: If-else statements, switch cases
4. **Loops**: For iteration and menu systems
5. **Data Structures**: Lists for history, Maps for statistics
6. **OOP**: Classes, inheritance, encapsulation, polymorphism
7. **Error Handling**: Try-catch blocks and validation
8. **User Interaction**: Input/output and menu navigation
9. **State Management**: Memory and session persistence
10. **Code Organization**: Modular design and separation of concerns

## 🏁 Completion Criteria

Your calculator project is complete when:

- ✅ All basic requirements from `task.md` are implemented
- ✅ Advanced features are working correctly
- ✅ Error handling covers all edge cases
- ✅ User interface is intuitive and helpful
- ✅ Code is well-organized and documented
- ✅ All features have been tested thoroughly

## 🔗 Next Steps

Congratulations! You've completed the Dart fundamentals course. You're now ready for:

- **Flutter Development**: Building mobile applications
- **Advanced Dart**: Async programming, streams, isolates
- **Design Patterns**: More sophisticated software architecture
- **Testing**: Unit tests and integration tests

---

### 💡 Final Pro Tips

- **Code Quality**: Write clean, readable, and maintainable code
- **User Experience**: Always consider the user's perspective
- **Error Prevention**: Validate inputs before processing
- **Documentation**: Comment complex logic and algorithms
- **Testing**: Test edge cases and error conditions
- **Performance**: Consider efficiency in calculations and memory usage

### 🎉 Congratulations!

You've successfully built a comprehensive scientific calculator that demonstrates mastery of all Dart programming fundamentals. This project showcases your ability to:

- Design and implement complex software systems
- Apply object-oriented programming principles
- Handle user interaction and error cases
- Organize code into maintainable modules
- Integrate multiple programming concepts seamlessly

**You're now ready for Flutter development! 🚀**

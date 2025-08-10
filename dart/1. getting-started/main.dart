// * Functions
int multiply(int a, int b) {
  return a * b;
}

void main() {
  // * Variables
  int number1 = 5;
  int number2 = 6;

  print('number 1: $number1 | number 2: $number2');
  print('result: ${multiply(number1, number2)}');

  // * If Statements
  if (number2 > 2)
    print('Number 2 is more than 2');
  else
    print('Number 2 is not bigger than 2');

  // * Loops
  for (var i = 0; i < number1; i++) {
    print('Number 1 -> ${i + 1}');
  }

  int j = 0;
  while (j < number2) {
    print('Number 2 -> ${j + 1}');
  }
}

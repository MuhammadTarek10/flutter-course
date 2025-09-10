void main() {
  List<int> numbers = [1, 2, 3, 4, 5];

  for (int num in numbers) {
    print('number: $num');
  }

  Map<int, int> mp = {1: 5, 2: 3};
  print('Map<int, int>: $mp');

  Map<int, String> sp = {1: 'number 1', 2: 'number 2'};
  print('Map<int, String>: $sp');

  Set<int> st = {1, 2, 3, 4, 5};
  print('Set<int>: $st');
}

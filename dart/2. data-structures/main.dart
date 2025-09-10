void main() {
  List<int> numbers = [1, 29, 3, 4, 5];

  numbers.add(2);
// [1, 29, 3, 4, 5, 2];
numbers.remove(5)
// [1, 29, 3, 4, 2];
numbers.length

  for (int num in numbers) {
    print('number: $num');
  }

  Map<int, int> mp = {1: 5, 2: 3};
  print('Map<int, int>: $mp');
  mp[1];
  mp.containsKey(5)
  mp[3] = 2;
  mp.keys; // [1, 2]
  mp.values; // [5, 3]

  Map<int, String> sp = {1: 'number 1', 2: 'number 2'};
  print('Map<int, String>: $sp');

  Set<int> st = {1, 2, 3, 4, 5};
  print('Set<int>: $st');
}

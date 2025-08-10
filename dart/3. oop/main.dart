class Car {
  // members
  String brand;
  String model;
  double speed;

  // constructor
  Car(this.brand, this.model, this.speed);

  // methods
  void info() {
    print('brand: $brand | model: $model | speed: $speed');
  }

  @override
  String toString() {
    return 'ToString() -> brand: $brand | model: $model | speed: $speed';
  }
}

void main() {
  Car bmw = Car("BMW", "M3", 250.24);
  Car nissan = Car("Nissan", "N5", 220.12);

  print(bmw.toString());
  print(nissan.toString());
}

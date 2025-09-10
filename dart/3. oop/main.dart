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

class Shape {
int width;
int length;

Shape(this.width, this.length);

int getArea(){
return this.width*this.length;
}
}

class Circle extends Shape {
int r1;

Circle(this.r1): super(r1, r1);

@override
double getArea() {
return 3.14 * this.r1;
}


}

final x = Cricle(1)

void main() {
  Car bmw = Car("BMW", "M3", 250.24);
  Car nissan = Car("Nissan", "N5", 220.12);

  print(bmw.toString());
  print(nissan.toString());
}

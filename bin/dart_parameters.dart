// Positional parameters
int add(int a, int b) => a + b; // add(1, 2)

// Optional positional paramaters
int add2(int a, [int b = 0]) => a + b; // add(1)

// Required named paramaters
int add3({required int a, required int b}) => a + b; // add(a: 1, b: 1)

// Optional named paramaters
int add4({int a = 0, int b = 0}) => a + b; // add(), add(a: 1), add(b: 2)

void main() {
  print(add(1, 2)); // returns 3
  print(add2(1)); // returns 1 (since b defaults to 0)
  print(add2(1, 2)); // returns 3 (b is provided its default value is not used)
  print(add3(a: 1, b: 2)); // return 3
  print(add4()); // returns 0 a and b defaults to 0
  print(add4(a: 3)); // return 3, b defaults to 0
  print(add4(b: 3)); // returns 3, a defaults to 0
}

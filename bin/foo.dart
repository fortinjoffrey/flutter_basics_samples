class Foo {
  final String? bar;
  
  Foo({this.bar});
  
  Foo copyWith({String? bar}) {
    return Foo(bar: bar ?? this.bar);
  }
}
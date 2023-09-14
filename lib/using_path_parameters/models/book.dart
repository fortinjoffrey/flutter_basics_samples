
import 'dart:convert';

class Book {
  final String name;
  final String author;

  Book({required this.name, required this.author});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'name': name});
    result.addAll({'author': author});
  
    return result;
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      name: map['name'] ?? '',
      author: map['author'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) => Book.fromMap(json.decode(source));

  @override
  String toString() => 'Book(name: $name, author: $author)';
}

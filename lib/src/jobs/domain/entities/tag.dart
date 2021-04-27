import 'dart:ui';
import 'dart:io';
import 'package:meta/meta.dart';

class Tag extends Object {
  int id;
  String name;

  Tag({
    @required this.id,
    @required this.name,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) || this.hashCode == other.hashCode;

  @override
  int get hashCode => id;

  static empty() {
    return Tag(
      id: 0,
      name: ''
    );
  }
}

List demeTags = [
  Tag(
    id: 1,
    name: '',
  ),
  Tag(
    id: 2,
    name: '',
  ),
];

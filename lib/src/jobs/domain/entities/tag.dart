import 'dart:ui';
import 'dart:io';
import 'package:meta/meta.dart';

class Tag extends Object {
  //const Tag.pure([int id, String name = '']) : super.pure(id, name);
  //const Tag.dirty([int id, String name = '']) : super.dirty(id, name);

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

  @override
  int compareTo(other) {
    if (other is String) {
      if (this.name == null && other == null)
        return 0;
      else if (this.name == null && other != null)
        return 1;
      else if (this.name != null && other == null)
        return -1;
      return this.name.toLowerCase().compareTo(other.toLowerCase());
    }

    if (this.id == null && other.id == null)
      return 0;
    else if (this.id == null && other.id != null)
      return 1;
    else if (this.id != null && other.id == null)
      return -1;

    if ((this.id > other.id) == true)
      return 1;
    else if ((this.id < other.id) == true)
      return -1;

    return 0;
  }

  static empty() {
    return Tag(
      id: 0,
      name: ''
    );
  }

  static List<Tag> defaultTags = [
    Tag(
      id: 1,
      name: 'Handy Man',
    ),
    Tag(
      id: 2,
      name: 'Window Cleaner',
    ),
  ];
}

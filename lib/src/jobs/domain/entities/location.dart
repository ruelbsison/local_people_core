import 'package:meta/meta.dart';

class Location extends Object {
  /// {@macro Location}
  Location({
    @required this.id,
    @required this.name,
  })  : assert(id != null);

  /// The current Location's email address.
  String name;

  /// The current Location's id.
  int id;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || this.hashCode == other.hashCode;

  @override
  int get hashCode => id;

  static empty() {
    return Location(
        id: 0,
        name: ''
    );
  }
}
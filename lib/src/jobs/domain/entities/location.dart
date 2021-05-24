import 'package:meta/meta.dart';

class Location extends Object {
  /// {@macro Location}
  Location({
    @required this.id,
    @required this.name,
    @required this.clientId,
    @required this.traderId,
    this.lat,
    this.long,
    this.address,
    this.photoUrl,
    this.jobId,
  });

  /// The current Location's email address.
  String name;

  /// The current Location's id.
  int id;

  String address;

  String photoUrl;

  double lat;

  double long;

  int jobId;

  int clientId;

  int traderId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || this.hashCode == other.hashCode;

  @override
  int get hashCode => id;

  static empty() {
    return Location(
        id: 0,
        name: '',
      lat: 0.0,
      long: 0.0,
      address: '',
        photoUrl: '',
      clientId: 0,
      traderId: 0,
    );
  }
}

import 'dart:ui';

class Profile extends Object {
  Profile({
    id = 0,
    userId = 0,
    photo = 'packages/local_people_core/assets/images/company-logo.png',
    fullName = 'Name Here',
    memberSince = null,
    email = '',
    description = '',
    address = '',
    intro = '',
  }): super() {

  }

  int _id;
  int get id => _id;
  set id(int value) {
    _id = value;
  }

  int _userId;
  int get userId => _userId;
  set userId(int value) {
    this._userId = value;
  }

  String _description;
  String get description => _description;
  set address(String value) {
    this._address = value;
  }

  String _address;
  String get address => _address;
  set description(String value) {
    this._description = value;
  }

  String _intro;
  String get intro => _intro;
  set intro(String value) {
    this._intro = value;
  }

  String _fullName;
  String get fullName => _fullName;
  set fullName(String value) {
    this._fullName = value;
  }

  String _photo;
  String get photo => _photo;
  set photo(String value) {
    this._photo = value;
  }

  DateTime _memberSince;
  DateTime get memberSince => _memberSince;
  set memberSince(DateTime value) {
    this._memberSince = value;
  }

  String _email;
  String get email => _email;
  set email(String value) {
    this._email = value;
  }


  @override
  bool operator ==(Object other) =>
      identical(this, other) || this.hashCode == other.hashCode;

  @override
  int get hashCode => id;

  static get empty => Profile(id: 0, userId: 0, fullName: '', photo: '', memberSince: null,
      email: '', description: '', address: '', intro: '');

}

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Qualification extends Equatable {
  final int id;
  final int traderId;
  final String title;
  Qualification({
    this.id,
    this.traderId,
    @required this.title,
  });

  @override
  List<Object> get props => [id, traderId, title];
}
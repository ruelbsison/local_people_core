import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Package extends Equatable {
  final String name;
  final String description;
  final int durationInHours;
  final double cost;
  Package({
    @required this.name,
    this.description,
    this.durationInHours,
    this.cost,
  });

  @override
  List<Object> get props => [name, description, durationInHours, cost];
}
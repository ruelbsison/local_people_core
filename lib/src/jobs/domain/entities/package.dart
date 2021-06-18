import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:local_people_core/core.dart';

enum PackageOptionType {
  VIEW_ONLY,
  ADD_DEFAULT,
  REMOVE,
  ADD_NEW,
}

class Package  extends Equatable implements Comparable {
  int id;
  String name;
  String description;
  int traderId;
  String createdAt;
  String updatedAt;
  int durationInHours;
  double cost;
  PackageOptionType optionType;
  EntityStatus entityStatus;

  Package(
      {this.id,
      this.name,
      this.description,
      this.durationInHours,
      this.cost,
      this.traderId,
      this.createdAt,
      this.updatedAt,
      this.optionType = PackageOptionType.VIEW_ONLY,
      this.entityStatus = EntityStatus.ENTIRY_STATUS_COMPLETED});

  @override
  List<Object> get props => [id, name, description, traderId,
    createdAt, updatedAt, durationInHours, cost, optionType, entityStatus];

  Package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    traderId = json['trader_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['trader_id'] = this.traderId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  @override
  int compareTo(other) {
    if (this.id != null && other.id != null
    && this.id > 0 && other.id > 0) {
      if (this.id < other.id) {
        return 1;
      } else if (this.id > other.id) {
        return -1;
      }
      return 0;
    }

    if (this.name != null && other.name != null) {
      return this.name.toLowerCase().compareTo(other.name.toLowerCase());
    }

    return 0;
  }
}

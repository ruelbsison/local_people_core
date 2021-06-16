import 'package.dart';
import '../../data/models/package_model.dart';

class PackageResponse {
  Exception exception;
  Package package;

  void fromModel(PackageModel model) {
    package = Package (
      id: model.id,
      traderId : model.trader_id,
      name: model.name,
      description: model.description,
      createdAt: model.created_at,
      updatedAt: model.updated_at,
    );
  }

  static PackageModel fromPackage(Package package) {
    return PackageModel (
      id: package.id,
      trader_id : package.traderId,
      name: package.name,
      description: package.description,
      created_at: package.createdAt,
      updated_at: package.updatedAt,
    );
  }
}
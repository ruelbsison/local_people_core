import 'package.dart';
import '../../data/models/package_model.dart';

class PackageResponse {
  Exception exception;
  Package package;

  void fromModel(PackageModel model) {
    package = Package (
      id: model.id,
      traderId : model.traderId,
      name: model.name,
      description: model.description,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }

  static PackageModel fromPackage(Package package) {
    return PackageModel (
      id: package.id,
      traderId : package.traderId,
      name: package.name,
      description: package.description,
      createdAt: package.createdAt,
      updatedAt: package.updatedAt,
    );
  }
}
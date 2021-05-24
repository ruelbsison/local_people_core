
import 'package.dart';
import '../../data/models/package_model.dart';

class PackageListResponse {
  Exception exception;
  List<Package> packages;

  void fromModel(List<PackageModel> list) {
    packages = List<Package>();

    var listIter = list.iterator;
    while(listIter.moveNext() ) {
      PackageModel model = listIter.current;
      Package package = Package(
        id: model.id,
        traderId : model.traderId,
        name: model.name,
        description: model.description,
        createdAt: model.createdAt,
        updatedAt: model.updatedAt,
      );

      packages.add(package);
    }
  }
}


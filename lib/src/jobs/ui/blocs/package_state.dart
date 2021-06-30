part of 'package_bloc.dart';

abstract class PackageState extends Equatable {
  const PackageState();
}

class PackageInitial extends PackageState {
  @override
  List<Object> get props => [];
}

class PackageAdding extends PackageState {
  @override
  List<Object> get props => [];
}

class PackageAdded extends PackageState {
  final Package package;

  const PackageAdded(this.package);

  @override
  List<Object> get props {
    return [package];
  }
}

class PackageAddFailed extends PackageState {
  final String e;

  const PackageAddFailed(this.e);

  @override
  List<Object> get props {
    return [e];
  }

  @override
  String toString() {
    return 'PackageAddFailed{e: $e}';
  }
}

class PackageDeleting extends PackageState {
  @override
  List<Object> get props => [];
}

class PackageDeleted extends PackageState {
  final int id;

  const PackageDeleted(this.id);

  @override
  List<Object> get props {
    return [id];
  }
}

class PackageDeleteFailed extends PackageState {
  final String e;

  const PackageDeleteFailed(this.e);

  @override
  List<Object> get props {
    return [e];
  }

  @override
  String toString() {
    return 'PackageDeleteFailed{e: $e}';
  }
}

class PackageLoading extends PackageState {
  @override
  List<Object> get props => [];
}

class PackageLoaded extends PackageState {
  final List<Package> packages;

  const PackageLoaded(this.packages);

  @override
  List<Object> get props {
    return [packages];
  }
}

class PackageLoadFailed extends PackageState {
  final String e;

  const PackageLoadFailed(this.e);

  @override
  List<Object> get props {
    return [e];
  }

  @override
  String toString() {
    return 'PackageLoadFailed{e: $e}';
  }
}

class PackageUpdating extends PackageState {
  @override
  List<Object> get props => [];
}

class PackageUpdateed extends PackageState {
  final Package package;

  const PackageUpdateed(this.package);

  @override
  List<Object> get props {
    return [package];
  }
}

class PackageUpdateFailed extends PackageState {
  final String e;

  const PackageUpdateFailed(this.e);

  @override
  List<Object> get props {
    return [e];
  }

  @override
  String toString() {
    return 'PackageUpdateFailed{e: $e}';
  }
}



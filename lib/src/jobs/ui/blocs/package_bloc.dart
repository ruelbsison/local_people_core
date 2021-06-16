import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../domain/entities/package.dart';
import '../../domain/entities/package_response.dart';
import '../../domain/entities/package_list_response.dart';
import '../../domain/repositories/package_repository.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'package_event.dart';
part 'package_state.dart';

class PackageBloc extends Bloc<PackageEvent, PackageState> {
  final PackageRepository packageRepository;

  PackageBloc({
    @required this.packageRepository
  }) : super(PackageInitial());

  @override
  Stream<PackageState> mapEventToState(
    PackageEvent event,
  ) async* {
    if (event is PackageAddEvent) {
      yield PackageAdding();
      yield* _mapPackageAddToState(event.package);
    } else if (event is PackageDeleteEvent) {
      yield PackageDeleting();
      yield* _mapPackageDeleteToState(event.id);
    } else if (event is PackageGetEvent) {
      yield PackageLoading();
      yield* _mapPackageLoadToState(event.id);
    } else if (event is PackageUpdateEvent) {
      yield PackageUpdating();
      yield* _mapPackageUpdateToState(event.package);
    }
  }

  Stream<PackageState> _mapPackageAddToState(Package Package) async* {
    try {
      PackageResponse response = await packageRepository.createPackage(Package);
      if (response != null && response.exception != null) {
        yield PackageAddFailed(response.exception.toString());
      } else if (response != null && response.package == null) {
        yield  PackageAddFailed('');
      } else if (response != null && response.package != null) {
        yield PackageAdded(response.package);
      }
    } catch (e) {
      yield PackageAddFailed(e.toString());
    }
  }

  Stream<PackageState> _mapPackageUpdateToState(Package Package) async* {
    try {
      PackageResponse response = await packageRepository.updatePackage(Package);
      if (response != null && response.exception != null) {
        yield PackageUpdateFailed(response.exception.toString());
      } else if (response != null && response.package == null) {
        yield  PackageUpdateFailed('');
      } else if (response != null && response.package != null) {
        yield PackageUpdateed(response.package);
      }
    } catch (e) {
      yield PackageUpdateFailed(e.toString());
    }
  }

  Stream<PackageState> _mapPackageDeleteToState(int id) async* {
    PackageResponse response = PackageResponse();
    try {
      response.exception = await packageRepository.deletePackage(id);
      if (response != null && response.exception != null) {
        yield PackageUpdateFailed(response.exception.toString());
      } else if (response != null && response.package == null) {
        yield  PackageUpdateFailed('');
      } else if (response != null && response.package != null) {
        yield PackageUpdateed(response.package);
      }
    } catch (e) {
      yield PackageUpdateFailed(e.toString());
    }
  }

  Stream<PackageState> _mapPackageLoadToState(int traderId) async* {
    try {
      PackageListResponse response = await packageRepository.listTraderPackages(traderId);
      if (response != null && response.exception != null) {
        yield PackageLoadFailed(response.exception.toString());
      } else if (response != null && response.packages == null) {
        yield  PackageLoadFailed('');
      } else if (response != null && response.packages != null) {
        yield PackageLoaded(response.packages);
      }
    } catch (e) {
      yield PackageLoadFailed(e.toString());
    }
  }
}

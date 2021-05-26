import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'package_event.dart';
part 'package_state.dart';

class PackageBloc extends Bloc<PackageEvent, PackageState> {
  PackageBloc() : super(PackageInitial());

  @override
  Stream<PackageState> mapEventToState(
    PackageEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}

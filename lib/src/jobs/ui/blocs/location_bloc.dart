import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../domain/entities/location.dart';
import '../../domain/entities/location_list_response.dart';
import '../../domain/entities/location_response.dart';
import '../../domain/repositories/location_repository.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository locationRepository;

  LocationBloc({@required this.locationRepository}) : super(LocationInitial());

  @override
  Stream<LocationState> mapEventToState(
    LocationEvent event,
  ) async* {
     if (event is LoadJobLocationEvent) {
      yield JobLocationLoading();
      yield* _mapLoadJobLocationToState(event.jobId);
    } else if (event is GetLocationEvent) {
       yield GetLocationLoading();
       yield* _mapGetLocationToState(event.id);
     }
  }

  Stream<LocationState> _mapLoadJobLocationToState(int jobId) async* {
    try {
      LocationResponse response = await locationRepository.listJobLocations(jobId);
      if (response == null) {
        yield LoadJobLocationFailed();
      } else if (response != null && response.exception != null) {
        yield LoadJobLocationFailed();
      } else if (response != null && response.location != null) {
        yield JobLocationLoaded(location: response.location);
      }
    } catch (e) {
      yield LoadJobLocationFailed();
    }
  }

  Stream<LocationState> _mapGetLocationToState(int id) async* {
    try {
      LocationResponse response = await locationRepository.showLocation(id);
      if (response == null) {
        yield GetLocationFailed();
      } else if (response != null && response.exception != null) {
        yield GetLocationFailed();
      } else if (response != null && response.location != null) {
        yield GetLocationLoaded(location: response.location);
      }
    } catch (e) {
      yield LoadJobLocationFailed();
    }
  }
}

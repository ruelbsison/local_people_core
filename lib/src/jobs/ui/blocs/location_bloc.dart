import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../domain/entities/location.dart';
import '../../domain/entities/location_list_response.dart';
import '../../domain/entities/location_response.dart';
import '../../domain/repositories/location_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/transformers.dart';

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

  @override
  Stream<Transition<LocationEvent, LocationState>> transformEvents(
      Stream<LocationEvent> events, TransitionFunction<LocationEvent, LocationState> transitionFn) {
    final otherStream = events
        .where((event) => event is! GetLocationLoading);
    final withIntervalStream = events
        .where((event) => event is GetLocationLoading)
        .interval(const Duration(seconds: 1));
    return super.transformEvents(
        MergeStream<LocationEvent> ([otherStream, withIntervalStream]),
        transitionFn);
  }

  @override
  Stream<Transition<LocationEvent, LocationState>> transformTransitions(
      Stream<Transition<LocationEvent, LocationState>> transitions) {
    final otherStream = transitions
        .where((event) => event is! GetLocationLoading);
    final withIntervalStream = transitions
        .where((event) => event is GetLocationLoading)
        .interval(const Duration(seconds: 1));
    return super.transformTransitions(
        MergeStream<Transition<LocationEvent, LocationState>>
          ([otherStream, withIntervalStream]));
  }

  Stream<LocationState> _mapLoadJobLocationToState(int jobId) async* {
    try {
      LocationResponse response = await locationRepository.listJobLocations(jobId);
      if (response == null) {
        yield LoadJobLocationFailed();
      } else if (response != null && response.exception != null) {
        yield LoadJobLocationFailed();
      } else if (response != null && response.location != null) {
        //await Future<void>.delayed(const Duration(seconds: 1));
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
        //await Future<void>.delayed(const Duration(seconds: 1));
        yield GetLocationLoaded(location: response.location);
      }
    } catch (e) {
      yield LoadJobLocationFailed();
    }
  }
}

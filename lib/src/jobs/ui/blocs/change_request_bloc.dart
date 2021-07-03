import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../domain/entities/change_request.dart';
import '../../domain/entities/change_request_response.dart';
import '../../domain/entities/change_request_list_response.dart';
import '../../domain/repositories/change_request_repository.dart';

part 'change_request_event.dart';
part 'change_request_state.dart';

class ChangeRequestBloc extends Bloc<ChangeRequestEvent, ChangeRequestState> {
  final ChangeRequestRepository changeRequestRepository;
  ChangeRequestBloc({
      @required this.changeRequestRepository,
}) : super(ChangeRequestInitial());

  @override
  Stream<ChangeRequestState> mapEventToState(
    ChangeRequestEvent event,
  ) async* {
    if (event is ChangeRequestAddEvent) {
      yield ChangeRequestAdding();
      yield* _mapAddChangeRequestToState(event.changeRequest);
    } else if (event is JobChangeRequestLoadEvent) {
      yield JobChangeRequestLoading();
      yield* _mapJobChangeRequestLoadToState(event.jobId);
    }
  }

  Stream<ChangeRequestState> _mapAddChangeRequestToState(ChangeRequest changeRequest) async* {
    try {
      ChangeRequestResponse response = await changeRequestRepository.createChangeRequest(changeRequest);
      if (response == null) {
        yield ChangeRequestAddFailed('');
      } else if (response.exception != null) {
        yield ChangeRequestAddFailed(response.exception.toString());
      } else if (response.changeRequest != null) {
        yield ChangeRequestAdded(response.changeRequest);
      }
    } catch (e) {
      print(e.toString());
      yield ChangeRequestAddFailed(e.toString());
    }
  }

  Stream<ChangeRequestState> _mapJobChangeRequestLoadToState(int jobId) async* {
    try {
      ChangeRequestListResponse response = await changeRequestRepository.listJobChangeRequests(jobId);
      if (response == null) {
        yield JobChangeRequestFailed('');
      } else if (response.exception != null) {
        yield JobChangeRequestFailed(response.exception.toString());
      } else if (response.changeRequests != null) {
        yield JobChangeRequestLoaded(response.changeRequests);
      }
    } catch (e) {
      print(e.toString());
      yield JobChangeRequestFailed(e.toString());
    }
  }
}

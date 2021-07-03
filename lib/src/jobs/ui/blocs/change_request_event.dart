part of 'change_request_bloc.dart';

abstract class ChangeRequestEvent extends Equatable {
  const ChangeRequestEvent();
}

class ChangeRequestAddEvent extends ChangeRequestEvent {
  final ChangeRequest changeRequest;

  ChangeRequestAddEvent({
    @required this.changeRequest,
  });

  @override
  List<Object> get props => [changeRequest];
}

class JobChangeRequestLoadEvent extends ChangeRequestEvent {
  final int jobId;

  JobChangeRequestLoadEvent({
    @required this.jobId,
  });

  @override
  List<Object> get props => [jobId];
}

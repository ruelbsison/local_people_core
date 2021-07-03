part of 'change_request_bloc.dart';

abstract class ChangeRequestState extends Equatable {
  const ChangeRequestState();
}

class ChangeRequestInitial extends ChangeRequestState {
  @override
  List<Object> get props => [];
}

class ChangeRequestAdding extends ChangeRequestState {
  @override
  List<Object> get props => [];
}

class ChangeRequestAdded extends ChangeRequestState {
  final ChangeRequest changeRequest;

  const ChangeRequestAdded(this.changeRequest);

  @override
  List<Object> get props {
    return [changeRequest];
  }
}

class ChangeRequestAddFailed extends ChangeRequestState {
  final String error;

  const ChangeRequestAddFailed(this.error);

  @override
  List<Object> get props {
    return [error];
  }

  @override
  String toString() {
    return 'ChangeRequestAddFailed{error: $error}';
  }
}

class JobChangeRequestLoading extends ChangeRequestState {
  @override
  List<Object> get props => [];
}

class JobChangeRequestLoaded extends ChangeRequestState {
  final List<ChangeRequest> changeRequets;

  const JobChangeRequestLoaded(this.changeRequets);

  @override
  List<Object> get props {
    return [changeRequets];
  }
}

class JobChangeRequestFailed extends ChangeRequestState {
  final String error;

  const JobChangeRequestFailed(this.error);

  @override
  List<Object> get props {
    return [error];
  }

  @override
  String toString() {
    return 'JobChangeRequestFailed{error: $error}';
  }
}

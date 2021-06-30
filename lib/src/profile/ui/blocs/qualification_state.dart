part of 'qualification_bloc.dart';

abstract class QualificationState extends Equatable {
  const QualificationState();
}

class QualificationInitial extends QualificationState {
  @override
  List<Object> get props => [];
}

class QualificationAdding extends QualificationState {
  @override
  List<Object> get props => [];
}

class QualificationAdded extends QualificationState {
  final Qualification qualification;

  const QualificationAdded(this.qualification);

  @override
  List<Object> get props {
    return [qualification];
  }
}

class QualificationAddFailed extends QualificationState {
  final String e;

  const QualificationAddFailed(this.e);

  @override
  List<Object> get props {
    return [e];
  }

  @override
  String toString() {
    return 'QualificationAddFailed{e: $e}';
  }
}

class QualificationDeleting extends QualificationState {
  @override
  List<Object> get props => [];
}

class QualificationDeleted extends QualificationState {
  final int id;

  const QualificationDeleted(this.id);

  @override
  List<Object> get props {
    return [id];
  }
}

class QualificationDeleteFailed extends QualificationState {
  final String e;

  const QualificationDeleteFailed(this.e);

  @override
  List<Object> get props {
    return [e];
  }

  @override
  String toString() {
    return 'QualificationDeleteFailed{e: $e}';
  }
}

class QualificationLoading extends QualificationState {
  @override
  List<Object> get props => [];
}

class QualificationLoaded extends QualificationState {
  final List<Qualification> qualifications;

  const QualificationLoaded(this.qualifications);

  @override
  List<Object> get props {
    return [qualifications];
  }
}

class QualificationLoadFailed extends QualificationState {
  final String e;

  const QualificationLoadFailed(this.e);

  @override
  List<Object> get props {
    return [e];
  }

  @override
  String toString() {
    return 'QualificationLoadFailed{e: $e}';
  }
}

class QualificationUpdating extends QualificationState {
  @override
  List<Object> get props => [];
}

class QualificationUpdateed extends QualificationState {
  final Qualification qualification;

  const QualificationUpdateed(this.qualification);

  @override
  List<Object> get props {
    return [qualification];
  }
}

class QualificationUpdateFailed extends QualificationState {
  final String e;

  const QualificationUpdateFailed(this.e);

  @override
  List<Object> get props {
    return [e];
  }

  @override
  String toString() {
    return 'QualificationUpdateFailed{e: $e}';
  }
}


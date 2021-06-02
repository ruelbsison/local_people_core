import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../domain/entities/qualification.dart';
import '../../domain/entities/qualification_response.dart';
import '../../domain/entities/qualification_list_response.dart';
import '../../domain/repositories/qualification_repository.dart';

part 'qualification_event.dart';
part 'qualification_state.dart';

class QualificationBloc extends Bloc<QualificationEvent, QualificationState> {
  final QualificationRepository qualificationRepository;

  QualificationBloc(@required this.qualificationRepository) : super(QualificationInitial());

  @override
  Stream<QualificationState> mapEventToState(
    QualificationEvent event,
  ) async* {
    if (event is QualificationAddEvent) {
      yield QualificationAdding();
      yield* _mapQualificationAddToState(event.qualification);
    } else if (event is QualificationDeleteEvent) {
      yield QualificationDeleting();
      yield* _mapQualificationDeleteToState(event.id);
    } else if (event is QualificationGetEvent) {
      yield QualificationLoading();
      yield* _mapQualificationLoadToState(event.id);
    } else if (event is QualificationUpdateEvent) {
      yield QualificationUpdating();
      yield* _mapQualificationUpdateToState(event.qualification);
    }
  }

  Stream<QualificationState> _mapQualificationAddToState(Qualification qualification) async* {
    try {
      QualificationResponse response = await qualificationRepository.createQualification(qualification);
      if (response != null && response.exception != null) {
        yield QualificationAddFailed(response.exception.toString());
      } else if (response != null && response.qualification == null) {
        yield  QualificationAddFailed('');
      } else if (response != null && response.qualification != null) {
        yield QualificationAdded(response.qualification);
      }
    } catch (e) {
      yield QualificationAddFailed(e.toString());
    }
  }

  Stream<QualificationState> _mapQualificationUpdateToState(Qualification qualification) async* {
    try {
      QualificationResponse response = await qualificationRepository.updateQualification(qualification);
      if (response != null && response.exception != null) {
        yield QualificationUpdateFailed(response.exception.toString());
      } else if (response != null && response.qualification == null) {
        yield  QualificationUpdateFailed('');
      } else if (response != null && response.qualification != null) {
        yield QualificationUpdateed(response.qualification);
      }
    } catch (e) {
      yield QualificationUpdateFailed(e.toString());
    }
  }

  Stream<QualificationState> _mapQualificationDeleteToState(int id) async* {
    QualificationResponse response = QualificationResponse();
    try {
      response.exception = await qualificationRepository.deleteQualification(id);
      if (response != null && response.exception != null) {
        yield QualificationUpdateFailed(response.exception.toString());
      } else if (response != null && response.qualification == null) {
        yield  QualificationUpdateFailed('');
      } else if (response != null && response.qualification != null) {
        yield QualificationUpdateed(response.qualification);
      }
    } catch (e) {
      yield QualificationUpdateFailed(e.toString());
    }
  }

  Stream<QualificationState> _mapQualificationLoadToState(int traderId) async* {
    try {
      QualificationListResponse response = await qualificationRepository.listTraderQualifications(traderId);
      if (response != null && response.exception != null) {
        yield QualificationLoadFailed(response.exception.toString());
      } else if (response != null && response.qualifications == null) {
        yield  QualificationLoadFailed('');
      } else if (response != null && response.qualifications != null) {
        yield QualificationLoaded(response.qualifications);
      }
    } catch (e) {
      yield QualificationLoadFailed(e.toString());
    }
  }
}

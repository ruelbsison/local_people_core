import '../../../core/exceptions/server_exception.dart';
import '../../data/models/auth_session_model.dart';

class AuthSesstionResponse {
  ServerException exception;
  AuthSessionModel _authSession;
  AuthSessionModel get authSession => _authSession;

  // void jobFromModel(AuthSessionModel model) {
  //   _authSession = Job(
  //     id: model.id,
  //     client_id: model.client_id,
  //     title: model.title,
  //     description: model.description,
  //     preview: model.description,
  //     budget: model.budget,
  //     //tags: result.tags,
  //     minutesLeft: 120,
  //     //images: model.images,
  //     date: DateTime.parse(model.date),
  //   );
  //
  //   if (model.location != null) {
  //     job.location = Location (
  //       id: model.location.id,
  //       name: model.location.name,
  //       address: model.location.address,
  //       long: model.location.longitude.toDouble(),
  //       lat: model.location.latitude.toDouble(),
  //     );
  //   }
  // }
}
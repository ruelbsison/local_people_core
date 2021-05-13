
import '../../../core/exceptions/server_exception.dart';
import 'client_profile.dart';
import '../../data/models/client_model.dart';

class ClientResponse {
  ServerException exception;
  ClientProfile profile;

  void fromModel(ClientModel model) {
    profile = ClientProfile(
      id: model.id,
      fullName: model.name,
      email: model.email,
      intro: model.intro,
      memberSince: DateTime.parse(model.createdAt),
    );
  }
}


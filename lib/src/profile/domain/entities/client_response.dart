
import 'client_profile.dart';
import '../../data/models/client_model.dart';

class ClientResponse {
  Exception exception;
  ClientProfile profile;

  void fromModel(ClientModel model) {
    profile = ClientProfile(
      id: model.id,
      fullName: model.name,
      email: model.email,
      intro: model.intro,
      memberSince: DateTime.now(),
    );
  }
}


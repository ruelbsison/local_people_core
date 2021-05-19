
import '../../../core/exceptions/server_exception.dart';
import 'client_profile.dart';
import '../../data/models/client_model.dart';

class ClientListResponse {
  ServerException exception;
  List<ClientProfile> profiles;

  void fromModel(List<ClientModel>  models) {
    profiles = List<ClientProfile>();
    var listIter = models.iterator;
    while(listIter.moveNext() ) {
      ClientModel model = listIter.current;
      ClientProfile profile = ClientProfile(
          id: model.id,
          fullName: model.name,
          email: model.email,
          intro: model.intro,
          memberSince: DateTime.parse(model.created_at),
      );
      profiles.add(profile);
    }
  }

}


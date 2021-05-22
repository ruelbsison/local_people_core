
import 'trader_profile.dart';
import '../../data/models/trader_model.dart';

class TraderListResponse {
  Exception exception;
  List<TraderProfile> profiles;

  void fromModel(List<TraderModel>  models) {
    profiles = List<TraderProfile>();
    var listIter = models.iterator;
    while(listIter.moveNext() ) {
      TraderModel model = listIter.current;
      TraderProfile profile = TraderProfile(
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


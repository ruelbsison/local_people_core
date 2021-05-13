
import '../../../core/exceptions/server_exception.dart';
import 'trader_profile.dart';
import '../../data/models/trader_model.dart';

class TraderResponse {
  ServerException exception;
  TraderProfile profile;

  void fromModel(TraderModel model) {
    profile = TraderProfile(
      id: model.id,
      fullName: model.name,
      email: model.email,
      intro: model.intro,
      memberSince: DateTime.parse(model.createdAt),
    );
  }
}


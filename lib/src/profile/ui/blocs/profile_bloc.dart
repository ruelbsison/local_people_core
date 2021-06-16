import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:local_people_core/profile.dart';
import '../../domain/entities/client_profile.dart';
import '../../domain/entities/trader_profile.dart';
import 'package:meta/meta.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../domain/repositories/qualification_repository.dart';

import '../../../core/enum/app_type.dart';
import 'package:intl/intl.dart';
import 'profile_event.dart';
import 'profile_state.dart';
import 'package:local_people_core/auth.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;
  final QualificationRepository qualificationRepository;
  final AppType appType;
  final AuthLocalDataSource authLocalDataSource;

  ProfileBloc({
    @required this.profileRepository,
    @required this.qualificationRepository,
    @required this.appType,
    @required this.authLocalDataSource,}) :
        super(ProfileInitialState());

  @override
  ProfileState get initialState => ProfileInitialState();

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is ProfileGetEvent) {
      yield ProfileLoading();
      if (appType == AppType.CLIENT)
        yield* _mapClientProfileGetToState();
      else
        yield* _mapTraderProfileGetToState();
    } else if (event is ProfileCreateEvent) {
      yield ProfileCreating();
      if (appType == AppType.CLIENT)
        yield* _mapClientProfileCreateToState();
      else
        yield* _mapTraderProfileCreateToState();
    } else if (event is ClientProfileUpdateEvent) {
      yield ClientProfileUpdating();
      yield* _mapClientProfileUpdateToState(event.profile);
    } else if (event is TraderProfileUpdateEvent) {
      yield TraderProfileUpdating();
      yield* _mapTraderProfileUpdateToState(event.profile);
    } else if (event is ProfileGetTraderTopRatedEvent) {
      yield ProfileTraderTopRatedLoading();
      yield* _mapTraderProfileUGetTapRatedToState();
    } else if (event is ClientProfileGetEvent) {
      yield ClientProfileGetLoading();
      yield* _mapClientProfileGetToStateWithId(event.id);
    } else if (event is TraderProfileGetEvent) {
      yield TraderProfileGetLoading();
      yield* _mapTraderProfileGetToStateWithId(event.id);
    }
  }

  Future<List<Qualification>> getTraderQualifications(int raderId) async {
    List<Qualification> qualifications = [];
    try {
      QualificationListResponse qualificationListResponse = await qualificationRepository.listTraderQualifications(raderId);
      if (qualificationListResponse != null && qualificationListResponse.exception != null) {
      } else if (qualificationListResponse != null && qualificationListResponse.qualifications == null) {
      } else if (qualificationListResponse != null && qualificationListResponse.qualifications != null) {
        qualifications = qualificationListResponse.qualifications;
      }
    } catch (e) {
      print(e.toString());
    }

    return qualifications;
  }

  Stream<ProfileState> _mapClientProfileGetToStateWithId(int clientId) async* {
    try {
       ClientResponse response = await profileRepository.getClientProfile(clientId);
      if (response != null && response.exception != null) {
        yield ClientProfileGetFailed(response.exception.toString());
      } else if (response != null && response.profile == null) {
        yield  ClientProfileGetFailed('');
      } else if (response != null && response.profile != null) {
        AuthLocalModel authLocalModel = await authLocalDataSource.getAuth();
        response.profile.fullName = authLocalModel.userFullName;
        response.profile.photo = authLocalModel.userPhoto;
        yield ClientProfileGetLoaded(response.profile);
      }
    } catch (e) {
      yield ClientProfileGetFailed(e.toString());
    }
  }

  Stream<ProfileState> _mapTraderProfileGetToStateWithId(int clientId) async* {
    try {
      TraderResponse response = await profileRepository.getTraderProfile(clientId);
      if (response != null && response.exception != null) {
        yield TraderProfileGetFailed(response.exception.toString());
      } else if (response != null && response.profile == null) {
        yield  TraderProfileGetFailed('');
      } else if (response != null && response.profile != null) {
        AuthLocalModel authLocalModel = await authLocalDataSource.getAuth();
        response.profile.photo = authLocalModel.userPhoto;
        response.profile.fullName = authLocalModel.userFullName;

        response.profile.packages = [];
        response.profile.qualifications = [];
        response.profile.qualifications = await getTraderQualifications(response.profile.id);

        yield TraderProfileGetLoaded(response.profile);
      }
    } catch (e) {
      yield TraderProfileGetFailed(e.toString());
    }
  }

  Stream<ProfileState> _mapClientProfileGetToState() async* {
    try {
      ClientResponse response;
      int userId = await authLocalDataSource.getUserId();
      if (userId == -1) {
        final String email = await authLocalDataSource.getEmail();
        if (email == null) {
          yield ProfileNotLoaded('Email address not available!');
          return;
        }
        response = await profileRepository.findClientProfileWithEmail(email);
        if (response != null && response.exception != null) {
          if (response.exception.toString().contains(new RegExp(r'NoSuchMethodError')) == true)
            yield ProfileDoesNotExists();
          else
            yield ProfileNotLoaded(response.exception.toString());
          return;
        } else if (response != null && response.profile == null) {
          yield ProfileDoesNotExists();
          return;
        } else if (response != null && response.profile != null) {
          AuthLocalModel authLocalModel = await authLocalDataSource.getAuth();
          authLocalModel.userId = response.profile.id;
          userId = response.profile.id;
          await authLocalDataSource.saveAuth(authLocalModel);
        }
      }
      if (userId == -1) {
        yield ProfileNotLoaded('Unknown error accessing client profile.');
        return;
      }
      response = await profileRepository.getClientProfile(userId);
      if (response != null && response.exception != null) {
       yield ProfileNotLoaded(response.exception.toString());
      } else if (response != null && response.profile == null) {
        yield  ProfileDoesNotExists();
      } else if (response != null && response.profile != null) {
        AuthLocalModel authLocalModel = await authLocalDataSource.getAuth();
        response.profile.photo = authLocalModel.userPhoto;
        response.profile.fullName = authLocalModel.userFullName;
        yield ClientProfileLoaded(response.profile);
      }
    } catch (e) {
      print(e.toString());
      if (e.toString().contains(new RegExp(r'NoSuchMethodError')) == true)
        yield ProfileDoesNotExists();
      else
        yield ProfileNotLoaded(e.toString());
    }
  }

  Stream<ProfileState> _mapTraderProfileGetToState() async* {
    try {
      TraderResponse response;
      int userId = await authLocalDataSource.getUserId();
      if (userId == -1) {
        final String email = await authLocalDataSource.getEmail();
        if (email == null) {
          yield ProfileNotLoaded('Email address not available!');
          return;
        }
        response = await profileRepository.findTraderProfileWithEmail(email);
        if (response != null && response.exception != null) {
          if (response.exception.toString().contains(new RegExp(r'NoSuchMethodError')) == true)
            yield ProfileDoesNotExists();
          else
            yield ProfileNotLoaded(response.exception.toString());
          return;
        } else if (response != null && response.profile == null) {
          yield ProfileDoesNotExists();
          return;
        } else if (response != null && response.profile != null) {
          AuthLocalModel authLocalModel = await authLocalDataSource.getAuth();
          authLocalModel.userId = response.profile.id;
          userId = response.profile.id;
          await authLocalDataSource.saveAuth(authLocalModel);
        }
      }
      if (userId == -1) {
        yield ProfileNotLoaded('Unknown error accessing trader profile.');
        return;
      }
      response = await profileRepository.getTraderProfile(userId);
      if (response != null && response.exception != null) {
        yield ProfileNotLoaded(response.exception.toString());
      } else if (response != null && response.profile == null) {
        yield  ProfileDoesNotExists();
      } else if (response != null && response.profile != null) {
        AuthLocalModel authLocalModel = await authLocalDataSource.getAuth();
        response.profile.photo = authLocalModel.userPhoto;
        response.profile.fullName = authLocalModel.userFullName;

        response.profile.packages = [];
        response.profile.qualifications = [];
        response.profile.qualifications = await getTraderQualifications(response.profile.id);

        yield TraderProfileLoaded(response.profile);
      }
    } catch (e) {
      print(e.toString());
      if (e.toString().contains(new RegExp(r'NoSuchMethodError')) == true)
        yield ProfileDoesNotExists();
      else
        yield ProfileNotLoaded(e.toString());
    }
  }

  Stream<ProfileState> _mapClientProfileCreateToState() async* {
    try {
      AuthLocalModel authLocalModel = await authLocalDataSource.getAuth();
      //ClientModel model = ClientModel.fromClientProfileAndAuth(profile, authLocalModel);
      //.model.id = null;
      ClientProfile profile = ClientProfile(
        fullName: authLocalModel.userFullName,
        photo: authLocalModel.userPhoto,
        email: authLocalModel.userEmail,
        token: authLocalModel.token,
        tokenExpirationDate : DateFormat("yyyy-MM-dd'T'HH:mm:ss.ms'Z'").format(authLocalModel.tokenExpirationDate),
      );
      //profile.token = authLocalModel.token;
      //profile.tokenExpirationDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.ms'Z'").format(authLocalModel.tokenExpirationDate);
      final response = await profileRepository.createClientProfile(profile);
      if (response == null) {
        yield ProfileCreateFailed('');
      } else if (response.exception != null) {
        yield ProfileCreateFailed(response.exception.toString());
      } else if (response.profile != null) {
        authLocalModel.userId = response.profile.id;
        await authLocalDataSource.saveAuth(authLocalModel);

        response.profile.fullName = authLocalModel.userFullName;
        response.profile.photo = authLocalModel.userPhoto;
        //profile = response.profile;
        yield ProfileCreated(response.profile);
      }
    } catch (e) {
      yield ProfileCreateFailed(e.toString());
    }
  }

  Stream<ProfileState> _mapTraderProfileCreateToState() async* {
    try {
      AuthLocalModel authLocalModel = await authLocalDataSource.getAuth();
      //TraderModel model = TraderModel.fromTraderProfileAndAuth(profile, authLocalModel);
      //profile.token = authLocalModel.token;
      //profile.tokenExpirationDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.ms'Z'").format(authLocalModel.tokenExpirationDate);
      TraderProfile profile = TraderProfile(
        fullName: authLocalModel.userFullName,
        photo: authLocalModel.userPhoto,
        email: authLocalModel.userEmail,
        token: authLocalModel.token,
        tokenExpirationDate : DateFormat("yyyy-MM-dd'T'HH:mm:ss.ms'Z'").format(authLocalModel.tokenExpirationDate),
      );
      final response = await profileRepository.createTraderProfile(profile);
      if (response == null) {
        yield ProfileCreateFailed('');
      } else if (response.exception != null) {
        yield ProfileCreateFailed(response.exception.toString());
      } else if (response.profile != null) {
        authLocalModel.userId = response.profile.id;
        await authLocalDataSource.saveAuth(authLocalModel);

        response.profile.fullName = authLocalModel.userFullName;
        response.profile.photo = authLocalModel.userPhoto;
        //profile = response.profile;
        yield ProfileCreated(response.profile);
      }
    } catch (e) {
      yield ProfileCreateFailed(e.toString());
    }
  }

  Stream<ProfileState> _mapClientProfileUpdateToState(ClientProfile profile) async* {
    try {
      ClientResponse response = await profileRepository.updateClientProfile(profile);
      if (response == null) {
        yield ClientProfileUpdateFailed('');
      } else if (response.exception != null) {
        yield ClientProfileUpdateFailed(response.exception.toString());
      } else if (response.profile != null) {
        yield ClientProfileUpdated(response.profile);
      }
    } catch (e) {
      yield ClientProfileUpdateFailed(e.toString());
    }
  }

  Stream<ProfileState> _mapTraderProfileUpdateToState(TraderProfile profile) async* {
    try {
      TraderResponse response = await profileRepository.updateTraderProfile(profile);
      if (response == null) {
        yield TraderProfileUpdateFailed('');
      } else if (response.exception != null) {
        yield TraderProfileUpdateFailed(response.exception.toString());
      } else if (response.profile != null) {
        response.profile.packages = [];
        response.profile.qualifications = [];
        response.profile.qualifications = await getTraderQualifications(response.profile.id);
        yield TraderProfileUpdated(response.profile);
      }
    } catch (e) {
      yield TraderProfileUpdateFailed(e.toString());
    }
  }

  Stream<ProfileState> _mapTraderProfileUGetTapRatedToState() async* {
    try {
      TraderListResponse response = await profileRepository.getTopRatedTrader();
      if (response == null) {
        yield ProfileTraderTopRatedFailed('');
      } else if (response.exception != null) {
        yield ProfileTraderTopRatedFailed(response.exception.toString());
      } else if (response.profiles != null) {
        var iterator = response.profiles.iterator;
        while(iterator.moveNext()) {
          TraderProfile profile = iterator.current;
          profile.qualifications = await getTraderQualifications(profile.id);
        }
        yield ProfileTraderTopRatedCompleted(response.profiles);
      }
    } catch (e) {
      yield ProfileTraderTopRatedFailed(e.toString());
    }
  }


}
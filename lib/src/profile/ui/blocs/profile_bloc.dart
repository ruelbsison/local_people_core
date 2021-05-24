import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../domain/entities/client_profile.dart';
import '../../domain/entities/trader_profile.dart';
import 'package:meta/meta.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../../core/enum/app_type.dart';
import 'package:intl/intl.dart';
import 'profile_event.dart';
import 'profile_state.dart';
import 'package:local_people_core/auth.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;
  final AppType appType;
  final AuthLocalDataSource authLocalDataSource;

  ProfileBloc({@required this.profileRepository, @required this.appType, @required this.authLocalDataSource,}) :
        super(ProfileInitialState());

  @override
  ProfileState get initialState => ProfileInitialState();

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is ProfileGetEvent) {
      //yield ProfileLoading();
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
    }
  }

  Stream<ProfileState> _mapClientProfileGetToState() async* {
    try {
      final email = await authLocalDataSource.getEmail();
      final response = await profileRepository.findClientProfileWithEmail(email);
      if (response != null && response.exception != null) {
        if (response.exception.toString().contains('NoSuchMethodError') == true) {
          //AuthLocalModel authLocalModel = await authLocalDataSource.getAuth();
          // ClientProfile profile = ClientProfile(
          //   fullName: authLocalModel.userFullName,
          //   photo: authLocalModel.userPhoto,
          //   email: authLocalModel.userEmail,
          // );
          yield  ProfileDoesNotExists();
        } else {
          yield ProfileNotLoaded(response.exception.toString());
        }
      } else if (response != null && response.profile == null) {
        // AuthLocalModel authLocalModel = await authLocalDataSource.getAuth();
        // ClientProfile profile = ClientProfile(
        //   fullName: authLocalModel.userFullName,
        //   photo: authLocalModel.userPhoto,
        //   email: authLocalModel.userEmail,
        // );
        yield  ProfileDoesNotExists();
      } else if (response != null && response.profile != null) {
        AuthLocalModel authLocalModel = await authLocalDataSource.getAuth();
        authLocalModel.userId = response.profile.id;
        await authLocalDataSource.saveAuth(authLocalModel);

        response.profile.photo = authLocalModel.userPhoto;
        yield ClientProfileLoaded(response.profile);
      }
    } catch (e) {
      yield ProfileNotLoaded(e.toString());
    }
  }

  Stream<ProfileState> _mapTraderProfileGetToState() async* {
    try {
      final email = await authLocalDataSource.getEmail();
      final response = await profileRepository.findTraderProfileWithEmail(email);
      if (response != null && response.exception != null) {
        yield ProfileNotLoaded(response.exception.toString());
      } else if (response != null && response.profile == null) {
        // AuthLocalModel authLocalModel = await authLocalDataSource.getAuth();
        // TraderProfile profile = TraderProfile(
        //   fullName: authLocalModel.userFullName,
        //   photo: authLocalModel.userPhoto,
        //   email: authLocalModel.userEmail,
        // );
        yield  ProfileDoesNotExists();
      } else if (response != null && response.profile != null) {
        AuthLocalModel authLocalModel = await authLocalDataSource.getAuth();
        authLocalModel.userId = response.profile.id;
        await authLocalDataSource.saveAuth(authLocalModel);

        response.profile.photo = authLocalModel.userPhoto;
        yield TraderProfileLoaded(response.profile);
      }
    } catch (e) {
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

        response.profile.photo = authLocalModel.userPhoto;
        //profile = response.profile;
        yield ProfileCreated(response.profile);
      }
    } catch (e) {
      yield ProfileCreateFailed(e.toString());
    }
  }

}
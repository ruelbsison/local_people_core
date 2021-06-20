import 'package:flutter/material.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/auth.dart';
import 'package:local_people_core/profile.dart';
import '../../domain/entities/profile_item.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../domain/entities/more_item.dart';
import '../../ui/widgets/profile_card.dart';
import '../../ui/widgets/more_item_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/profile_bloc.dart';
import '../blocs/profile_event.dart';
import '../blocs/profile_state.dart';
import 'profile_screen.dart';

class MoreScreen extends StatefulWidget {
  dynamic profile;
  ProfileItem profileItem;

  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBarWidget buildAppBar() {
    return AppBarWidget(
      //appBarPreferredSize: Size.fromHeight(80.0),
      title: Text(
        AppLocalizations.of(context).appTitle,
      ),
      subTitle: LocalPeopleLocalizations.of(context).menuTitleMore,
      appBar: AppBar(),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Color.fromRGBO(186, 207, 216, 1),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() { //}BuildContext context) {
    final appType = AppConfig.of(context).appType;
    try {
      if (appType == AppType.CLIENT) {
        ClientProfile clientProfile = sl<ClientProfile>();
        if (clientProfile  != null) {
          widget.profile = clientProfile;
          widget.profileItem = ProfileItem(
            name: clientProfile.fullName,
            image: clientProfile.photo,
            totalJobs: clientProfile.numOfJobsPosted,
            totalAmountPaid: clientProfile.amountSpent,
          );
          return _buildBodyContent();
        }
      } else {
        TraderProfile traderProfile = sl<TraderProfile>();
        if (traderProfile != null) {
          widget.profile = traderProfile;
          widget.profileItem = ProfileItem(
            name: traderProfile.fullName,
            image: traderProfile.photo,
            totalJobs: 0,
            totalAmountPaid: 0.0,
          );
          return _buildBodyContent();
        }
      }
    } catch (e) {
      print(e.toString());
    }
    //BlocProvider.of<ProfileBloc>(context).add(ProfileGetEvent());
    return BlocProvider(
      create: (context) => ProfileBloc(
        profileRepository: RepositoryProvider.of<ProfileRepository>(context),
        appType: appType,
        authLocalDataSource: sl<AuthLocalDataSource>(),
      )..add(ProfileGetEvent()),
      child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ClientProfileLoaded) {
              locatorAddClientProfile(state.profile);
              widget.profile = state.profile;
              widget.profileItem = ProfileItem(
                name: state.profile.fullName,
                image: state.profile.photo,
                totalJobs: state.profile.numOfJobsPosted,
                totalAmountPaid: state.profile.amountSpent,
              );
              return _buildBodyContent();
            } if (state is TraderProfileLoaded) {
              locatorAddTraderProfile(state.profile);
              widget.profile = state.profile;
              widget.profileItem = ProfileItem(
                name: state.profile.fullName,
                image: state.profile.photo,
                totalJobs: 0,
                totalAmountPaid: 0.0,
              );
              return _buildBodyContent();
            } else {
              return LoadingWidget();
            }
          }
      ),
    );

  }

  Widget _buildBodyContent() {
    return SafeArea(
        child: Flex (
          direction: Axis.vertical,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded (
              flex: 2,
              child: ProfileCard(
                profileItem: widget.profileItem,
                press: () {
                  AppRouter.pushPage(
                      context,
                      DialogManager(child: ProfileScreen(
                        profile: widget.profile,
                      ),),
                  );
                },
              ),
            ),
            Expanded (
              flex: 5,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                primary: true,
                itemCount: moreItemData.length,
                itemBuilder: (context, index) =>
                (MoreItemCard(item: moreItemData[index], press: () {})),
              ),
            ),
          ],
        )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:local_people_core/core.dart';
import '../../domain/entities/profile_item.dart';
import '../../domain/entities/more_item.dart';
import '../../ui/widgets/profile_card.dart';
import '../../ui/widgets/more_item_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/profile_bloc.dart';
import '../blocs/profile_event.dart';
import '../blocs/profile_state.dart';
import 'profile_screen.dart';

class MoreScreen extends StatefulWidget {
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
      appBarPreferredSize: Size.fromHeight(80.0),
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
    //final appType = AppConfig.of(context).appType;
    BlocProvider.of<ProfileBloc>(context).add(ProfileGetEvent());
    return SafeArea(
      child: Flex (
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded (
            flex: 1,
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ClientProfileLoaded) {
                  ProfileItem item = ProfileItem(
                    name: state.profile.fullName,
                    image: state.profile.photo,
                    totalJobs: state.profile.numOfJobsPosted,
                    totalAmountPaid: state.profile.amountSpent,
                  );
                  return ProfileCard(profileItem: item, press: () {AppRouter.pushPage(context, ProfileScreen(profile: state.profile,));},);
                } if (state is TraderProfileLoaded) {
                  ProfileItem item = ProfileItem(
                    name: state.profile.fullName,
                    image: state.profile.photo,
                    totalJobs: 0,
                    totalAmountPaid: 0.0,
                  );
                  return ProfileCard(profileItem: item, press: () {AppRouter.pushPage(context, ProfileScreen(profile: state.profile,));},);
                } else {
                  return LoadingWidget();
                }
              }
            ),
          ),
        Expanded (
          flex: 4,
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
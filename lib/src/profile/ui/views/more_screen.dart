import 'package:flutter/material.dart';
import 'package:local_people_core/core.dart';
import '../../domain/entities/profile_item.dart';
import '../../domain/entities/more_item.dart';
import '../../ui/widgets/profile_card.dart';
import '../../ui/widgets/more_item_card.dart';
class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
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
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final appType = AppConfig.of(context).appType;
    return SafeArea(
      child: Flex (
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded (
            flex: 1,
            child: ProfileCard(profileItem: (appType == AppType.CLIENT
                ? clieantProfileItem : traderProfileItem), press: () {},),
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
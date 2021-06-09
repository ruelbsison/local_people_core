import 'package:flutter/material.dart';
import '../../domain/entities/trader_profile.dart';
import '../../domain/entities/client_profile.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:local_people_core/core.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package_widget.dart';
import 'package:local_people_core/jobs.dart';
import 'package_card.dart';
import 'qualification_card.dart';
import 'qualification_widget.dart';
import 'trader_contact_actions.dart';
import '../../domain/entities/qualification.dart';
import 'package:local_people_core/jobs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileTraderBody extends StatefulWidget {
  ProfileTraderBody({
    @required this.profile,
    @required this.clientProfile,
  });

  @override
  _ProfileTraderBodyState createState() => _ProfileTraderBodyState();

  final TraderProfile profile;
  final ClientProfile clientProfile;
  List<Tag> tags;
  List<String> qualifications = [];

}

class _ProfileTraderBodyState extends State<ProfileTraderBody> {
  @override
  Widget build(BuildContext context) {
    //return buildContent(context);
    // try {
    //   List<Tag> tags = sl<List<Tag>>();
    //   if (tags == null || tags.length == 0) {
    //     context.read<TagBloc>().add(LoadTagsEvent());
    //   }
    //   else {
    //     widget.tags = tags;
    //     widget.qualifications.addAll(List.generate(widget.tags.length, (index) => widget.tags[index].name));
    //     return buildContent(context);
    //   }
    // } catch(e) {
    //   context.read<TagBloc>().add(LoadTagsEvent());
    //   print(e.toString());
    // }
    context.read<TagBloc>().add(LoadTagsEvent());
    return BlocProvider.value(
      value: BlocProvider.of<TagBloc>(context),
      child: BlocConsumer<TagBloc, TagState>(
          listenWhen: (previous, current) {
            // return true/false to determine whether or not
            // to invoke listener with state
            // List<Tag> tags = sl<List<Tag>>();
            return false;
          },
          listener: (context, state) {
            // do stuff here based on BlocA's state
          },
          buildWhen: (previous, current) {
            // return true/false to determine whether or not
            // to rebuild the widget with state
            if (widget.tags != null)
              return false;

            try {
              List<Tag> tags = sl<List<Tag>>();
              if (tags != null && tags.length > 0)
                return false;
            } catch(e) {
            }
            if (previous is TagsLoading &&
                current is TagsLoaded) {
              return true;
            }
            return false;
          },
          builder: (context, state) {
            // return widget here based on BlocA's state
            if (state is TagsLoaded) {
              if (state.tags != null && state.tags.length > 0) {
                //locatorAddListTag(state.tags);
                List<Tag> tags = sl<List<Tag>>();
                tags.clear();
                tags.addAll(state.tags);

                widget.tags = state.tags;
              } else {
                widget.tags = Tag.defaultTags;
              }
              widget.qualifications.addAll(List.generate(widget.tags.length, (index) => widget.tags[index].name));
              return buildContent(context);
            } else if (state is LoadTagsFailed) {
              return ErrorWidget('Error $state');
            }
            return LoadingWidget();
          }
      ),
    );
  }

  Widget buildContent(BuildContext context) {
    final theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    //List<Widget> columnChildren = <Widget>[];
    widget.tags = Tag.defaultTags;
    widget.qualifications.addAll(List.generate(widget.tags.length, (index) => widget.tags[index].name));
    final introductionActions = Container(
      color: theme.backgroundColor,
      padding: EdgeInsets.all(12.0),
      //margin: EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Text(
              'Introduction',
              textAlign: TextAlign.left,
              style: theme.textTheme.bodyText1,
            ),
          ),
          Expanded(
            flex: 1,
            child: Icon(
              MaterialIcons.edit,
            ),
          ),
          Expanded(
            flex: 1,
            child: Icon(
              MaterialIcons.clear_all,
            ),
          ),
        ],
      ),
    );

    final introduction = Container(
      color: theme.backgroundColor,
      padding: EdgeInsets.all(12.0),
      //margin: EdgeInsets.all(12.0),
      child: Text(
        widget.profile.intro != null ? widget.profile.intro : '',
        maxLines: 12,
        overflow: TextOverflow.ellipsis,
        //textDirection: TextDirection.RTL,
        textAlign: TextAlign.left,
        style: theme.textTheme.bodyText2,
      ),
    );

    AppType appType = AppConfig.of(context).appType;
    TraderContactActions traderContactOptiosn;
    if (appType == AppType.CLIENT) {
      traderContactOptiosn = TraderContactActions(
        profile: widget.profile,
        otherProfile: widget.clientProfile,
      );
      //columnChildren.add(traderContactOptiosn);
    }
    // columnChildren.add(introductionActions);
    // columnChildren.add(introduction);
    // columnChildren.add(SizedBox(height: 20));

    // Qualifications
    if (appType == AppType.TRADER) {
      widget.profile.qualifications.forEach((qualification) {
        qualification.optionType = QualificationOptionType.REMOVE;
      });
      widget.qualifications.forEach((element) {
        Qualification qualification = Qualification(
            id: -1,
            title: element,
            optionType: QualificationOptionType.ADD_DEFAULT
        );
        if (widget.profile.qualifications.contains(qualification) == false) {
          widget.profile.qualifications.add(qualification);
        }
      });
      int length = widget.profile.qualifications.length + 1;
      Qualification qualification = Qualification(
        id: -1,
        title: 'Qualification ' + length.toString(),
        optionType: QualificationOptionType.ADD_NEW,
      );
      widget.profile.qualifications.add(qualification);
    }
    // if (widget.profile.qualifications != null &&
    //     widget.profile.qualifications.length > 0) {
      final qualificationWidget = QualificationWidget (
        qualifications: widget.profile.qualifications,
        sugesstions: widget.qualifications,
      );
    //   columnChildren.add(qualificationWidget);
    //   columnChildren.add(SizedBox(height: 20));
    // }

    // Packages
    if (appType == AppType.TRADER) {
      widget.profile.packages.forEach((package) {
        package.optionType = PackageOptionType.REMOVE;
      });
      int length = widget.profile.packages.length + 1;
      Package package = Package(
        id: -1,
        name: 'Package ' + length.toString(),
        optionType: PackageOptionType.ADD_NEW,
      );
      widget.profile.packages.add(package);
    }
    //if (widget.profile.packages != null &&
    //    widget.profile.packages.length > 0) {
      final packageWidget = PackageWidget (
        packages: widget.profile.packages,
      );
     // columnChildren.add(packageWidget);
     // columnChildren.add(SizedBox(height: 20));
   // }

    return SliverList(
      delegate: new SliverChildListDelegate(
        [
          introduction,
        SizedBox(height: 10),
        introductionActions,
        SizedBox(height: 20),
        // qualificationWidget,
        // SizedBox(height: 20),
        // packageWidget,
        // SizedBox(height: 20),
          traderContactOptiosn,
          SizedBox(height: 20),
        ]
      ),
    );
  }
}

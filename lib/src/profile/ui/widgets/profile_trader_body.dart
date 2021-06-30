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
import 'package:local_people_core/auth.dart';
import 'package_card.dart';
import 'qualification_card.dart';
import 'qualification_widget.dart';
import 'trader_contact_actions.dart';
import '../../domain/entities/qualification.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../blocs/profile_bloc.dart';
import '../blocs/profile_event.dart';
import '../blocs/profile_state.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../domain/repositories/qualification_repository.dart';

class ProfileTraderBody extends StatefulWidget {
  ProfileTraderBody({
    @required this.profile,
    @required this.clientProfile,
  });

  @override
  _ProfileTraderBodyState createState() => _ProfileTraderBodyState();

  TraderProfile profile;
  final ClientProfile clientProfile;
  List<Tag> tags = [];
  List<String> qualifications = [];

}

class _ProfileTraderBodyState extends State<ProfileTraderBody> {
  //ProfileBloc profileBloc;
  DialogService _dialogService = sl<DialogService>();

  @override
  Widget build(BuildContext context) {
    //return buildContent(context);
    try {
      List<Tag> tags = sl<List<Tag>>();
      if (tags == null || tags.length == 0) {
        context.read<TagBloc>().add(LoadTagsEvent());
      }
      else {
        widget.tags = tags;
        widget.qualifications.addAll(List.generate(widget.tags.length, (index) => widget.tags[index].name));
        return buildContent(context);
      }
    } catch(e) {
      context.read<TagBloc>().add(LoadTagsEvent());
      print(e.toString());
    }
    //context.read<TagBloc>().add(LoadTagsEvent());

    final appType = AppConfig.of(context).appType;
    // profileBloc = ProfileBloc(
    //   profileRepository: RepositoryProvider.of<ProfileRepository>(context),
    //   appType: appType,
    //   authLocalDataSource: sl<AuthLocalDataSource>(),
    //   qualificationRepository: RepositoryProvider.of<QualificationRepository>(context),
    //   packageRepository: RepositoryProvider.of<PackageRepository>(context),
    // );

    return BlocProvider.value(
        value: BlocProvider.of<ProfileBloc>(context),
        child: BlocListener<ProfileBloc, ProfileState>(
      listener:  (context, state) {
        if (state is TraderProfileLoaded) {
          sl.unregister<TraderProfile>();
          locatorAddTraderProfile(state.profile);
          setState(() {
            widget.profile = state.profile;
          });
        }
      }, child: BlocProvider.value(
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
                if (widget.tags != null && widget.tags.length > 0)
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
                if (previous is TagsLoading &&
                    current is LoadTagsFailed) {
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
                  return SliverToBoxAdapter(
                    child: ErrorWidget('Error $state'),
                  );
                }
                return SliverToBoxAdapter(
                  child: LoadingWidget(),
                );
              }
          ),
        ),
          //),
          //),
    //     ),
    // ),
          ),
        );
  }

  Widget buildContent(BuildContext context) {
    final theme = Theme.of(context);
    //Size size = MediaQuery.of(context).size;
    List<Widget> columnChildren = <Widget>[];
    //widget.tags = Tag.defaultTags;
    //widget.qualifications.addAll(List.generate(widget.tags.length, (index) => widget.tags[index].name));
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
    if (widget.profile.qualifications == null)
      widget.profile.qualifications = [];
    //if (widget.profile.qualifications != null && widget.profile.qualifications.length > 0)
    //  widget.profile.qualifications.clear();
    List<Qualification> qualifications = [];
    if (appType == AppType.TRADER) {
      if (widget.profile.qualifications != null) {
        widget.profile.qualifications.forEach((qualification) {
          if (qualification.id > 0) {
            qualification.optionType = QualificationOptionType.REMOVE;
            qualification.traderId = widget.profile.id;
            qualifications.add(qualification);
          }
        });
      }
      if (widget.qualifications != null) {
        widget.qualifications.forEach((element) {
          Qualification qualification = Qualification(
            id: -1,
            title: element,
            optionType: QualificationOptionType.ADD_DEFAULT,
            traderId: widget.profile.id,
          );
          Qualification exists;
          if (widget.profile.qualifications != null && widget.profile.qualifications.length > 0) {
            Qualification findqualification(String title) => widget.profile.qualifications.firstWhere((qualification) => qualification.title.compareTo(title) == 0);
            try {
              exists = findqualification(qualification.title);
            } catch(e) {
              exists = null;
            }
          }
          if (exists == null)
            qualifications.add(qualification);
        });
      }

      if (qualifications.length < widget.profile.qualifications.length) {
        int length = widget.profile.qualifications.length + 1;
        Qualification qualification = Qualification(
          id: -1,
          title: 'Qualification ' + length.toString(),
          optionType: QualificationOptionType.ADD_NEW,
          traderId: widget.profile.id,
        );
        qualifications.add(qualification);
      }

    }
    // if (widget.profile.qualifications != null &&
    //     widget.profile.qualifications.length > 0) {
      final qualificationWidget = QualificationWidget (
        qualifications: qualifications,
        sugesstions: widget.qualifications,
        onQualificationAdded: (qualification, index){
          if (widget.profile.qualifications == null) {
            widget.profile.qualifications = [];
          }
          if (index >= 0)
            widget.profile.qualifications.insert(index, qualification);
          else
            widget.profile.qualifications.add(qualification);

          Qualification exists;
          if (widget.profile.qualifications != null && widget.profile.qualifications.length > 0) {
            Qualification findqualification(String title) =>
                widget.profile.qualifications
                  .firstWhere((qualification) => qualification.title.compareTo(title) == 0);
            try {
              exists = findqualification(qualification.title);
            } catch(e) {
              exists = null;
            }
          }
          if (exists != null) {
            //setState(() {
              exists.optionType = QualificationOptionType.REMOVE;
            //});
          }

          sl.unregister<TraderProfile>();
          locatorAddTraderProfile(widget.profile);
        },
        onQualificationRemoved: (qualification, id){
          if (widget.profile.qualifications != null
              && widget.profile.qualifications.length > 0) {

              Qualification findqualification(int id) => widget.profile.qualifications.firstWhere((qualification) => qualification.id == id);
              Qualification qualification = findqualification(id);

              if (qualification != null) {
                qualification.optionType = QualificationOptionType.ADD_DEFAULT;
              }
              //int index = widget.profile.qualifications.indexOf(qualification);
              //if (index >= 0) {
                //widget.profile.qualifications.removeAt(index);
                sl.unregister<TraderProfile>();
                locatorAddTraderProfile(widget.profile);
            //}
          }
        }
      );
    //   columnChildren.add(qualificationWidget);
    //   columnChildren.add(SizedBox(height: 20));
    // }

    // Packages
    //if (widget.profile.packages != null && widget.profile.packages.length > 0)
      //widget.profile.packages.clear();
    if (widget.profile.packages == null)
      widget.profile.packages = [];

    List<Package> packages = [];
    if (appType == AppType.TRADER) {
      //List<Package> packages = widget.profile.packages;
      widget.profile.packages.forEach((package) {
        if (package.id > 0) {
          if (package.optionType == PackageOptionType.VIEW_ONLY) {
            package.optionType = PackageOptionType.REMOVE;
          }
          packages.add(package);
        }
      });
      int length = packages.length + 1;
      Package package = Package(
        id: -1,
        name: 'Package ' + length.toString(),
        optionType: PackageOptionType.ADD_NEW,
        traderId: widget.profile.id,
      );
      packages.add(package);
    } else {
      widget.profile.packages.forEach((package) {
        if (package.id > 0) {
          packages.add(package);
        }
      });
    }
    //if (widget.profile.packages != null &&
    //    widget.profile.packages.length > 0) {
      final packageWidget = PackageWidget (
        packages: packages,
        traderName: widget.profile.fullName,
        onPackageAdded: (package, index) {
          if (widget.profile.packages == null) {
            widget.profile.packages = [];
          }
          if (index >= 0)
            widget.profile.packages.insert(index, package);
          else
            widget.profile.packages.add(package);

          sl.unregister<TraderProfile>();
          locatorAddTraderProfile(widget.profile);
        },
        onPackageRemoved: (package, index) {
          if (widget.profile.packages != null
              && widget.profile.packages.length > 0) {
            if (index >= 0) {
              widget.profile.packages.removeAt(index);

              sl.unregister<TraderProfile>();
              locatorAddTraderProfile(widget.profile);
            }
          }
        },
      );
     // columnChildren.add(packageWidget);
     // columnChildren.add(SizedBox(height: 20));
   // }
   //  columnChildren.add(SliverToBoxAdapter(
   //    child: introductionActions,
   //  ));
   //  columnChildren.add(SliverToBoxAdapter(
   //    child: introduction,
   //  ));
   //  columnChildren.add(SliverToBoxAdapter(
   //    child: SizedBox(height: 10),
   //  ));
   //  columnChildren.add(SliverToBoxAdapter(
   //    child: qualificationWidget,
   //  ));
   //  columnChildren.add(SliverToBoxAdapter(
   //    child: SizedBox(height: 10),
   //  ));
   //  columnChildren.add(SliverToBoxAdapter(
   //    child: packageWidget,
   //  ));
   //  if (appType == AppType.CLIENT) {
   //    columnChildren.add(SliverToBoxAdapter(
   //      child: SizedBox(height: 10),
   //    ));
   //    columnChildren.add(SliverToBoxAdapter(
   //      child: traderContactOptiosn,
   //    ));
   //  }
   //  columnChildren.add(SliverToBoxAdapter(
   //    child: SizedBox(height: 20),
   //  ));

    if (appType == AppType.CLIENT) {
      columnChildren.add(SizedBox(height: 30));
      columnChildren.add(traderContactOptiosn);
    }
    columnChildren.add(introductionActions);
    columnChildren.add(introduction);
    columnChildren.add(SizedBox(height: 30));
    columnChildren.add(qualificationWidget);
    columnChildren.add(SizedBox(height: 30));
    columnChildren.add(packageWidget);
    columnChildren.add(SizedBox(height: 30));

    return SliverList(
      delegate: new SliverChildListDelegate(
          columnChildren,
      ),
    );
  }
}

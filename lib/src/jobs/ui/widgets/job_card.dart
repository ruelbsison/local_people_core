import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_people_core/core.dart';
import 'locations_view_widget.dart';
import 'tags_view_widget.dart';
import '../views/job_detail_screen.dart';
import '../views/job_bid_screen.dart';
import '../../domain/entities/tag.dart';
import '../../domain/entities/job.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/location_bloc.dart';
import 'package:local_people_core/quote.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:local_people_core/profile.dart';
import '../../domain/entities/change_request.dart';

typedef OnJobPressed<Job> = void Function(Job job);
typedef OnJobLocationUpdateCallback<Location> = void Function(int jobId, Location location);
typedef OnJobBidsUpdateCallback<Location> = void Function(int jobId, List<Quote> bids);

class JobCard extends StatefulWidget {
  JobCard({
    Key key,
    @required this.job,
    this.onJobPressed,
    this.onJobLocationUpdateCallback,
    this.onJobBidsUpdateCallback,
  }) : super(key: key);

  Job job;
  OnJobPressed<Job> onJobPressed;
  OnJobLocationUpdateCallback onJobLocationUpdateCallback;
  OnJobBidsUpdateCallback onJobBidsUpdateCallback;

  @override
  _JobCardState createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  List<Tag> tags = [];
  List<Tag> statusTags = [];
  //List<Quote> bids = [];
  //QuoteBloc _quoteBloc;
  int traderId = 0;

  Map<String, Color> colorMap = {
    'Awarded' : Color.fromRGBO(142, 209, 90, 1.0),
    'Confirmed' : Color.fromRGBO(142, 209, 90, 1.0),
    'Job Posted' : Color.fromRGBO(170, 186, 205, 1.0),
    'Awaiting Response' : Color.fromRGBO(170, 186, 205, 1.0),
  };

  @override
  void initState() {
    super.initState();

    print('JobCaed.initState');

    try {
      TraderProfile traderProfile = sl<TraderProfile>();
      if (traderProfile != null)
        traderId = traderProfile.id;
    } catch (e) {
      print(e.toString());
    }

    initJobStatus();
    //_quoteBloc = BlocProvider.of<QuoteBloc>(context);
  }

  @override
  void didChangeDependencies() {
    print('JobCaed.didChangeDependencies');
    //initJobStatus();
  }

  ChangeRequest findTraderChangeRequest(int traderId) => widget.job.changeRequests.firstWhere((changeRequest) => changeRequest.traderId == traderId);
  void initJobStatus() {
    //final appType = AppConfig.of(context).appType;
    tags.clear();
    statusTags.clear();
    if (widget.job != null) {
      //if (appType == AppType.TRADER) {
        if (widget.job.tags != null) {
          tags.addAll(widget.job.tags);
          tags.forEach((element) {
            colorMap.addAll(<String, Color>{
              element.name: Color.fromRGBO(170, 186, 205, 1.0)
            });
          });
        }
        if (widget.job.changeRequests != null
            && widget.job.changeRequests.length > 0
            && traderId > 0) {
          ChangeRequest changeRequest = findTraderChangeRequest(traderId);
          if (changeRequest != null
              && changeRequest.status != null
              && changeRequest.status.compareTo('Change Required') == 0) {
            tags.add(Tag(id: tags.length, name: changeRequest.status));
          }
        }
      //} else {
      //   if (widget.job.awarded != null && widget.job.awarded == true) {
      //     tags.add(Tag(id: 0, name: 'Awarded'));
      //   } else
      //   if (widget.job.isConfirmed != null && widget.job.isConfirmed == true) {
      //     tags.add(Tag(id: 0, name: 'Confirmed'));
      //   } else if (widget.job.bids != null && widget.job.bids.length > 0) {
      //     tags.add(
      //         Tag(id: 0, name: widget.job.bids.length.toString() + ' Bids'));
      //   } else if (widget.job.isPosted == true) {
      //     tags.add(Tag(id: 0, name: 'Job Posted'));
      //   }
      //}
    }
  }

  // Widget buildJobStatus() {
  //   // if (widget.job.id != 3) {
  //   //   return TagsViewWidget(
  //   //     tags: [], //[Tag(id: 0, name: 'Not Available')],
  //   //   );
  //   // }
  //   //_quoteBloc = BlocProvider.of<QuoteBloc>(context, listen: true);
  //   BlocProvider.of<QuoteBloc>(context).add(QuoteJobLoadEvent(id: widget.job.id));
  //   final textTheme = Theme.of(context).textTheme;
  //   return BlocBuilder<QuoteBloc, QuoteState>(
  //     bloc: BlocProvider.of<QuoteBloc>(context),
  //         builder: (context, state) {
  //           final appType = AppConfig.of(context).appType;
  //           if (state is QuoteJobLoaded) {
  //             if (widget.onJobBidsUpdateCallback != null) {
  //               widget.onJobBidsUpdateCallback(widget.job.id, state.quotes);
  //             }
  //
  //             //setState(() {
  //             if (widget.job.bids == null)
  //               widget.job.bids = [];
  //             else
  //               widget.job.bids.clear();
  //             if (state.quotes != null && state.quotes.length > 0)
  //               print('state.quotes.length: ' + state.quotes.length.toString());
  //             widget.job.bids = state.quotes;
  //             initJobStatus();
  //             //});
  //
  //             // return TagsViewWidget(
  //             //   tags: statusTags,
  //             // );
  //             return Tags(
  //               //key: _tagStateKey,
  //               //symmetry: _symmetry,
  //                 columns: 2,
  //                 alignment: WrapAlignment.start,
  //                 //horizontalScroll: _horizontalScroll,
  //                 //verticalDirection: VerticalDirection.up, textDirection: TextDirection.rtl,
  //                 //heightHorizontalScroll: 60 * (_fontSize / 14),
  //                 runAlignment: WrapAlignment.start,
  //                 itemCount: tags.length,
  //                 itemBuilder: (index) {
  //                   final item = tags[index];
  //                   return ItemTags(
  //                     key: Key(index.toString()),
  //                     index: index,
  //                     title: item.name,
  //                     pressEnabled: false,
  //                     elevation: 0,
  //                     borderRadius: BorderRadius.circular(2.0),
  //                     // border: BoxBorder(
  //                     //     RoundedRectangleBorder(
  //                     //   borderRadius: BorderRadius.all(Radius.circular(2)),
  //                     // )),
  //                     activeColor: colorMap[item.name] == null
  //                         ? Color.fromRGBO(255, 99, 97, 1.0):
  //                     colorMap[item.name], //Colors.blueGrey[600],
  //                     //singleItem: _singleItem,
  //                     splashColor: Colors.green,
  //                     combine: ItemTagsCombine.onlyText,
  //                     textStyle: textTheme.overline.copyWith(
  //                         color: Colors.white,
  //                     ),
  //                     alignment: MainAxisAlignment.start,
  //                   );
  //                 }
  //             );
  //           } else if (state is QuoteJobLoadFailed) {
  //             return TagsViewWidget(
  //               tags: [], //[Tag(id: 0, name: 'Not Available')],
  //             );
  //           } else {
  //             //return const Center(child: CircularProgressIndicator());
  //             return LoadingWidget();
  //           }
  //         }
  //     );
  // }

  // Widget buildLocation() {
  //   BlocProvider.of<LocationBloc>(context)
  //       .add(GetLocationEvent(id: widget.job.id));
  //   return BlocBuilder<LocationBloc, LocationState>(
  //     bloc: BlocProvider.of<LocationBloc>(context),
  //     builder: (BuildContext context, LocationState state) {
  //       //final appCType = AppConfig.of(context).appType;
  //       if (state is GetLocationLoaded) {
  //         //setState(() {
  //           widget.job.location = state.location;
  //           widget.job.entityStatus = EntityStatus.ENTIRY_STATUS_COMPLETED;
  //         //});
  //         if (widget.onJobLocationUpdateCallback != null) {
  //           widget.onJobLocationUpdateCallback(widget.job.id, state.location);
  //         }
  //         return LocationsViewWidget(
  //           location: (widget.job.location != null && widget.job.location.name != null)
  //               ? widget.job.location.name : '',
  //           maxTagViewHeight: 50,
  //         );
  //       } else if (state is GetLocationFailed) {
  //         widget.job.entityStatus = EntityStatus.ENTIRY_STATUS_ERROR;
  //         return LocationsViewWidget(
  //           location: (widget.job.location != null && widget.job.location.name != null)
  //               ? widget.job.location.name : 'Not Available',
  //           maxTagViewHeight: 50,
  //         );
  //       } else {
  //         return LoadingWidget();
  //       }
  //     },
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    print('JobCaed.build');
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: (){
        if (widget.onJobPressed != null) {
          widget.onJobPressed(widget.job);
        } else {
          final appType = AppConfig.of(context).appType;
          if (appType == AppType.TRADER) {
            AppRouter.pushPage(
              context,
              DialogManager(
                child: JobDetailScreen(
                  job: widget.job,
                ),
              ),
            );
          } else {
            AppRouter.pushPage(
              context,
              DialogManager(
                child: JobBidScreen(
                  job: widget.job,
                ),
              ),
            );
          }
        }
      },
      child: Container(
        padding: EdgeInsets.only(top: 12.0, bottom: 12.0, right: 12.0), //EdgeInsets.all(12.0),
        margin: EdgeInsets.only(top: 12.0, bottom: 12.0),
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Flex(
          direction: Axis.horizontal,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Flex(
                direction: Axis.vertical,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    //padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    //color: Colors.blue,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ClipOval(
                        child: SvgPicture.asset(
                          ((widget.job.date != null
                              && (widget.job.date.difference(DateTime.now())).inDays > 0)
                              ? 'packages/local_people_core/assets/images/package-green.svg'
                              : 'packages/local_people_core/assets/images/package-orange.svg'),
                          fit: BoxFit.contain,
                          height: 38,
                          width: 38,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    //padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    //color: Colors.green,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        (widget.job.date != null
                            ? DateFormatUtil.getDateTimeDiff(
                            DateTime.now(), widget.job.date)
                            : ''),
                        textAlign: TextAlign.center,
                        style: textTheme.overline.copyWith(
                            fontSize: 9,
                          color: ((widget.job.date != null
                              && (widget.job.date.difference(DateTime.now())).inDays > 0)
                              ? Color.fromRGBO(142, 209, 90, 1.0)
                              : Colors.orange),
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget> [
                  Text(
                    widget.job.title != null
                        ? widget.job.title
                        : widget.job.description,
                    textAlign: TextAlign.left,
                    style: textTheme.subtitle1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 2,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    (widget.job.date != null
                        ? DateFormat('dd MMMM yyyy').format(widget.job.date)
                        : '') +
                        (widget.job.date != null
                            ? ' | ' +
                            DateFormatUtil.getDateTimeDiff(
                                DateTime.now(), widget.job.date)
                            : ''),
                    textAlign: TextAlign.left,
                    style: textTheme.subtitle2,
                  ),
                  SizedBox(height: 5.0),
                  //buildLocation(),
                  LocationsViewWidget(
                    location: (widget.job.location != null && widget.job.location.name != null)
                        ? widget.job.location.name : '',
                    maxTagViewHeight: 45,
                  ),
                  SizedBox(height: 5.0),
                  //buildJobStatus(),
                  Tags(
                    //key: _tagStateKey,
                    //symmetry: _symmetry,
                      columns: 2,
                      alignment: WrapAlignment.start,
                      //horizontalScroll: _horizontalScroll,
                      //verticalDirection: VerticalDirection.up, textDirection: TextDirection.rtl,
                      //heightHorizontalScroll: 60 * (_fontSize / 14),
                      runAlignment: WrapAlignment.start,
                      itemCount: tags.length,
                      itemBuilder: (index) {
                        final item = tags[index];
                        return ItemTags(
                          key: Key(index.toString()),
                          index: index,
                          title: item.name,
                          pressEnabled: false,
                          elevation: 0,
                          borderRadius: BorderRadius.circular(2.0),
                          // border: BoxBorder(
                          //     RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.all(Radius.circular(2)),
                          // )),
                          activeColor: colorMap[item.name] == null
                              ? Color.fromRGBO(255, 99, 97, 1.0):
                          colorMap[item.name], //Colors.blueGrey[600],
                          //singleItem: _singleItem,
                          splashColor: Colors.green,
                          combine: ItemTagsCombine.onlyText,
                          textStyle: textTheme.caption.copyWith(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          alignment: MainAxisAlignment.start,
                        );
                      }
                  ),
                  //SizedBox(height: 10.0),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '£' + widget.job.budget,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyText1,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget buildBody(BuildContext context) {
  //   final textTheme = Theme.of(context).textTheme;
  //   return InkWell(
  //     onTap: (){
  //       //if (widget.onPressedOpportunity != null)
  //       //  widget.onPressedOpportunity(widget.opportunityItem);
  //       //AppRouter.pushPage(context, JobDetailScreen(job: widget.job,));
  //       AppRouter.pushPage(
  //         context,
  //         DialogManager(
  //         child: JobDetailScreen(
  //           job: widget.job,
  //           quotes: bids,
  //         ),
  //       ),);
  //     },
  //   child: Container(
  //     padding: EdgeInsets.only(top: 12.0, bottom: 12.0, right: 12.0), //EdgeInsets.all(12.0),
  //     margin: EdgeInsets.only(top: 12.0, bottom: 12.0),
  //     decoration: BoxDecoration(
  //       color: Color.fromRGBO(255, 255, 255, 1.0),
  //       borderRadius: BorderRadius.circular(10.0),
  //     ),
  //     child: Flex(
  //       direction: Axis.horizontal,
  //       mainAxisSize: MainAxisSize.max,
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         Expanded(
  //           flex: 1,
  //           child: Flex(
  //             direction: Axis.vertical,
  //             mainAxisSize: MainAxisSize.max,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               Container(
  //                 //padding: EdgeInsets.only(left: 8.0, right: 8.0),
  //                 //color: Colors.blue,
  //                 child: Align(
  //                   alignment: Alignment.topCenter,
  //                   child: ClipOval(
  //                     child: SvgPicture.asset(
  //                       ((widget.job.date != null
  //                           && (widget.job.date.difference(DateTime.now())).inDays > 0)
  //                           ? 'packages/local_people_core/assets/images/package-green.svg'
  //                           : 'packages/local_people_core/assets/images/package-orange.svg'),
  //                       fit: BoxFit.contain,
  //                       height: 38,
  //                       width: 38,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               Container(
  //                 //padding: EdgeInsets.only(left: 8.0, right: 8.0),
  //                 //color: Colors.green,
  //                 child: Align(
  //                   alignment: Alignment.topCenter,
  //                   child: Text(
  //                     (widget.job.date != null
  //                         ? DateFormatUtil.getDateTimeDiff(
  //                         DateTime.now(), widget.job.date)
  //                         : ''),
  //                     textAlign: TextAlign.center,
  //                     style: textTheme.overline,
  //                     maxLines: 2,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Expanded(
  //           flex: 4,
  //           child: Column(
  //             mainAxisSize: MainAxisSize.max,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.stretch,
  //             children: <Widget> [
  //               Text(
  //                 widget.job.title != null
  //                     ? widget.job.title
  //                     : widget.job.description,
  //                 textAlign: TextAlign.left,
  //                 style: textTheme.subtitle1,
  //                 overflow: TextOverflow.ellipsis,
  //                 softWrap: true,
  //                 maxLines: 2,
  //               ),
  //               SizedBox(height: 10.0),
  //               Text(
  //                 (widget.job.date != null
  //                     ? DateFormat('dd MMMM yyyy').format(widget.job.date)
  //                     : '') +
  //                     (widget.job.date != null
  //                         ? ' | ' +
  //                         DateFormatUtil.getDateTimeDiff(
  //                             DateTime.now(), widget.job.date)
  //                         : ''),
  //                 textAlign: TextAlign.left,
  //                 style: textTheme.subtitle2,
  //               ),
  //               SizedBox(height: 5.0),
  //               buildLocation(),
  //
  //               // SizedBox(height: 5.0),
  //               // //buildTags(context),
  //               // TagsViewWidget(
  //               //   tags: tags,
  //               // ),
  //               // Tags(
  //               //   //key: _tagStateKey,
  //               //   //symmetry: _symmetry,
  //               //     columns: 3,
  //               //     alignment: WrapAlignment.start,
  //               //     //horizontalScroll: _horizontalScroll,
  //               //     //verticalDirection: VerticalDirection.up, textDirection: TextDirection.rtl,
  //               //     //heightHorizontalScroll: 60 * (_fontSize / 14),
  //               //     itemCount: tags.length,
  //               //     itemBuilder: (index) {
  //               //       final item = tags[index];
  //               //
  //               //       return ItemTags(
  //               //         key: Key(index.toString()),
  //               //         index: index,
  //               //         title: item.name,
  //               //         pressEnabled: false,
  //               //         elevation: 0,
  //               //         borderRadius: BorderRadius.circular(2.0),
  //               //         //border: ,
  //               //         activeColor: colorMap[item.name] == null
  //               //             ? Color.fromRGBO(255, 99, 97, 1.0):
  //               //         colorMap[item.name], //Colors.blueGrey[600],
  //               //         //singleItem: _singleItem,
  //               //         splashColor: Colors.green,
  //               //         combine: ItemTagsCombine.onlyText,
  //               //         textStyle: textTheme.overline,
  //               //
  //               //       );
  //               //     }
  //               // ),
  //               SizedBox(height: 5.0),
  //               buildJobStatus(),
  //               //buildTags(context),
  //
  //               // Tags(
  //               //   //key: _tagStateKey,
  //               //   //symmetry: _symmetry,
  //               //     columns: 3,
  //               //     alignment: WrapAlignment.start,
  //               //     //horizontalScroll: _horizontalScroll,
  //               //     //verticalDirection: VerticalDirection.up, textDirection: TextDirection.rtl,
  //               //     //heightHorizontalScroll: 60 * (_fontSize / 14),
  //               //     itemCount: statusTags.length,
  //               //     itemBuilder: (index) {
  //               //       final item = statusTags[index];
  //               //
  //               //       return ItemTags(
  //               //         key: Key(index.toString()),
  //               //         index: index,
  //               //         title: item.name,
  //               //         pressEnabled: false,
  //               //         elevation: 2,
  //               //         borderRadius: BorderRadius.circular(2.0),
  //               //         //border: ,
  //               //         activeColor: colorMap[item.name] == null
  //               //             ? Color.fromRGBO(255, 99, 97, 1.0):
  //               //         colorMap[item.name], //Colors.blueGrey[600],
  //               //         //singleItem: _singleItem,
  //               //         splashColor: Colors.green,
  //               //         combine: ItemTagsCombine.onlyText,
  //               //         textStyle: textTheme.overline,
  //               //       );
  //               //     }
  //               // ),
  //               SizedBox(height: 10.0),
  //             ],
  //           ),
  //         ),
  //         Expanded(
  //           flex: 1,
  //           child: Column(
  //             mainAxisSize: MainAxisSize.max,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.stretch,
  //             children: [
  //               Text(
  //                 '£' + widget.job.budget,
  //                 textAlign: TextAlign.center,
  //                 style: textTheme.bodyText1,
  //               )
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   ),
  //   );
  // }

  // Widget buildTags(BuildContext context) {
  //   // return BlocBuilder<QuoteBloc, QuoteState>(
  //   //   bloc: BlocProvider.of<QuoteBloc>(context)
  //   //     ..add(QuoteJobLoadEvent(id: widget.job.id)),
  //   //BlocProvider.of<QuoteBloc>(context).add(QuoteJobLoadEvent(id: widget.job.id));
  //   // return BlocProvider.value(
  //   //   value: BlocProvider.of<QuoteBloc>(context),
  //   //   child: BlocBuilder<QuoteBloc, QuoteState>(
  //   return BlocBuilder<QuoteBloc, QuoteState>(
  //     bloc: BlocProvider.of<QuoteBloc>(context)..add(QuoteJobLoadEvent(id: widget.job.id)),
  //       builder: (BuildContext context, QuoteState state) {
  //         if (state is QuoteJobLoaded) {
  //           widget.job.bids = state.quotes;
  //           return buildTagsContnt(context);
  //         } else if (state is QuoteJobLoadFailed) {
  //           return buildTagsContnt(context);
  //         } else {
  //           return const Center(child: CircularProgressIndicator());
  //         }
  //       },
  //     //),
  //   );
  // }

  // Widget buildTagsContnt(BuildContext context) {
  //   tags.clear();
  //   statusTags.clear();
  //   if (widget.job != null) {
  //     if (widget.job.tags != null) {
  //       tags.addAll(widget.job.tags);
  //       tags.forEach((element) {
  //         colorMap.addAll(<String,Color>{element.name: Color.fromRGBO(170, 186, 205, 1.0)});
  //       });
  //     }
  //     if (widget.job.isConfirmed != null && widget.job.isConfirmed == true) {
  //       tags.add(Tag(id: 0, name: 'Awarded'));
  //     } else if (widget.job.isConfirmed != null && widget.job.isConfirmed == true) {
  //       tags.add(Tag(id: 0, name: 'Confirmed'));
  //     } else if (widget.job.bids != null && widget.job.bids.length > 0) {
  //       tags.add(Tag(id: 0, name: widget.job.bids.length.toString() + ' Bids'));
  //     } else if (widget.job.isPosted == true) {
  //       tags.add(Tag(id: 0, name: 'Job Posted'));
  //     }
  //   }
  //   return TagsViewWidget(
  //     tags: tags,
  //   );
  // }

  // Widget buildBody2(BuildContext context) {
  //   final textTheme = Theme.of(context).textTheme;
  //   return Container(
  //     padding: EdgeInsets.all(12.0),
  //     margin: EdgeInsets.all(12.0),
  //     decoration: BoxDecoration(
  //       color: Color.fromRGBO(255, 255, 255, 1),
  //       borderRadius: BorderRadius.circular(8.0),
  //     ),
  //     //height: 197,
  //     child: Flex(
  //       direction: Axis.vertical,
  //       //mainAxisSize: MainAxisSize.min,
  //       //crossAxisAlignment: CrossAxisAlignment.start,
  //       //mainAxisAlignment: MainAxisAlignment.center,
  //       children: <Widget>[
  //         Row(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: <Widget>[
  //               Expanded(
  //                 flex: 1,
  //                 child: Flex(
  //                   direction: Axis.vertical,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   children: <Widget>[
  //                     CircleAvatar(
  //                       //backgroundColor: Color.fromRGBO(255,166,0,1),
  //                       radius: 15,
  //                       child: SvgPicture.asset(
  //                         ((widget.job.date != null
  //                               && (widget.job.date.difference(DateTime.now())).inDays > 0)
  //                               ? 'packages/local_people_core/assets/images/package-green.svg'
  //                               : 'packages/local_people_core/assets/images/package-orange.svg'),
  //                         fit: BoxFit.contain,
  //                         height: 63,
  //                         width: 63,
  //                       ),
  //                     ),
  //                     SizedBox(height: 5.0),
  //                     Text(
  //                       (widget.job.date != null
  //                           ? DateFormatUtil.getDateTimeDiff(
  //                           DateTime.now(), widget.job.date)
  //                           : ''),
  //                       textAlign: TextAlign.center,
  //                       style: textTheme.overline,
  //                       maxLines: 2,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               Expanded(
  //                 flex: 3,
  //                 child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: <Widget>[
  //                       Text(
  //                         widget.job.title != null
  //                             ? widget.job.title
  //                             : widget.job.description,
  //                         textAlign: TextAlign.left,
  //                         style: textTheme.subtitle1,
  //                         maxLines: 2,
  //                       ),
  //                       SizedBox(height: 15.0),
  //                       LocationsViewWidget(
  //                         location: (widget.job.location != null && widget.job.location.name != null)
  //                             ? widget.job.location.name : '',
  //                       ),
  //                       // BlocProvider.value(
  //                       //   value: BlocProvider.of<LocationBloc>(context)..add(GetLocationEvent(id: widget.job.location.id)),
  //                       //   child: BlocBuilder<LocationBloc, LocationState>(
  //                       //       builder: (context, state) {
  //                       //         // return widget here based on BlocA's state
  //                       //         if (state is GetLocationLoaded) {
  //                       //           widget.job.location = state.location;
  //                       //           return LocationsViewWidget(
  //                       //             location: (state.location != null && state.location.name != null)
  //                       //                 ? state.location.name : '',
  //                       //           );
  //                       //         } else if (state is GetLocationFailed) {
  //                       //           return LocationsViewWidget(
  //                       //             location: '',
  //                       //           );
  //                       //         } else if (state is GetLocationLoading) {
  //                       //           return LoadingWidget();
  //                       //         }
  //                       //         return LoadingWidget();
  //                       //       }
  //                       //   ),
  //                       // ),
  //                       SizedBox(height: 10.0),
  //                       TagsViewWidget(
  //                         tags: widget.job.tags != null ? widget.job.tags : [],
  //                       ),
  //                       // BlocProvider.value(
  //                       //   value: BlocProvider.of<TagBloc>(context)..add(LoadJobTagsEvent(jobId: widget.job.id)),
  //                       //   child: BlocBuilder<TagBloc, TagState>(
  //                       //       builder: (context, state) {
  //                       //         // return widget here based on BlocA's state
  //                       //         if (state is JobTagsLoaded) {
  //                       //           widget.job.tags = state.tags;
  //                       //           return TagsViewWidget(
  //                       //             tags: state.tags != null ? state.tags : [],
  //                       //           );
  //                       //         } else if (state is LoadJobTagsFailed) {
  //                       //           return TagsViewWidget(
  //                       //             tags: [],
  //                       //           );
  //                       //         } else if (state is JobTagsLoading) {
  //                       //           return LoadingWidget();
  //                       //         }
  //                       //         return LoadingWidget();
  //                       //       }
  //                       //   ),
  //                       // ),
  //                       SizedBox(height: 15.0),
  //                     ]),
  //               ),
  //               Expanded(
  //                   flex: 1,
  //                   child: Text(
  //                     '£' + widget.job.budget,
  //                     textAlign: TextAlign.center,
  //                     style: textTheme.bodyText1,
  //                   ),),
  //             ],),
  //       ],
  //     ),
  //   );
  // }
}

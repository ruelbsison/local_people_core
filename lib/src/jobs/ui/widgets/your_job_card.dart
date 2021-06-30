import 'package:flutter/material.dart';
import 'package:local_people_core/core.dart';
import 'tags_view_widget.dart';
import '../views/job_detail_screen.dart';
import '../views/job_bid_screen.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/job.dart';
import '../../domain/entities/tag.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/location_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_people_core/quote.dart';
import 'package:flutter_tags/flutter_tags.dart';

class YourJobCard extends StatefulWidget {
  YourJobCard({
    Key key,
    @required this.job,
  }) : super(key: key);

  Job job;

  @override
  _YourJobCardState createState() => _YourJobCardState();
}

class _YourJobCardState extends State<YourJobCard> {
  List<Tag> tags = [];
  List<Tag> statusTags = [];
  //List<Quote> bids = [];

  Map<String, Color> colorMap = {
    'Job Awarded' : Color.fromRGBO(170, 186, 205, 1.0),
    'Confirmed' : Color.fromRGBO(142, 209, 90, 1.0),
    'Job Posted' : Color.fromRGBO(170, 186, 205, 1.0),
    'Awaiting Response' : Color.fromRGBO(170, 186, 205, 1.0),
};

  @override
  void initState() {
    super.initState();

    print('YourJobCard.initState');
    initJobStatus();
  }

  @override
  void didChangeDependencies() {
    print('YourJobCard.didChangeDependencies');
  }

  void initJobStatus() {
    tags.clear();
    statusTags.clear();
    if (widget.job != null) {
      // if (widget.job.tags != null) {
      //   tags.addAll(widget.job.tags);
      //   tags.forEach((element) {
      //     colorMap.addAll(<String, Color>{
      //       element.name: Color.fromRGBO(170, 186, 205, 1.0)
      //     });
      //   });
      // }
      if (widget.job.awarded != null && widget.job.awarded == true) {
        tags.add(Tag(id: 0, name: 'Awarded'));
      } else
      if (widget.job.isConfirmed != null && widget.job.isConfirmed == true) {
        tags.add(Tag(id: 0, name: 'Confirmed'));
      } else if (widget.job.bids != null && widget.job.bids.length > 0) {
        tags.add(
            Tag(id: 0, name: widget.job.bids.length.toString() + ' Bids'));
      } else if (widget.job.isPosted == true) {
        tags.add(Tag(id: 0, name: 'Job Posted'));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print('YourJobCard.build');
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: (){
        //if (widget.onJobPressed != null) {
        //  widget.onJobPressed(widget.job);
        //} else {
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
        //}
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
                  //SizedBox(height: 5.0),
                  //buildLocation(),
                  // LocationsViewWidget(
                  //   location: (widget.job.location != null && widget.job.location.name != null)
                  //       ? widget.job.location.name : '',
                  //   maxTagViewHeight: 45,
                  // ),
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
    // BlocProvider.of<QuoteBloc>(context).add(QuoteJobLoadEvent(id: widget.job.id));
    // return BlocProvider.value(
    //   value: BlocProvider.of<QuoteBloc>(context),
    //   child: BlocBuilder<QuoteBloc, QuoteState>(
    //     builder: (context, state) {
    //       final appType = AppConfig.of(context).appType;
    //       if (state is QuoteJobLoaded) {
    //         widget.job.bids.clear();
    //         widget.job.bids.addAll(state.quotes);
    //         initJobStatus();
    //         return buildBody(context);
    //       } else if (state is QuoteJobLoadFailed) {
    //         return buildBody(context);
    //       } else {
    //         //return const Center(child: CircularProgressIndicator());
    //         return LoadingWidget();
    //       }
    //     },
    //   ),
    // );
    // BlocProvider.of<LocationBloc>(context)
    //     .add(GetLocationEvent(id: widget.job.id));
    // return BlocBuilder<LocationBloc, LocationState>(
    //   bloc: BlocProvider.of<LocationBloc>(context),
    //   builder: (BuildContext context, LocationState state) {
    //     //final appCType = AppConfig.of(context).appType;
    //     if (state is GetLocationLoaded) {
    //       //setState(() {
    //       widget.job.location = state.location;
    //       widget.job.entityStatus = EntityStatus.ENTIRY_STATUS_COMPLETED;
    //       //});
    //       return buildBody(context);
    //     } else if (state is GetLocationFailed) {
    //       //setState(() {
    //       //widget.job = state.job;
    //       widget.job.entityStatus = EntityStatus.ENTIRY_STATUS_ERROR;
    //       //});
    //
    //       return buildBody(context);
    //     } else {
    //       return LoadingWidget();
    //     }
    //   },
    // );
  }

  Widget buildBody(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
        onTap: () {
          //if (widget.onPressedOpportunity != null)
          //  widget.onPressedOpportunity(widget.opportunityItem);
          AppRouter.pushPage(
            context,
            DialogManager(
              child: JobBidScreen(
                job: widget.job,
              ),
            ),);
        },
        //   child: Container(
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
        children: [
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
                  style: textTheme.overline,
                  maxLines: 2,
                ),
                ),
              ),
            ],
          ),
        ),
          Expanded(
            flex: 4,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                TagsViewWidget(
                  tags: tags,
                ),
              // Tags(
              //   //key: _tagStateKey,
              //   //symmetry: _symmetry,
              //   columns: 3,
              //   alignment: WrapAlignment.start,
              //   //horizontalScroll: _horizontalScroll,
              //   //verticalDirection: VerticalDirection.up, textDirection: TextDirection.rtl,
              //   //heightHorizontalScroll: 60 * (_fontSize / 14),
              //   itemCount: tags.length,
              //   itemBuilder: (index) {
              //     final item = tags[index];
              //
              //     return ItemTags(
              //       key: Key(index.toString()),
              //       index: index,
              //       title: item.name,
              //       pressEnabled: false,
              //       elevation: 2,
              //       borderRadius: BorderRadius.circular(2.0),
              //       //border: ,
              //       activeColor: colorMap[item.name] == null
              //           ? Color.fromRGBO(255, 99, 97, 1.0):
              //       colorMap[item.name], //Colors.blueGrey[600],
              //       //singleItem: _singleItem,
              //       splashColor: Colors.green,
              //       combine: ItemTagsCombine.onlyText,
              //       textStyle: textTheme.overline,
              //
              //     );
              //   }
              // ),
                SizedBox(height: 5.0),
                //buildTags(context),
                TagsViewWidget(
                  tags: statusTags,
                ),
                // Tags(
                //   //key: _tagStateKey,
                //   //symmetry: _symmetry,
                //     columns: 3,
                //     alignment: WrapAlignment.start,
                //     //horizontalScroll: _horizontalScroll,
                //     //verticalDirection: VerticalDirection.up, textDirection: TextDirection.rtl,
                //     //heightHorizontalScroll: 60 * (_fontSize / 14),
                //     itemCount: statusTags.length,
                //     itemBuilder: (index) {
                //       final item = statusTags[index];
                //
                //       return ItemTags(
                //         key: Key(index.toString()),
                //         index: index,
                //         title: item.name,
                //         pressEnabled: false,
                //         elevation: 2,
                //         borderRadius: BorderRadius.circular(2.0),
                //         //border: ,
                //         activeColor: colorMap[item.name] == null
                //             ? Color.fromRGBO(255, 99, 97, 1.0):
                //         colorMap[item.name], //Colors.blueGrey[600],
                //         //singleItem: _singleItem,
                //         splashColor: Colors.green,
                //         combine: ItemTagsCombine.onlyText,
                //         textStyle: textTheme.overline,
                //       );
                //     }
                // ),
                SizedBox(height: 10.0),
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

  // Widget buildTags(BuildContext context) {
  //   BlocProvider.of<QuoteBloc>(context).add(QuoteJobLoadEvent(id: widget.job.id));
  //   return BlocProvider.value(
  //     value: BlocProvider.of<QuoteBloc>(context),
  //     child: BlocBuilder<QuoteBloc, QuoteState>(
  //       builder: (context, state) {
  //         if (state is QuoteJobLoaded) {
  //           widget.job.bids = state.quotes;
  //           return buildTagsContnt(context);
  //         } else if (state is QuoteJobLoadFailed) {
  //           return buildTagsContnt(context);
  //         } else {
  //           return const Center(child: CircularProgressIndicator());
  //         }
  //       },
  //     ),
  //   );
  // }
  //
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

  Widget buildBody2(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        //if (widget.onPressedOpportunity != null)
        //  widget.onPressedOpportunity(widget.opportunityItem);
        AppRouter.pushPage(
            context,
          DialogManager(
          child: JobBidScreen(
            job: widget.job,
          ),
        ),);
      },
    //   child: Container(
    child: Container(
      padding: EdgeInsets.all(12.0),
      margin: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      //height: 197,
      child: Flex(
        direction: Axis.vertical,
        // mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
              //mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Flex(
                    direction: Axis.vertical,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      CircleAvatar(
                        //backgroundColor: Color.fromRGBO(255,166,0,1),
                        radius: 15,
                        child: SvgPicture.asset(
                          'packages/local_people_core/assets/images/package-orange.svg',
                          fit: BoxFit.contain,
                          height: 63,
                          width: 63,
                        ),
                      ),
                      Text(
                        (widget.job.date != null
                            ? DateFormatUtil.getDateTimeDiff(
                                DateTime.now(), widget.job.date)
                            : ''),
                        textAlign: TextAlign.center,
                        style: textTheme.overline,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          widget.job.title != null
                              ? widget.job.title
                              : widget.job.description,
                          textAlign: TextAlign.left,
                          style: textTheme.subtitle1,
                          maxLines: 2,
                        ),
                        SizedBox(height: 15.0),
                        Text(
                          (widget.job.date != null
                                  ? DateFormat('dd MMMM yyyy')
                                      .format(widget.job.date)
                                  : '') +
                              (widget.job.date != null
                                  ? ' | ' +
                                      DateFormatUtil.getDateTimeDiff(
                                          DateTime.now(), widget.job.date)
                                  : ''),
                          textAlign: TextAlign.left,
                          style: textTheme.subtitle2,
                        ),
                        SizedBox(height: 10.0),
                        TagsViewWidget(
                          tags: widget.job.tags != null ? widget.job.tags : [],
                        ),
                        // BlocProvider.value(
                        //   value: BlocProvider.of<TagBloc>(context)..add(LoadJobTagsEvent(jobId: widget.job.id)),
                        //   child: BlocBuilder<TagBloc, TagState>(
                        //       builder: (context, state) {
                        //         // return widget here based on BlocA's state
                        //         if (state is JobTagsLoaded) {
                        //           widget.job.tags = state.tags;
                        //           return TagsViewWidget(
                        //             tags: state.tags != null ? state.tags : [],
                        //           );
                        //         } else if (state is LoadJobTagsFailed) {
                        //           return TagsViewWidget(
                        //             tags: [],
                        //           );
                        //         } else if (state is JobTagsLoading) {
                        //           return LoadingWidget();
                        //         }
                        //         return LoadingWidget();
                        //       }
                        //   ),
                        // ),
                        SizedBox(height: 15.0),
                      ]),
                ),
                Expanded(
                    flex: 1,
                    child: Text(
                      '£' + widget.job.budget,
                      textAlign: TextAlign.center,
                      style: textTheme.bodyText1,
                    )),
              ]),
        ],
      ),
      ),
    );
  }
}

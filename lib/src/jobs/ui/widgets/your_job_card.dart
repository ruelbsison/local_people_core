import 'package:flutter/material.dart';
import 'package:local_people_core/core.dart';
import 'tags_view_widget.dart';
import '../views/job_bid_screen.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/job.dart';
import '../../domain/entities/tag.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/location_bloc.dart';
// import '../blocs/tag_bloc.dart';
// import '../blocs/job_bloc.dart';
// import '../blocs/job_event.dart';
// import '../blocs/job_state.dart';

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


  @override
  Widget build(BuildContext context) {
    BlocProvider.of<LocationBloc>(context)
        .add(GetLocationEvent(id: widget.job.id));
    return BlocBuilder<LocationBloc, LocationState>(
      bloc: BlocProvider.of<LocationBloc>(context),
      builder: (BuildContext context, LocationState state) {
        //final appCType = AppConfig.of(context).appType;
        if (state is GetLocationLoaded) {
          //setState(() {
          widget.job.location = state.location;
          widget.job.entityStatus = EntityStatus.ENTIRY_STATUS_COMPLETED;
          //});
          return buildBody(context);
        } else if (state is GetLocationFailed) {
          //setState(() {
          //widget.job = state.job;
          widget.job.entityStatus = EntityStatus.ENTIRY_STATUS_ERROR;
          //});

          return buildBody(context);
        } else {
          return LoadingWidget();
        }
      },
    );
  }

  Widget buildBody(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // return InkWell(
    //   onTap: () {
    //     //if (widget.onPressedOpportunity != null)
    //     //  widget.onPressedOpportunity(widget.opportunityItem);
    //     AppRouter.pushPage(
    //         context,
    //       DialogManager(
    //       child: JobBidScreen(
    //         job: widget.job,
    //       ),
    //     ),);
    //   },
    //   child: Container(
    return Container(
      padding: EdgeInsets.all(12.0),
      margin: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      //height: 197,
      child: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Flex(
                    direction: Axis.vertical,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      mainAxisAlignment: MainAxisAlignment.start,
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
      //),
    );
  }

  @override
  void initState() {
    super.initState();

    if (widget.job.isPosted == true) {
      widget.job.tags.add(Tag(id: 0, name:'Job Posted'));
    }
  }
}

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
import '../blocs/tag_bloc.dart';

class YourJobCard extends StatefulWidget {
  YourJobCard({
    Key key,
    @required this.job,
  }) : super(key: key);

  final Job job;

  @override
  _YourJobCardState createState() => _YourJobCardState();
}

class _YourJobCardState extends State<YourJobCard> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        //if (widget.onPressedOpportunity != null)
        //  widget.onPressedOpportunity(widget.opportunityItem);
        AppRouter.pushPage(
            context,
          JobBidScreen(
            job: widget.job,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.only(top: 6.0, bottom: 6.0),
        margin: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadius.circular(5.0),
        ),
        //height: 197,
        child: Flex(
          direction: Axis.vertical,
          //mainAxisSize: MainAxisSize.min,
          //crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Flex(
                      direction: Axis.vertical,
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
                        SizedBox(height: 5.0),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              tags: widget.job.tags != null ? widget.job.tags : [Tag(id: 0, name:'Job Posted'),],
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

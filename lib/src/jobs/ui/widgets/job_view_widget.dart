import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:local_people_core/core.dart';
import '../widgets/tags_view_widget.dart';
import '../widgets/images_view_widget.dart';
import '../../domain/entities/job.dart';

class JobViewWidget extends StatefulWidget {
  JobViewWidget({
    Key key,
    @required this.job,
  }) : super(key: key);

  final Job job;

  @override
  _JobViewWidgetState createState() =>
      _JobViewWidgetState();
}

class _JobViewWidgetState extends State<JobViewWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Flex(
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          LocalPeopleLocalizations.of(context).titleJobInfo,
          style: theme.textTheme.subtitle1,
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 5.0),
        Text(
          widget.job.preview,
          style: theme.textTheme.bodyText2,
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 20.0),
        Text(
          LocalPeopleLocalizations.of(context).titleDate + ' ' + DateFormat('EEE, MMM dd, yyyy').format(widget.job.date),
          textAlign: TextAlign.center,
          style: theme.textTheme.subtitle1,
        ),
        SizedBox(height: 20.0),
        Text(
          LocalPeopleLocalizations.of(context).titleTime + ' '  + DateFormat('HH::mm').format(widget.job.date),
          textAlign: TextAlign.center,
          style: theme.textTheme.subtitle1,
        ),
        SizedBox(height: 20.0),
        Text(
          LocalPeopleLocalizations.of(context).titleBudget + ' ' + widget.job.budget,
          textAlign: TextAlign.center,
          style: theme.textTheme.subtitle1,
        ),
        SizedBox(height: 5.0),
        TagsViewWidget(
          tags: [], //widget.job.tags,
        ),
        SizedBox(height: 20.0),
        Container(
          height: 119.0,
          alignment: Alignment.centerLeft,
          //child: ImagesViewWidget(images: widget.job.images,),
        ),
        Text(
          LocalPeopleLocalizations.of(context).titleLocation,
          textAlign: TextAlign.center,
          style: theme.textTheme.subtitle1,
        ),
        Container(
          color: theme.primaryColor,
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 120.0),
              /*GoogleMap(
                        myLocationEnabled: true,
                        compassEnabled: true,
                        tiltGesturesEnabled: false,
                        //markers: _markers,
                        //polylines: _polylines,
                        mapType: MapType.normal,
                        initialCameraPosition: _kGooglePlex,
                      ),*/
              Text(
                'Cumberland & Grange, Guildford, GU2',
                textAlign: TextAlign.left,
                style: theme.textTheme.bodyText1,
              ),
              Text(
                'The complete address will be show once the job is confirmed',
                textAlign: TextAlign.left,
                style: theme.textTheme.bodyText2,
              ),
              SizedBox(height: 60.0),
            ],
          ),
        ),
      ],
    );
  }

}
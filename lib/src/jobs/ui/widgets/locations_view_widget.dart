import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class LocationsViewWidget extends StatefulWidget {
  String location;
  double maxTagViewHeight;
  double  minTagViewHeight;
  Color tagBackgroundColor;

  LocationsViewWidget(
      {@required this.location,
        this.minTagViewHeight = 0,
        this.maxTagViewHeight = 80,
        this.tagBackgroundColor})
      : assert(location != null,
  'Tags can\'t be empty\n'
      'Provide the list of tags');

  @override
  _LocationsViewWidgetState createState() => _LocationsViewWidgetState();
}

class _LocationsViewWidgetState extends State<LocationsViewWidget> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints:BoxConstraints(
          minHeight: widget.minTagViewHeight,
          maxHeight: widget.maxTagViewHeight,
        ),
        child: SingleChildScrollView(
          child: Wrap(
            alignment: WrapAlignment.start,
            spacing: 5.0,
            direction: Axis.horizontal,
            children: buildLocations(),
          ),
        )
    );
  }

  List<Widget> buildLocations() {
    List<Widget> tags = <Widget>[];
    tags.add(createLocation(0, widget.location));
    //for(int i = 0; i < widget.locations.length; i++) {
    //tags.add(createLocation(i, widget.locations[i]));
    //}
    return tags;
  }

  Widget createLocation(int index, String locationTitle) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: (widget.tagBackgroundColor == null ? Color.fromRGBO(196, 196, 196, 1) : widget.tagBackgroundColor),
        borderRadius: BorderRadius.circular(2.0),
      ),
      child: Flex (
        direction: Axis.horizontal,
        mainAxisSize: MainAxisSize.min,
        children: <Widget> [
          Icon (
            MaterialIcons.location_on,
            size: 15.0,
          ),
          Text(
            locationTitle,
            style: textTheme.overline,
          ),
        ],
      ),
    );
  }
}
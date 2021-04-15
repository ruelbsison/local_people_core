import 'package:flutter/material.dart';

class TagsViewWidget extends StatefulWidget {
  List<String> tags;
  double maxTagViewHeight;
  double  minTagViewHeight;
  Color tagBackgroundColor;

  TagsViewWidget({
    @required this.tags,
    this.minTagViewHeight = 0,
    this.maxTagViewHeight = 80,
    this.tagBackgroundColor})
      : assert(tags != null,
  'Tags can\'t be empty\n'
      'Provide the list of tags');

  @override
  _TagWidgetState createState() => _TagWidgetState();
}

class _TagWidgetState extends State<TagsViewWidget> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ConstrainedBox(
        constraints:BoxConstraints(
          minHeight: widget.minTagViewHeight,
          maxHeight: widget.maxTagViewHeight,
        ),
        child: SingleChildScrollView(
          child: Wrap(
            alignment: WrapAlignment.start,
            spacing: 5.0,
            runSpacing: 5.0,
            direction: Axis.horizontal,
            children: buildTags(),
          ),
        )
    );
  }

  List<Widget> buildTags() {
    List<Widget> tags = <Widget>[];
    for(int i = 0; i < widget.tags.length; i++) {
      tags.add(createTag(i, widget.tags[i]));
    }
    return tags;
  }

  Widget createTag(int index, String tagTitle) {
    return Container(
      padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: (widget.tagBackgroundColor == null ? Color.fromRGBO(170, 186, 205, 1) : widget.tagBackgroundColor),
        borderRadius: BorderRadius.circular(2.0),
      ),
      child: Text(
        tagTitle,
        style: TextStyle(
          color: Color.fromRGBO(255, 255, 255, 1),
          fontSize: 10,
          fontWeight: FontWeight.w500,
          fontFamily: 'RedHatDisplay',
        ),
      ),
    );
  }
}
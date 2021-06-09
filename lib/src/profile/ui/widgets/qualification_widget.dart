import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:local_people_core/profile.dart';
import '../../domain/entities/qualification.dart';
import 'package:uuid/uuid.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:local_people_core/jobs.dart';
import 'qualification_card.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:local_people_core/jobs.dart';

class QualificationWidget extends StatefulWidget {
  List<Qualification> qualifications;
  final List<String> sugesstions;
  QualificationWidget(
      {@required this.qualifications,
      this.sugesstions = const [],
    });

  @override
  _QualificationWidgetState createState() => _QualificationWidgetState();
}

class _QualificationWidgetState extends State<QualificationWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: Color(0xfff5f5f5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container (
            padding: EdgeInsets.only(left: 12.0),
            child: Text(
            "Qualifications",
            style: theme.textTheme.subtitle1,
          ),
          ),
          ListView.builder(
            primary: false,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                child: createQualification(widget.qualifications[index]),
                onTap: () {
                  // TODO 15: Call Add To Cart
                }
              );
            },
            itemCount: widget.qualifications == null ? 0 : widget.qualifications.length,
          ),
        ],
      ),
    );
  }

  Widget createQualification(Qualification qualification) {
    return QualificationCard(
      qualification: qualification,
      sugesstions: widget.sugesstions,
    );
  }

}

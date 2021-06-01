import 'package:flutter/material.dart';
import 'package:local_people_core/core.dart';
import '../../domain/entities/package.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QualificationCard extends StatelessWidget {
  const QualificationCard({
    Key key,
    @required this.qualification,
  }) : super(key: key);

  final String qualification;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    //Size size = MediaQuery.of(context).size;
    //AppType appType = AppConfig.of(context).appType;
    return Flex(
      direction: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: CircleAvatar(
            radius: 12,
            child: Center(
                child: Image.asset(
                  'packages/local_people_core/assets/images/verified-icon.png',
                  fit: BoxFit.contain,
                  height: 23,
                  width: 23,
                )),
          ),
        ),
        Expanded(
            flex: 5,
            child: Text(
              qualification != null ? qualification : '',
              textAlign: TextAlign.left,
              style: theme.textTheme.subtitle1,
            ),
        ),
      ],
    );
  }
}

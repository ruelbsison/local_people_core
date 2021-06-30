import 'package:local_people_core/core.dart';
import 'package:flutter/material.dart';

class TopWelcomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SpacerWidget(height: 41),
        SizedBox(
          width: 172,
          child: LogoWidget(),
        ),
        SpacerWidget(height: 40),
        Text('Welcome Buddies'), //, style: FONT_CONST.MEDIUM_WHITE_22),
        Text(' Login to book your seat, I said its your seat'),
            // style: FONT_CONST.MEDIUM_WHITE_14),
        SpacerWidget(height: 30),
      ],
    );
  }
}

//import 'package:find_seat/utils/my_const/my_const.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class LogoWidget extends StatelessWidget {
  final double height;
  final BoxFit fit;
  final Color backgroundColor = Colors.white;

  LogoWidget({Key key, this.fit, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'packages/local_people_core/assets/images/app-logo.png',
      fit: fit,
      height: height,
      //color: backgroundColor,
    );
  }
}

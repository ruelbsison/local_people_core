//import 'package:find_seat/utils/my_const/my_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoWidget extends StatelessWidget {
  final double height;
  final double width;
  final BoxFit fit;
  final Color backgroundColor = Color.fromRGBO(255, 255, 255, 0.5);

  LogoWidget({Key key, this.fit, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'packages/local_people_core/assets/images/app-logo.svg',
      fit: fit,
      height: height,
      width: width,
      //color: Colors.green,
      //color: backgroundColor,
      alignment: Alignment.center,
    );
    return Image.asset(
      'packages/local_people_core/assets/images/local-people-logo.png',
      fit: fit,
      height: height,
      width: width,
      //color: Colors.green,
      //color: backgroundColor,
      alignment: Alignment.center,
    );
  }
}

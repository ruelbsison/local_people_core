//import 'package:find_seat/utils/my_const/my_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ErrorWidget extends StatelessWidget {
  final String message;
  final double height;
  final double width;
  final BoxFit fit;
  final Color backgroundColor = Color.fromRGBO(255, 255, 255, 0.5);

  ErrorWidget({Key key, this.message, this.fit = BoxFit.contain, this.width = 80, this.height = 80}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center (
      //child: LoadingWidget(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding (
            padding: EdgeInsets.all(16.0),
            child: SvgPicture.asset(
              'packages/local_people_core/assets/images/error-icon.svg',
              fit: fit,
              height: height,
              width: width,
            ),
          ),
          Text(
            message,
            style: theme.textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}

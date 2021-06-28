import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  final bool isImage;

  LoadingWidget({this.isImage = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
      child: Center(
        child: _buildBody(context),
      ),
    );
  }

  _buildBody(BuildContext context) {
    if (isImage) {
      return SpinKitRipple(
        color: Color.fromRGBO(255, 99, 95, 1), //Theme.of(context).accentColor,
      );
    } else {
      return SpinKitWave(
        color: Color.fromRGBO(255, 99, 95, 1), //Theme.of(context).accentColor,
      );
    }
  }
}

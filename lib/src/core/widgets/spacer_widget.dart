import 'package:flutter/material.dart';

class SpacerWidget extends StatelessWidget {
  double _height = 16;
  double _width;

  SpacerWidget({double height, double width = 0})
      : this._height = height,
        this._width = width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      width: _width,
    );
  }
}

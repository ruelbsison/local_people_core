import 'package:flutter/material.dart';

class BoxContainerWidget extends StatelessWidget {
  double _height = 16;
  double _width;
  Widget _child;

  BoxContainerWidget({Key key, double height, double width = 0, Widget child})
      : this._height = height,
        this._width = width,
        this._child = child,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 12.0, right: 12.0),
        padding: EdgeInsets.all(12.0),
        height: _height,
        width: _width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
        ),
      child: _child,
    );
  }
}

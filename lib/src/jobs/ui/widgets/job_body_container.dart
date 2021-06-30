import 'package:flutter/material.dart';

class JobBodyContainer extends StatelessWidget {
  double _height;
  double _width;
  Widget _child;

  JobBodyContainer({Key key, double height, double width = 0, Widget child})
      : this._height = height,
        this._width = width,
        this._child = child,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      width: _width,
      color: Colors.white,
      child: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                color: Color(0x7fdee8ec),
                child: _child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

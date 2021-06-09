import 'package:flutter/material.dart';
import 'suggested_time_slot_widget.dart';
import 'place_bid_detail_widget.dart';
//import 'place_bid_total_widget.dart';
import 'package:page_indicator/page_indicator.dart';

class PlaceBidWidget extends StatefulWidget {
  PlaceBidWidget({
    Key key,
  }) : super(key: key);

  @override
  _PlaceBidWidgetState createState() => _PlaceBidWidgetState();
}

class _PlaceBidWidgetState extends State<PlaceBidWidget> {
  PageController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.white,
      width: 345,
      height: 429,
      margin: EdgeInsets.only(left: 12, right: 12),
      //padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Color.fromRGBO(239, 244, 246, 1), width: 2),
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white),
      child: Expanded(
        flex: 1,
        child: PageIndicatorContainer(
          child: PageView(
            children: <Widget>[
              SuggestedTimeSlotWidget(),
              PlaceBidDetailWidget(),
              //PlaceBidTotallWidget(),
            ],
            controller: _controller,
          ),
          align: IndicatorAlign.bottom,
          length: 2,
          indicatorSpace: 20.0,
          padding: const EdgeInsets.all(10),
          indicatorColor: Color.fromRGBO(255, 99, 95, 1),
          indicatorSelectorColor: Colors.white,
          shape: IndicatorShape.circle(size: 12),
          // shape: IndicatorShape.roundRectangleShape(size: Size.square(12),cornerSize: Size.square(3)),
          // shape: IndicatorShape.oval(size: Size(12, 8)),
        ),
      ),
    );
  }

  Widget buildSuggestedTimeSlot(BuildContext context) {}

  @override
  void initState() {
    super.initState();

    _controller = PageController(
      initialPage: 0,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
  }
}

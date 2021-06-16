import 'package:flutter/material.dart';
import 'suggested_time_slot_widget.dart';
import 'place_bid_detail_widget.dart';
//import 'package:overlay_dialog/overlay_dialog.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_people_core/jobs.dart';
import 'package:local_people_core/quote.dart';

class PlaceBidWidget extends StatefulWidget {
  PlaceBidWidget({
    Key key,
    this.job,
  }) : super(key: key);

  final Job job;
  @override
  _PlaceBidWidgetState createState() => _PlaceBidWidgetState();
}

class _PlaceBidWidgetState extends State<PlaceBidWidget> {
  PageController _controller;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<QuoteBloc>(context),
      child: BlocListener<QuoteBloc, QuoteState>(
        listener: (context, state) {
          if (state is QuoteInitial) {

          } else if (state is QuoteAdded) {
            // Future
            //     .delayed(Duration(seconds: 3))
            //     .then((_) => DialogHelper().hide(context));
            //Navigator.of(context).popUntil(ModalRoute.withName('/'));
          } else if (state is QuoteAdding) {
            // DialogHelper().show(
            //     context,
            //     DialogWidget.progress(style: DialogStyle.material)
            // );
          }
        },
        child: buildDialogContent(context),
      ),
    );
  }

  Widget buildDialogContent(BuildContext context) {
    return Container(
      //color: Colors.white,
      width: 345,
      height: 429,
      // margin: EdgeInsets.only(left: 12, right: 12),
      // //padding: EdgeInsets.all(10),
      // decoration: BoxDecoration(
      //     border: Border.all(color: Color.fromRGBO(239, 244, 246, 1), width: 2),
      //     borderRadius: BorderRadius.circular(8.0),
      //     color: Colors.white),
      child: PageIndicatorContainer(
        child: PageView(
          children: <Widget>[
            SuggestedTimeSlotWidget(),
            PlaceBidDetailWidget(job: widget.job,),
            //PlaceBidTotallWidget(),
          ],
          controller: _controller,
        ),
        align: IndicatorAlign.bottom,
        length: 2,
        indicatorSpace: 20.0,
        padding: const EdgeInsets.all(10),
        indicatorColor: Colors.grey,
        indicatorSelectorColor: Color.fromRGBO(255, 99, 95, 1),
        shape: IndicatorShape.circle(size: 12),
        // shape: IndicatorShape.roundRectangleShape(size: Size.square(12),cornerSize: Size.square(3)),
        // shape: IndicatorShape.oval(size: Size(12, 8)),
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
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:local_people_core/src/core/dialog/place_bid_dialog.dart';
import 'suggested_time_slot_widget.dart';
import 'place_bid_detail_widget.dart';
//import 'package:overlay_dialog/overlay_dialog.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_people_core/jobs.dart';
import 'package:local_people_core/quote.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/schedule.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/jobs.dart';
import 'package:local_people_core/auth.dart';

class PlaceBidWidget extends StatefulWidget {
  PlaceBidWidget({
    Key key,
    @required this.job,
    @required this.traderId,
  }) : super(key: key);

  final Job job;
  final int traderId;
  Quote quote = Quote();
  @override
  _PlaceBidWidgetState createState() => _PlaceBidWidgetState();
}

class _PlaceBidWidgetState extends State<PlaceBidWidget> {
  PageController _controller;

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

  @override
  Widget build(BuildContext context) {
    final appType = AppConfig.of(context).appType;
    ScheduleBloc scheduleBloc = ScheduleBloc(
      appType: AppConfig.of(context).appType,
      jobRepository: RepositoryProvider.of<JobRepository>(context),
      quoteRepository: RepositoryProvider.of<QuoteRepository>(context),
      bookingRepository: RepositoryProvider.of<BookingRepository>(context),
      authLocalDataSource: sl<AuthLocalDataSource>(),
    );
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
            SuggestedTimeSlotWidget(
              pageController: _controller,
              scheduleBloc: scheduleBloc,
              onSuggestedTimeSlotSubmitted: (duration, startDateTime) {
                widget.quote.dureationRequired = duration;
                widget.quote.deliveryDate = startDateTime;
              },
            ),
            PlaceBidDetailWidget(
              job: widget.job,
              pageController: _controller,
              onDibDetailsSubmitted: (labour, materials, total, deposit){
                widget.quote.jobId = widget.job.id;
                widget.quote.traderId = widget.traderId;
                widget.quote.labour = labour.toString();
                widget.quote.materials = materials.toString();
                widget.quote.totalCost = total.toString();
                widget.quote.depositRequired = deposit.toString();

                DialogService _dialogService = sl<DialogService>();
                _dialogService.placeBidDialogComplete(PlaceBidResponse(quote: widget.quote));
              },
              onGetTimeslot: () {
                return widget.quote.deliveryDate;
              },
            ),
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

}

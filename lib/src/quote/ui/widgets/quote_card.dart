import 'package:flutter/material.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/jobs.dart';
import 'package:local_people_core/profile.dart';
import 'package:local_people_core/auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../domain/entities/quote.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef OnQuotePressed = void Function(Job job, Quote quote, TraderProfile traderProfile);

class QuoteCard extends StatefulWidget {
  QuoteCard({
    Key key,
    @required this.job,
    @required this.quote,
    @required this.traderProfile,
    this.withTap = true,
    this.backgroundColor,
    this.onQuotePressed,
  }) : super(key: key);

  final Job job;
  final Quote quote;
  final TraderProfile traderProfile;
  final bool withTap;
  final Color backgroundColor;
  final OnQuotePressed onQuotePressed;

  @override
  _QuoteCardState createState() => _QuoteCardState();
}



class _QuoteCardState extends State<QuoteCard> {

  Widget buildQualifications(BuildContext context) {
    //
    return BlocProvider(
        create: (context) => QualificationBloc(
      qualificationRepository: RepositoryProvider.of<QualificationRepository>(context),
      authLocalDataSource: sl<AuthLocalDataSource>(),
    )..add(QualificationGetEvent(id: widget.traderProfile.id)),
    child: BlocBuilder<QualificationBloc, QualificationState>(
      builder: (context, state) {
        if (state is QualificationLoaded) {
          List<Tag> tags = [];
          state.qualifications.forEach((element) {
            Tag tag = Tag(id: 9, name: element.title);
            tags.add(tag);
          });
          return TagsViewWidget(
            tags: tags,
          );
        } else if (state is TraderProfileGetFailed) {
          return TagsViewWidget(
            tags: [],
          );
        } else {
        return LoadingWidget();
        }
    }),);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        if (widget.withTap == false)
          return;
        if (widget.onQuotePressed != null)
          widget.onQuotePressed(
              widget.job,
              widget.quote,
              widget.traderProfile
          );
      },
      // child: Container (
      //   width: 361,
      //   height: 203,
      //   decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(8),
      //     border: Border.all(color: Color(0xffff6361), width: 1, ),
      //   ),
      child: Container(
        color: widget.backgroundColor != null ? widget.backgroundColor : theme.backgroundColor,
    child: Container(
      //return Container(
      //color: Colors.white,
      //width: 334,
      //height: 59,
      padding: widget.backgroundColor != null ? EdgeInsets.only(left: 12.0, bottom: 12.0, right: 12.0, top: 12.0) : EdgeInsets.all(12.0),
      margin: widget.backgroundColor != null ? EdgeInsets.only(left: 12.0, bottom: 12.0, right: 12.0, top: 12.0) : EdgeInsets.all(12.0), //EdgeInsets.only(top: 12.0, bottom: 12.0),
      //child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        // color: Color(
        //   0xffeff4f6,
        // ),
        borderRadius: BorderRadius.circular(
          5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
          Expanded(
            child: Container(
              child: Text(
                widget.traderProfile != null && widget.traderProfile.fullName != null
                ? widget.traderProfile.fullName : '',
                style: textTheme.subtitle1,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 1,
              ),
            ),
            flex: 1,
          ),
          ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Text(
                    widget.traderProfile != null && widget.traderProfile.intro != null
                        ? widget.traderProfile.intro : '',
                    style: textTheme.bodyText2,
                  ),
                ),
                flex: 1,
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row (
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: SmoothStarRating (
                    allowHalfRating: false,
                    onRated: (v) {},
                    starCount: 5,
                    rating: 100,
                    size: 20.0,
                    isReadOnly:true,
                    //fullRatedIconData: Icons.blur_off,
                    //halfRatedIconData: Icons.blur_on,
                    color: Color.fromRGBO(255, 99, 97, 1),
                    borderColor: Color.fromRGBO(255, 99, 97, 1),
                    spacing:0.0
                ),
              ),
              Expanded(
                  flex: 6,
                  child: Text(
                    "Avg Rating (10 Reviews)",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 8,
                      fontWeight: FontWeight.w500,
                      fontFamily: "RedHatDisplay",
                    ),
                  ),
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                    //color: Colors.green,
                    //width: (MediaQuery.of(context).size.width / 4),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ClipOval  (
                        //padding: EdgeInsets.all(2.0),
                        child: SvgPicture.asset(
                          'packages/local_people_core/assets/images/heart.svg',
                          fit: BoxFit.contain,
                          height: 15,
                          width: 15,
                        ),
                      ),
                    ),
                  ),
              ),
              Expanded(
                  flex: 1,
                  child: Container (
                    //color: Colors.orange,
                    child: Align(
                      alignment: Alignment.center,
                      child:Text(
                        "32",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 8,
                          fontWeight: FontWeight.w500,
                          fontFamily: "RedHatDisplay",
                        ),
                      ),
                    ),
                  ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisSize: MainAxisSize.min,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: buildQualifications(context),
                // child: TagsViewWidget(
                //   tags: [Tag(id: 0, name: 'Handyman'), Tag(id: 0, name: 'Window Cleaner')],
                // ),
                flex: 1,
              ),
          ],
          ),
          SizedBox(height: 15.0),
        Container(
            padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Color(0xffeff4f6),
          ),
          child: Column (
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                      flex: 1,
                      child: Align (
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Bid",
                          style: textTheme.bodyText1,
                        ),
                      ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Align (
                        alignment: Alignment.centerRight,
                        child: Text(
                          "£" + widget.quote.totalCost,
                          style: textTheme.bodyText1,
                          textAlign: TextAlign.right,
                        ),
                      ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
            Container (
              child: Text(
                widget.quote.details != null ? widget.quote.details : '[No message from the trader!]',
                style: textTheme.subtitle2,
              ),
            ),
        ],
          )
          ),
        ],
      ),
      //),
      //),
      ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/jobs.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../domain/entities/quote.dart';

class QuoteCard extends StatefulWidget {
  QuoteCard({
    Key key,
    @required this.quote,
  }) : super(key: key);

  final Quote quote;

  @override
  _QuoteCardState createState() => _QuoteCardState();
}

class _QuoteCardState extends State<QuoteCard> {

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: (){
        //if (widget.onPressedOpportunity != null)
        //  widget.onPressedOpportunity(widget.opportunityItem);
        AppRouter.pushPage(context, JobAwardScreen(quote: widget.quote,));
      },
      child:  Container(
        padding: EdgeInsets.only(top: 6.0, bottom: 6.0),
        margin: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadius.circular(5.0),
        ),
        //height: 197,
        child: Flex (
          direction: Axis.vertical,
          children: <Widget> [
            Row (
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                Expanded(
                    flex: 1,
                    child: Center (
                      child: Flex (
                        direction: Axis.vertical,
                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget> [
                          CircleAvatar(
                            //backgroundColor: Color.fromRGBO(255,166,0,1),
                            radius: 15,
                            child: SvgPicture.asset(
                              'packages/local_people_core/assets/images/package-orange.svg',
                            ),
                            // child: Center (
                            //    child: Image.asset(
                            //      'packages/local_people_core/assets/images/package-icon.png',
                            //      fit: BoxFit.contain,
                            //      height: 19,
                            //      width: 19,
                            //    )
                            // ),
                          ),
                          Text(
                            (widget.quote.job.minutesLeft / 60).toString() + ' hrs left',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color.fromRGBO(0, 63, 92, 1),
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'RedHatDisplay'
                            ),
                          ),
                        ],
                      ),
                    )
                ),
                Expanded(
                  flex: 3,
                  child: Text (
                    widget.quote.job.title != null ? widget.quote.job.title : widget.quote.job.description,
                    textAlign: TextAlign.left,
                    style: textTheme.bodyText1,
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Text (
                      widget.quote.job.budget,
                      textAlign: TextAlign.center,
                      style: textTheme.bodyText1,
                    )
                ),
              ],
            ),
            Flex (
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>  [
                Expanded (
                  child: Container(),
                  flex: 1,
                ),
                Expanded (
                  flex: 4,
                  child: Column (
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget> [
                        SizedBox(height: 5.0),
                        Text (
                          DateFormatUtil.getDateTimeDiff(DateTime.now(), widget.quote.job.date),
                          //DateFormat('dd MMMM yyyy').format(widget.quote.job.date) + ' | 1 Hour',
                          textAlign: TextAlign.left,
                          style: textTheme.subtitle2,
                        ),
                        SizedBox(height: 5.0),
                        TagsViewWidget (
                          tags: [], //widget.quote.job.tags,
                        )
                      ]
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

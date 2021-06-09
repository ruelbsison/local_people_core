import 'package:flutter/material.dart';
import '../../domain/entities/booking.dart';
import '../../domain/entities/package.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookPackageWidget extends StatefulWidget {
  final Package package;
  BookPackageWidget({
    @required this.package,
  });

  @override
  _BookPackageWidgetState createState() => _BookPackageWidgetState();
}

class _BookPackageWidgetState extends State<BookPackageWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      color: Color.fromRGBO(255, 255, 255, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Container(
                          child: Align(
                            child: Text('Book [Package Name]',
                                style: theme.textTheme.subtitle1),
                            alignment: Alignment.center,
                          ),
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Container(
                          child: Align(
                            child: Text('with [Trader Name]',
                                style: theme.textTheme.subtitle1),
                            alignment: Alignment.center,
                          ),
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Container(
                    child: Align(
                      child: Padding(
                        child: IconButton(
                          icon: SvgPicture.asset(
                            'packages/local_people_core/assets/images/minus.svg',
                            height: 24,
                            width: 24,
                          ),
                          iconSize: 24,
                          onPressed: () {},
                        ),
                        padding: EdgeInsets.only(
                          right: 12,
                        ),
                      ),
                      alignment: Alignment.centerRight,
                    ),
                  ),
                  flex: 1,
                ),
              ],
            ),
            flex: 1,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Row 1
                        Expanded(
                          child: Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Column 1
                                Expanded(
                                  child: Container(
                                    child: Padding(
                                      child: Text('Duration Required',
                                          style: theme.textTheme.bodyText1),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 0,
                                        horizontal: 12,
                                      ),
                                    ),
                                  ),
                                  flex: 1,
                                ),
                                // Column 2
                                Expanded(
                                  child: Container(
                                    child: Padding(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(),
                                          enabledBorder: OutlineInputBorder(),
                                        ),
                                      ),
                                      padding: EdgeInsets.only(
                                        right: 12,
                                      ),
                                    ),
                                  ),
                                  flex: 1,
                                ),
                                SizedBox(),
                              ],
                            ),
                          ),
                          flex: 1,
                        ),
                        // Row 2
                        Expanded(
                          child: Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Column 1
                                Expanded(
                                  child: Container(
                                    child: Padding(
                                      child: Text('Earliest Availability',
                                          style: theme.textTheme.bodyText1),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 0,
                                        horizontal: 12,
                                      ),
                                    ),
                                  ),
                                  flex: 1,
                                ),
                                // Column 2
                                Expanded(
                                  child: Container(
                                    child: Padding(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(),
                                          enabledBorder: OutlineInputBorder(),
                                        ),
                                      ),
                                      padding: EdgeInsets.only(
                                        right: 12,
                                      ),
                                    ),
                                  ),
                                  flex: 1,
                                ),
                              ],
                            ),
                          ),
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                  flex: 2,
                ),
                Expanded(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('SEE ALTERNATE TIME SLOTS',
                            style: theme.textTheme.subtitle1),
                      ],
                    ),
                  ),
                  flex: 1,
                ),
              ],
            ),
            flex: 6,
          ),
          Expanded(
            child: Container(
              child: Column(
                children: [
                  // Row 1
                  Expanded(
                    child: Container(
                      child: Row(
                        children: [
                          OutlineButton(
                            child: Text('SEND BOOKING REQUEST',
                                style: theme.textTheme.subtitle1),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                      ),
                    ),
                    flex: 1,
                  ),
                  // Row 2
                  Expanded(
                    child: Container(),
                    flex: 1,
                  ),
                ],
              ),
            ),
            flex: 4,
          ),
        ],
      ),
    );
  }
}

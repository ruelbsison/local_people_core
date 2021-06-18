import 'package:flutter/material.dart';
import 'custom_alert.dart';
import 'package:flutter_svg/flutter_svg.dart';

//class AppDialog extends StatefulWidget {
class AppDialog extends StatelessWidget {
  final Widget child;
  final String title;

  AppDialog({
    Key key,
    @required this.title,
    @required this.child,
  }) : super(key: key);

  double deviceWidth;
  double deviceHeight;
  double dialogHeight;

//   @override
//   _AppDialogState createState() => _AppDialogState();
// }
//
// class _AppDialogState extends State<AppDialog> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Container(
        child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card (
            elevation: 0,
            //color: Color.fromRGBO(239, 244, 246, 1),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title,
                        textAlign: TextAlign.left,
                        style: theme.textTheme.subtitle1,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    //color: Color.fromRGBO(239, 244, 246, 1),
                    //padding: EdgeInsets.only(right: 10),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        padding: EdgeInsets.all(2.0),
                        icon: SvgPicture.asset(
                          'packages/local_people_core/assets/images/minus.svg',
                          height: 24,
                          width: 24,
                        ),
                        iconSize: 24,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Card (
            elevation: 0,
            margin: EdgeInsets.all(0.0),
            child: child,
          ),
        ],
        ),
    );
  }
}

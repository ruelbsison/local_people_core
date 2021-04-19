import 'package:flutter/material.dart';
import 'package:local_people_core/core.dart';

class PostActionsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(12.0),
      //margin: EdgeInsets.all(12.0),
      child: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            color: Colors.white,
              child: Flex(
                  direction: Axis.horizontal,
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 7,
                      child: Text(
                        LocalPeopleLocalizations.of(context).menuTitlePostJob,
                        textAlign: TextAlign.left,
                        style: theme.textTheme.bodyText1,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        LocalPeopleLocalizations.of(context).titleDeleteJob,
                        textAlign: TextAlign.left,
                        style: theme.textTheme.subtitle2,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: CircleAvatar(
                        backgroundColor: Color(0xbbd0d9),
                        radius: 16,
                        child: Center (
                          child: Image.asset(
                            'packages/local_people_core/assets/images/delete-job-icon.png',
                            fit: BoxFit.contain,
                            height: 25,
                            width: 25,
                          )
                      ),
                    ),
                    ),
                  ]
              ),
          ),
          SizedBox(height: 30.0),
          Container(
              color: Colors.white,
              child: Flex(
                direction: Axis.horizontal,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding:
                      EdgeInsets.only(left: 12.0, right: 12.0),
                      child: ElevatedButton(
                        onPressed: () {_saveJob(context);},
                        child: Text(
                            LocalPeopleLocalizations.of(context)
                                .btnTitleSave),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding:
                      EdgeInsets.only(left: 12.0, right: 12.0),
                      child: ElevatedButton(
                        onPressed: () {_postJob(context);},
                        child: Text(
                            LocalPeopleLocalizations.of(context)
                                .btnTitlePost),
                      ),
                    ),
                  ),
                ],
              )),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }

  void _saveJob(BuildContext context) {
    Navigator.of(context).popUntil(ModalRoute.withName('/'));
  }

  void _postJob(BuildContext context) {
    Navigator.of(context).popUntil(ModalRoute.withName('/'));
  }
}
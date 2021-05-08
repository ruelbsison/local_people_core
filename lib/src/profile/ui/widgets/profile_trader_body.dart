import 'package:flutter/material.dart';
//import '../../domain/entities/profile.dart';
import '../../domain/entities/trader_profile.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProfileTraderBody extends StatefulWidget {
  ProfileTraderBody({@required this.profile});

  @override
  _ProfileTraderBodyState createState() => _ProfileTraderBodyState();

  final TraderProfile profile;
}

class _ProfileTraderBodyState extends State<ProfileTraderBody> {
  @override
  Widget build(BuildContext context) {
    final bottomContentText = Text(
      widget.profile.intro,
      style: TextStyle(fontSize: 18.0),
    );
    final readButton = Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          onPressed: () => {},
          color: Color.fromRGBO(58, 66, 86, 1.0),
          child:
          Text("TAKE THIS LESSON", style: TextStyle(color: Colors.white)),
        ));
    Widget bodyContent = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[bottomContentText, readButton],
        ),
      ),
    );

    return bodyContent;
  }

}
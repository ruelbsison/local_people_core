import 'dart:async';
import 'package:flutter/material.dart';
import '../../domain/entities/client_profile.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const CameraPosition _kInitialPosition =
CameraPosition(target: LatLng(-33.852, 151.211), zoom: 11.0);

class ProfileClientBody extends StatefulWidget {
  ProfileClientBody({@required this.profile});

  @override
  _ProfileClientBodyState createState() => _ProfileClientBodyState();

  final ClientProfile profile;
}

class _ProfileClientBodyState extends State<ProfileClientBody> {
  Completer<GoogleMapController> mapController = Completer();

  //GoogleMapController mapController;
  // LatLngBounds _visibleRegion = LatLngBounds(
  //   southwest: const LatLng(0, 0),
  //   northeast: const LatLng(0, 0),
  // );
  
  // static final CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(37.42796133580664, -122.085749655962),
  //   zoom: 14.4746,
  // );
  //
  // static final CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _googleMapController.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }

  /*Future<void> showVisibleBounds() async {
    if (mapController == null) return;
    final LatLngBounds visibleRegion =
    await mapController.getVisibleRegion();
    setState(() {
      _visibleRegion = visibleRegion;
    });
  }*/

  void onMapCreated(GoogleMapController controller) {
    // setState(() {
    //   mapController = controller;
    // });
    mapController.complete(controller);
    /*final LatLngBounds visibleRegion = await controller.getVisibleRegion();
    setState(() {
      //mapController = controller;
      _visibleRegion = visibleRegion;
      mapController.complete(controller);
    });*/
  }

  /*Widget _getVisibleRegionButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        child: const Text('Get Visible Region Bounds'),
        onPressed: () async {
          if (mapController == null) return;
          final LatLngBounds visibleRegion =
          await mapController.getVisibleRegion();
          setState(() {
            _visibleRegion = visibleRegion;
          });
        },
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    GoogleMap googleMap = GoogleMap(
      onMapCreated: onMapCreated,
      mapType: MapType.hybrid,
      initialCameraPosition: _kInitialPosition,
      compassEnabled: false,
      mapToolbarEnabled: false,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      //indoorViewEnabled: true,
    );

    final List<Widget> columnChildren = <Widget>[
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: SizedBox(
            width: 300.0,
            height: 200.0,
            child: googleMap,
          ),
        ),
      ),
    ];

    //if (mapController != null) {
      //final String currentVisibleRegion = 'VisibleRegion:'
      //    '\nnortheast: ${_visibleRegion.northeast},'
      //    '\nsouthwest: ${_visibleRegion.southwest}';
      columnChildren.add(
        Center(
          child: Text(
            'Client Name goes here',
            style: theme.textTheme.headline6,
          ),
        ),
      );
      //columnChildren.add(_getVisibleRegionButton());
    //}

    final indentidyContent = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: columnChildren,
    );

    /*final indentidyContent = Container(
        color: Colors.white,
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
        Container(
          width: size.width,
          height: 220,
          child: GoogleMap (
            initialCameraPosition: _kGooglePlex,
            //initialCameraPosition: CameraPosition(target: _center, zoom: 11.0),
            //liteModeEnabled: true,
            mapType: MapType.hybrid,
            onMapCreated: (GoogleMapController controller) {
              _googleMapController.complete(controller);
              _goToTheLake();
            },
          ),
        ),
      ],
    ),
    );*/

    final introductionActions = Container(
      color: Colors.white,
      padding: EdgeInsets.all(12.0),
      //margin: EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget> [
          Expanded(
            flex: 5,
            child: Text(
              'Introduction',
              textAlign: TextAlign.left,
              style: theme.textTheme.subtitle1,
            ),
          ),
          Expanded(
            flex: 1,
            child: Icon(
              MaterialIcons.edit,
            ),
          ),
          Expanded(
            flex: 1,
            child: Icon(
              MaterialIcons.clear_all,
            ),
          ),
        ],
      ),
    );

    final introduction = Container(
      color: Colors.white,
      padding: EdgeInsets.all(12.0),
      //margin: EdgeInsets.all(12.0),
      child: Text(
        'This text is very very very very very very very very very very very very very very very very very very very very very very very very very long',
        maxLines: 12,
        overflow: TextOverflow.ellipsis,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.left,
        style: theme.textTheme.bodyText1,
      ),
    );

    final aboutTheClient = Container(
      color: Colors.white,
      padding: EdgeInsets.all(12.0),
      //margin: EdgeInsets.all(12.0),
      child: Flex (
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'About The Client',
            textAlign: TextAlign.left,
            style: theme.textTheme.subtitle1,
          ),
          SizedBox(height: 10.0),
          Opacity (
            opacity: 0.64,
            child: Text(
              'Member since DD-MM-YYYY',
              textAlign: TextAlign.left,
              style: theme.textTheme.bodyText1,
            ),
          ),
          Flex (
            direction: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Expanded (
                  flex: 3,
                  child: Flex (
                    direction: Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget> [
                      SizedBox(height: 20.0),
                      Container(
                        height: 1.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(
                              color: Color.fromRGBO(186, 207, 216, 1),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Flex (
                        direction: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget> [
                          Expanded(
                            flex: 1,
                            child: CircleAvatar(
                              //backgroundColor: Color(0xff0075ff),
                              radius: 12,
                              child: Center (
                                  child: Image.asset(
                                    'packages/local_people_core/assets/images/verified-icon.png',
                                    fit: BoxFit.contain,
                                    height: 22,
                                    width: 22,
                                  )
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 6,
                              child: Text(
                                'Payment Method Verified',
                                textAlign: TextAlign.left,
                                style: theme.textTheme.subtitle1,
                              ),
                          )
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Flex (
                        direction: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget> [
                          Expanded(
                            flex: 1,
                            child: CircleAvatar(
                              //backgroundColor: Color(0xff0075ff),
                              radius: 12,
                              child: Center (
                                  child: Image.asset(
                                    'packages/local_people_core/assets/images/verified-icon.png',
                                    fit: BoxFit.contain,
                                    height: 23,
                                    width: 23,
                                  )
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 6,
                              child: Flex (
                                direction: Axis.vertical,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget> [
                                  Text(
                                    'XX Jobs Posted',
                                    textAlign: TextAlign.left,
                                    style: theme.textTheme.subtitle1,
                                  ),
                                  Opacity (
                                    opacity: 0.84,
                                    child: Text(
                                      '5 jobs commissioned',
                                      textAlign: TextAlign.left,
                                      style: theme.textTheme.bodyText2,
                                    ),
                                  )
                                ],
                              )
                          )
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Flex (
                        direction: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget> [
                          Expanded(
                            flex: 1,
                            child: CircleAvatar(
                              //backgroundColor: Color(0xff0075ff),
                              radius: 12,
                              child: Center (
                                  child: Image.asset(
                                    'packages/local_people_core/assets/images/verified-icon.png',
                                    fit: BoxFit.contain,
                                    height: 23,
                                    width: 23,
                                  )
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 6,
                              child: Flex (
                                direction: Axis.vertical,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget> [
                                  Text(
                                    'XX Jobs Posted',
                                    textAlign: TextAlign.left,
                                    style: theme.textTheme.subtitle1,
                                  ),
                                  Opacity (
                                    opacity: 0.84,
                                    child: Text(
                                      '5 Traders hired, 1 job in progress',
                                      textAlign: TextAlign.left,
                                      style: theme.textTheme.bodyText2,
                                    ),
                                  )
                                ],
                              )
                          )
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Flex (
                        direction: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget> [
                          Expanded(
                            flex: 1,
                            child: CircleAvatar(
                              //backgroundColor: Color(0xff0075ff),
                              radius: 12,
                              child: Center (
                                  child: Image.asset(
                                    'packages/local_people_core/assets/images/verified-icon.png',
                                    fit: BoxFit.contain,
                                    height: 23,
                                    width: 23,
                                  )
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 6,
                              child: Flex (
                                direction: Axis.vertical,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget> [
                                  Text(
                                    "\$" + 'XXX Spent',
                                    textAlign: TextAlign.left,
                                    style: theme.textTheme.subtitle1,
                                  ),
                                  Opacity (
                                    opacity: 0.84,
                                    child: Text(
                                      'No disputes',
                                      textAlign: TextAlign.left,
                                      style: theme.textTheme.bodyText2,
                                    ),
                                  )
                                ],
                              )
                          ),
                        ],
                      ),
                    ],
                  ),
              ),
            ],
          ),
        ],
      ),
    );

    Widget bodyContent = SingleChildScrollView(
        physics: BouncingScrollPhysics(),
          child: Container(
            margin: EdgeInsets.all(12.0),
            //height: double.infinity,
            child: Flex (
              direction: Axis.vertical,
              //mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[indentidyContent, introductionActions, introduction, aboutTheClient],
            ),
          ),
      );

    return bodyContent;
  }
  
}
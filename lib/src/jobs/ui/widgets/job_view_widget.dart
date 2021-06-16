import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:local_people_core/core.dart';
import '../widgets/tags_view_widget.dart';
import '../widgets/images_view_widget.dart';
import '../../domain/entities/job.dart';
//import 'dart:typed_data';
//import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import '../blocs/tag_bloc.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_place/google_place.dart';
//import 'package:after_layout/after_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/location_bloc.dart';
import '../blocs/tag_bloc.dart';

class JobViewWidget extends StatefulWidget {
  JobViewWidget({
    Key key,
    @required this.job,
  }) : super(key: key);

  final Job job;



  @override
  _JobViewWidgetState createState() =>
      _JobViewWidgetState();
}

class _JobViewWidgetState extends State<JobViewWidget> {
  //Completer<GoogleMapController> _googleMapController = Completer();
  GoogleMapController _googleMapController;
  final Set<Marker> _markers = new Set();
  GooglePlace googlePlace;
  List<SearchResult> googlePlaceSearchResults = [];

  LatLng _locLatLng = LatLng(45.521563, -122.677433);
  CameraPosition _cameraPosition;

  @override
  void initState() {
    super.initState();

    String apiKey =
        'AIzaSyDas3RPqegAcudGgkX4xlykHztH1nZCfvo'; //DotEnv().env['API_KEY'];
    googlePlace = GooglePlace(apiKey);

    _cameraPosition = CameraPosition(target: _locLatLng, zoom: 11.0);
  }

  void googlePlaceTextSearch(String query) async {
    print('query: ' + query);
    try {
      TextSearchResponse response = await googlePlace.search.getTextSearch(query);
      if (response != null && response.results != null && mounted) {
          if (response.results.length > 0) {
            SearchResult result = response.results.first;
            print('result.geometry.location.lat: ' + result.geometry.location.lat.toString() + ' result.geometry.location.lng: ' + result.geometry.location.lng.toString());
            setState(() {
             _locLatLng = LatLng(result.geometry.location.lat, result.geometry.location.lng);
             myMarker();
             //_cameraPosition = CameraPosition(target: LatLng(result.geometry.location.lat, result.geometry.location.lng), zoom: 11.0);
           });
          }
      }
    } catch (error) {
      print(error.toString());
    }
  }

  void onMapCreated(GoogleMapController controller) {
    setState(() {
      _googleMapController = controller;
    });
    
    
  }

  Set<Marker> myMarker() {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_locLatLng.toString()),
        position: _locLatLng,
        infoWindow: InfoWindow(
          title: 'Historical City',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });

    return _markers;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Container(
      //color: Colors.white,
      padding: EdgeInsets.all(12.0),
      //margin: EdgeInsets.all(12.0),
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            LocalPeopleLocalizations.of(context).titleJobInfo,
            style: theme.textTheme.subtitle1,
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 5.0),
          Text(
            widget.job.preview,
            style: theme.textTheme.bodyText2,
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 20.0),
          Text(
            LocalPeopleLocalizations.of(context).titleDate + ' ' + DateFormat('EEE, MMM dd, yyyy').format(widget.job.date),
            textAlign: TextAlign.center,
            style: theme.textTheme.subtitle1,
          ),
          SizedBox(height: 20.0),
          Text(
            LocalPeopleLocalizations.of(context).titleTime + ' '  + DateFormat('HH::mm').format(widget.job.date),
            textAlign: TextAlign.center,
            style: theme.textTheme.subtitle1,
          ),
          SizedBox(height: 20.0),
          Text(
            LocalPeopleLocalizations.of(context).titleBudget + ' ' + widget.job.budget,
            textAlign: TextAlign.center,
            style: theme.textTheme.subtitle1,
          ),
          SizedBox(height: 5.0),
          TagsViewWidget(
          tags: widget.job.tags != null ? widget.job.tags : [],
          ),
          // BlocProvider.value(
          //   value: BlocProvider.of<TagBloc>(context)..add(LoadJobTagsEvent(jobId: widget.job.id)),
          //   child: BlocBuilder<TagBloc, TagState>(
          //       builder: (context, state) {
          //         // return widget here based on BlocA's state
          //         if (state is JobTagsLoaded) {
          //           widget.job.tags = state.tags;
          //           return TagsViewWidget(
          //             tags: state.tags != null ? state.tags : [],
          //           );
          //         } else if (state is LoadJobTagsFailed) {
          //           return TagsViewWidget(
          //             tags: [],
          //           );
          //         } else if (state is JobTagsLoading) {
          //           return LoadingWidget();
          //         }
          //         return LoadingWidget();
          //       }
          //   ),
          // ),
          SizedBox(height: 20.0),
          Container(
            height: 130.0,
            alignment: Alignment.centerLeft,
            child: ImagesViewWidget(images: widget.job.images, maxTagViewHeight: double.infinity,),
          ),
          SizedBox(height: 20.0),
          Text(
            LocalPeopleLocalizations.of(context).titleLocation,
            textAlign: TextAlign.center,
            style: theme.textTheme.subtitle1,
          ),
          Container(
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
                    initialCameraPosition: _cameraPosition,
                    onMapCreated: onMapCreated,
                    mapType: MapType.normal,
                    markers: _markers,
                    compassEnabled: false,
                    mapToolbarEnabled: false,
                    myLocationEnabled: true,
                    zoomControlsEnabled: false,
                    //indoorViewEnabled: true,
                  ),
                ),
                Text(
                  (widget.job.location != null && widget.job.location.name != null) ? widget.job.location.name : '',
                  textAlign: TextAlign.left,
                  style: theme.textTheme.bodyText1,
                ),
                Text(
                  (widget.job.location != null && widget.job.location.address != null) ? widget.job.location.address : '',
                  textAlign: TextAlign.left,
                  style: theme.textTheme.bodyText2,
                ),
                SizedBox(height: 60.0),
              ],
            ),
          ),
        //   BlocProvider.value(
        //   value: BlocProvider.of<LocationBloc>(context)..add(GetLocationEvent(id: widget.job.location.id)),
        //   child: BlocBuilder<LocationBloc, LocationState>(
        //       builder: (context, state) {
        //         // return widget here based on BlocA's state
        //         if (state is GetLocationLoaded) {
        //           widget.job.location = state.location;
        //           return buildMap();
        //         } else if (state is GetLocationFailed) {
        //           return buildMap();
        //         } else if (state is GetLocationLoading) {
        //           return LoadingWidget();
        //         }
        //         return LoadingWidget();
        //       }
        //   ),
        // ),
        ],
      ),
    );
  }

  // Widget buildMap() {
  //   final theme = Theme.of(context);
  //   final size = MediaQuery.of(context).size;
  //   return Container(
  //     color: Colors.white,
  //     child: Flex(
  //       direction: Axis.vertical,
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         Container(
  //           width: size.width,
  //           height: 220,
  //           child: GoogleMap (
  //             initialCameraPosition: _cameraPosition, //CameraPosition(target: widget._locLatLng, zoom: 11.0), //LatLng(widget.job.location.lat, widget.job.location.long), zoom: 11.0),
  //             onMapCreated: onMapCreated,
  //             mapType: MapType.normal,
  //             markers: _markers,
  //             compassEnabled: false,
  //             mapToolbarEnabled: false,
  //             myLocationEnabled: true,
  //             zoomControlsEnabled: false,
  //             //indoorViewEnabled: true,
  //           ),
  //           //margin: 8.0,
  //           //child: Image.network(widget.job.location.photoUrl, fit: BoxFit.cover)
  //           /*child: InAppWebView(
  //                     initialUrlRequest: URLRequest(url: Uri.parse(widget.job.location.photoUrl)),
  //                     initialOptions: InAppWebViewGroupOptions(
  //                         crossPlatform: InAppWebViewOptions(
  //                           useShouldOverrideUrlLoading: true,
  //                         ),
  //                         android: AndroidInAppWebViewOptions(
  //                           //useHybridComposition: true
  //                         )),
  //                     androidOnGeolocationPermissionsShowPrompt:
  //                         (InAppWebViewController controller, String origin) async {
  //                       bool result = await showDialog<bool>(
  //                         context: context,
  //                         barrierDismissible: false, // user must tap button!
  //                         builder: (BuildContext context) {
  //                           return AlertDialog(
  //                             title: Text('Allow access location $origin'),
  //                             content: SingleChildScrollView(
  //                               child: ListBody(
  //                                 children: <Widget>[
  //                                   Text('Allow access location $origin'),
  //                                 ],
  //                               ),
  //                             ),
  //                             actions: <Widget>[
  //                               TextButton(
  //                                 child: Text('Allow'),
  //                                 onPressed: () {
  //                                   Navigator.of(context).pop(true);
  //                                 },
  //                               ),
  //                               TextButton(
  //                                 child: Text('Denied'),
  //                                 onPressed: () {
  //                                   Navigator.of(context).pop(false);
  //                                 },
  //                               ),
  //                             ],
  //                           );
  //                         },
  //                       );
  //                       if (result) {
  //                         return Future.value(GeolocationPermissionShowPromptResponse(
  //                             origin: origin, allow: true, retain: true));
  //                       } else {
  //                         return Future.value(GeolocationPermissionShowPromptResponse(
  //                             origin: origin, allow: false, retain: false));
  //                       }
  //                     },
  //                     onWebViewCreated: (InAppWebViewController controller) {
  //                       _webViewController = controller;
  //                     },
  //                     onLoadStart: (InAppWebViewController controller, String url) {
  //                       setState(() {
  //                         this.url = url;
  //                       });
  //                     },
  //                     onLoadStop: (InAppWebViewController controller, String url) async {
  //                       setState(() {
  //                         this.url = url;
  //                       });
  //                     },
  //                     onProgressChanged: (InAppWebViewController controller, int progress) {
  //                       setState(() {
  //                         this.progress = progress / 100;
  //                       });
  //                     },
  //                   ),*/
  //         ),
  //         Text(
  //           (widget.job.location != null && widget.job.location.name != null) ? widget.job.location.name : '',
  //           textAlign: TextAlign.left,
  //           style: theme.textTheme.bodyText1,
  //         ),
  //         Text(
  //           (widget.job.location != null && widget.job.location.address != null) ? widget.job.location.address : '',
  //           textAlign: TextAlign.left,
  //           style: theme.textTheme.bodyText2,
  //         ),
  //         SizedBox(height: 60.0),
  //       ],
  //     ),
  //   );
  // }

}
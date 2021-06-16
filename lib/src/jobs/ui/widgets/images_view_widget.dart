import 'dart:io';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';

class ImagesViewWidget extends StatefulWidget {
  List<String> images;
  double maxTagViewHeight;
  double minTagViewHeight;
  Color tagBackgroundColor;

  static final uuid = Uuid();
  //final String imgTag = uuid.v4();

  ImagesViewWidget(
      {@required this.images,
      this.minTagViewHeight = 870,
      this.maxTagViewHeight = 70,
      this.tagBackgroundColor});
      // : assert(
      //       images != null,
      //       'Images can\'t be empty\n'
      //       'Provide the list of images');

  @override
  _ImagesViewWidgetState createState() => _ImagesViewWidgetState();
}

class _ImagesViewWidgetState extends State<ImagesViewWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      primary: false,
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            Card(
              color: Color.fromRGBO(196, 196, 196, 1.0),
              child: InkWell(
                  child: createImage(widget.images[index]),
                  onTap: () {
                    // TODO 15: Call Add To Cart
                  }),
              //padding: EdgeInsets.all(10.0),
            ),
          ],
        );
      },
      itemCount: widget.images == null ? 0 : widget.images.length,
    );
  }

  Widget createImage(dynamic imgUrl) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: widget.minTagViewHeight,
        maxHeight: widget.maxTagViewHeight,
      ),
      child: Hero(
        tag: ImagesViewWidget.uuid.v4(),
        child: kIsWeb
            ? Image.memory(imgUrl as Uint8List, fit: BoxFit.cover)
            : imgUrl is String
                ? Image.file(File(imgUrl), fit: BoxFit.cover)
                : Image.network(imgUrl, fit: BoxFit.cover),
      ),
    );

    /*
    CachedNetworkImage(
        imageUrl: imgUrl,
        placeholder: (context, url) => LoadingWidget(
          isImage: true,
        ),
        errorWidget: (context, url, error) => Image.asset(
          'packages/local_people_core/assets/images/local-people-logo.png',
          fit: BoxFit.cover,
        ),
        fit: BoxFit.cover,
      ),
     */
  }

}

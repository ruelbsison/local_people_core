import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:local_people_core/core.dart';
//import 'package:image_picker/image_picker.dart';

class ImagesViewWidget extends StatefulWidget {
  List<String> images;
  double maxTagViewHeight;
  double  minTagViewHeight;
  Color tagBackgroundColor;

  static final uuid = Uuid();
  //final String imgTag = uuid.v4();

  ImagesViewWidget(
      {@required this.images,
        this.minTagViewHeight = 0,
        this.maxTagViewHeight = 80,
        this.tagBackgroundColor})
      : assert(images != null,
  'Tags can\'t be empty\n'
      'Provide the list of tags');

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
            Padding(
              child: InkWell(
                  child: createImage(widget.images[index]),
                  onTap: () {
                    // TODO 15: Call Add To Cart
                  }
              ),
              padding: EdgeInsets.all(10.0),
            ),
          ],
        );
      },
      itemCount: widget.images.length,
    );
  }

  Widget createImage(String imgUrl) {
    return ConstrainedBox(
      constraints:BoxConstraints(
        minHeight: widget.minTagViewHeight,
        maxHeight: widget.maxTagViewHeight,
      ),
      child: Hero(
      tag: ImagesViewWidget.uuid.v4(),
      child: CachedNetworkImage(
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
    ),
    );
  }

  _imgFromCamera() async {
    /*File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    );

    setState(() {
      _image = image;
    });*/
  }

  _imgFromGallery() async {
    /*File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      _image = image;
    });*/
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  /*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 32,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                _showPicker(context);
              },
              child: CircleAvatar(
                radius: 55,
                backgroundColor: Color(0xffFDCF09),
                child: _image != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.file(
                    _image,
                    width: 100,
                    height: 100,
                    fit: BoxFit.fitHeight,
                  ),
                )
                    : Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(50)),
                  width: 100,
                  height: 100,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }*/
}
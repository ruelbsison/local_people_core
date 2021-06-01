import 'dart:io';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import '../../domain/entities/package.dart';
import 'package_card.dart';
import 'package:flutter_tags/flutter_tags.dart';

class PackageWidget extends StatefulWidget {
  List<Package> packages;


  static final uuid = Uuid();
  //final String imgTag = uuid.v4();

  PackageWidget(
      {@required this.packages,
    });

  @override
  _PackageWidgetState createState() => _PackageWidgetState();
}

class _PackageWidgetState extends State<PackageWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: Color(0xfff5f5f5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container (
            padding: EdgeInsets.only(left: 12.0),
            child: Text(
            "Packages",
            style: theme.textTheme.bodyText1,
          ),
          ),
          ListView.builder(
            primary: false,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                child: createImage(widget.packages[index]),
                onTap: () {
                  // TODO 15: Call Add To Cart
                }
              );
            },
            itemCount: widget.packages == null ? 0 : widget.packages.length,
          ),
        ],
      ),
    );
  }

  Widget createImage(Package package) {
    return PackageCard(
        package: package,
        isAdd: package.description == null ? true : false,
      );
  }

  // ItemTags _buildTagItem(tags, index) {
  //   final item = tags[index];
  //
  //   return ItemTags(
  //     key: Key(index.toString()),
  //     index: index,
  //     elevation: 0,
  //     border: Border.all(
  //       width: 0,
  //       color: Colors.white,
  //     ),
  //     title: item,
  //     active: _selectedTags.contains(item),
  //     textColor: Colors.grey,
  //     textActiveColor: Colors.white,
  //     customData: item,
  //     color: Colors.white,
  //     activeColor: Colors.purple,
  //     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  //     textStyle: TextStyle(
  //       fontSize: 12,
  //     ),
  //     pressEnabled: true,
  //     onPressed: (_item) {
  //       setState(() {
  //         if (_item.active) {
  //           _selectedTags.add(_item.customData);
  //         } else {
  //           _selectedTags.remove(_item.customData);
  //         }
  //       });
  //     },
  //   );
  // }

}

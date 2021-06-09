import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:local_people_core/jobs.dart';
import 'package_card.dart';

class PackageWidget extends StatefulWidget {
  List<Package> packages;
  PackageWidget({@required this.packages,});

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
            style: theme.textTheme.subtitle1,
          ),
          ),
          ListView.builder(
            primary: false,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                child: createPackage(widget.packages[index]),
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

  Widget createPackage(Package package) {
    return PackageCard(
      package: package,
    );
  }

}

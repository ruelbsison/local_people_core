import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/date_format.dart';
import 'loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';

class LocalPeopleAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor = Colors.white;
  final String title;
  final DateTime startrDateTime;
  final AppBar appBar;
  final List<Widget> actions;
  final PreferredSizeWidget bottom;
  final Size appBarPreferredSize;
  final String packageSvgAssetIcon;
  final String networkIcon;
  Widget image;
  Widget leading;
  String leadingText;
  /// you can add more fields that meet your needs

  LocalPeopleAppBarWidget({Key key,
    this.title, this.appBar, this.actions,
    this.startrDateTime, this.bottom,
    this.appBarPreferredSize = const Size.fromHeight(180.0),
    this.networkIcon,
    this.leading = null,
  this.packageSvgAssetIcon = 'packages/local_people_core/assets/images/package-orange.svg',
  this.leadingText = null})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    if (networkIcon != null) {
      image = CachedNetworkImage(
        imageUrl: networkIcon,
        height: 37,
        width: 37,
        placeholder: (context, url) => LoadingWidget(
          isImage: true,
        ),
        errorWidget: (context, url, error) => Image.asset(
          'packages/local_people_core/assets/images/trader-profile-photo.png',
          fit: BoxFit.cover,
          height: 37,
          width: 37,
        ),
        fit: BoxFit.cover,
      );
    } else {
      image = SvgPicture.asset(
        packageSvgAssetIcon,
        fit: BoxFit.contain,
        height: 37,
        width: 37,
      );
    }
    return PreferredSize(
      preferredSize: appBarPreferredSize,
      child: AppBar(
        leading: buildLeading(context),
        titleSpacing: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        flexibleSpace: PreferredSize(
          preferredSize: Size(size.width, appBarPreferredSize.height),
          child: Flex(
            direction: Axis.horizontal,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flex(
                direction: Axis.vertical,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child:  ClipOval(
                      child: image,
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text(
                        (startrDateTime != null ? DateFormatUtil.getDateTimeDiff(DateTime.now(), startrDateTime) : ''),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.overline.copyWith(fontSize: 9),
                    ),
                  ),
                ],
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      title != null
                          ? title
                          : '',
                      style: theme.textTheme.headline6,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        elevation: 0.0,
        actions: actions,
        bottom: bottom,
      ),
    );
  }

  Widget buildLeading(BuildContext context) {
    if (leadingText == null)
      return leading;

    final theme = Theme.of(context);
    return Column (
      //direction: Axis.vertical,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        //SizedBox(width: 20),
        // Text(
        //   leadingText,
        //   style: theme.textTheme.overline,
        //   textAlign: TextAlign.right,
        // ),
      ],
    );
  }

  @override
  Size get preferredSize => appBarPreferredSize;
}

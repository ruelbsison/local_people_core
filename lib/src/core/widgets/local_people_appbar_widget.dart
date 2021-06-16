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
  /// you can add more fields that meet your needs

  LocalPeopleAppBarWidget({Key key,
    this.title, this.appBar, this.actions,
    this.startrDateTime, this.bottom,
    this.appBarPreferredSize = const Size.fromHeight(180.0),
    this.networkIcon,
  this.packageSvgAssetIcon = 'packages/local_people_core/assets/images/package-orange.svg',})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    if (networkIcon != null) {
      image = CachedNetworkImage(
        imageUrl: networkIcon,
        width: 60,
        height: 60,
        placeholder: (context, url) => LoadingWidget(
          isImage: true,
        ),
        errorWidget: (context, url, error) => Image.asset(
          'packages/local_people_core/assets/images/trader-profile-photo.png',
          fit: BoxFit.cover,
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
        titleSpacing: 0,
        centerTitle: false,
        //automaticallyImplyLeading: false,
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
                      style: theme.textTheme.overline,
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

  @override
  Size get preferredSize => appBarPreferredSize;
}

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:local_people_core/jobs.dart';
import 'package_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_people_core/core.dart';

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
                onTap: () {}
              );
            },
            itemCount: widget.packages == null ? 0 : widget.packages.length,
          ),
        ],
      ),
    );
  }

  Widget createPackage(Package package) {
    if (package.entityStatus == EntityStatus.ENTIRY_STATUS_CREATING) {
      BlocProvider.of<PackageBloc>(context)
          .add(PackageAddEvent(package: package));
      return BlocBuilder<PackageBloc, PackageState>(
        bloc: BlocProvider.of<PackageBloc>(context),
        builder: (BuildContext context, PackageState state) {
          if (state is PackageAdded) {
            package.entityStatus = EntityStatus.ENTIRY_STATUS_COMPLETED;
            return createPackageCard(state.package);
          } else if (state is PackageAddFailed) {
            package.entityStatus = EntityStatus.ENTIRY_STATUS_ERROR;
            return Text('Error: $state');
          } else {
            return LoadingWidget();
          }
        },
      );
    } else if (package.entityStatus == EntityStatus.ENTIRY_STATUS_REMOVING) {
      BlocProvider.of<PackageBloc>(context)
          .add(PackageDeleteEvent(id: package.id));
      return BlocConsumer<PackageBloc, PackageState>(
          bloc: BlocProvider.of<PackageBloc>(context),
          listenWhen: (previous, current) {
            // return true/false to determine whether or not
            // to invoke listener with state
            if (previous is PackageDeleting && current is PackageDeleted)
              return true;

            return false;
          },
          listener: (context, state) {
            // do stuff here based on BlocA's state
            if (state is PackageDeleted) {
              int start = widget.packages.indexOf(state.package);
              widget.packages.removeAt(start);
            }
          },
          buildWhen: (previous, current) {
            // return true/false to determine whether or not
            // to rebuild the widget with state
            if (previous is PackageInitial && current is PackageDeleting)
              return true;

            return false;
          },
          builder: (context, state) {
            // return widget here based on BlocA's state
            return LoadingWidget();
          });
    } else {
      return createPackageCard(package);
    }
  }

  Widget createPackageCard(Package package) {
    return PackageCard(
      package: package,
      onPackageCallback: (packageCallbackType, package) async {
        if (package == null) return;
        if (packageCallbackType == PackageCallbackType.ON_PACKAGE_REMOVE) {
          int start = widget.packages.indexOf(package);
          package.entityStatus = EntityStatus.ENTIRY_STATUS_REMOVING;
          widget.packages.removeAt(start);
          widget.packages.insert(start, package);
        } else if (packageCallbackType == PackageCallbackType.ON_PACKAGE_CREATE) {
          DialogService _dialogService = sl<DialogService>();
          PackageCreateResponse response =
          await _dialogService.showCreatePackageDialog(
              traderId: package.traderId,
              packageName: package.name
          );
          if (response != null && response.package != null) {
            int start = widget.packages.indexOf(package);
            widget.packages.removeAt(start);

            response.package.entityStatus = EntityStatus.ENTIRY_STATUS_CREATING;
            widget.packages.insert(start, response.package);
          }
        } else {
          print('Unhandled $packageCallbackType');
        }
      },
    );
  }

}

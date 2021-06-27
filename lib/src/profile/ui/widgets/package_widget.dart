import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:local_people_core/jobs.dart';
import 'package_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_people_core/core.dart';

typedef OnPackageAdded = void Function(Package);
typedef OnPackageRemoved = void Function(Package);

class PackageWidget extends StatefulWidget {
  List<Package> packages;
  final String traderName;
  PackageWidget({
    @required this.packages,
    @required this.traderName,
    @required this.onPackageAdded = null,
    @required this.onPackageRemoved = null,
  });

  OnPackageAdded onPackageAdded;
  OnPackageRemoved onPackageRemoved;
  @override
  _PackageWidgetState createState() => _PackageWidgetState();
}

class _PackageWidgetState extends State<PackageWidget> {
  DialogService _dialogService = sl<DialogService>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
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
                  child: Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: createPackage(widget.packages[index])),
                  onTap: () {});
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
            state.package.entityStatus = EntityStatus.ENTIRY_STATUS_COMPLETED;
            int length = widget.packages.length + 1;
            Package package = Package(
              id: -1,
              name: 'Package ' + length.toString(),
              optionType: PackageOptionType.ADD_NEW,
              traderId: state.package.traderId,
            );
            // setState(() {
            //   widget.packages.add(package);
            // });
            if (widget.onPackageAdded != null) {
              widget.onPackageAdded(state.package);
            }
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
      return BlocBuilder<PackageBloc, PackageState>(
        bloc: BlocProvider.of<PackageBloc>(context),
        builder: (BuildContext context, PackageState state) {
          if (state is PackageDeleted) {
            state.package.entityStatus = EntityStatus.ENTIRY_STATUS_COMPLETED;
            int length = widget.packages.length + 1;
            Package package = Package(
              id: -1,
              name: 'Package ' + length.toString(),
              optionType: PackageOptionType.ADD_NEW,
              traderId: state.package.traderId,
            );
            setState(() {
              widget.packages.add(package);
            });
            if (widget.onPackageRemoved != null) {
              widget.onPackageRemoved(state.package);
            }
            return createPackageCard(state.package);
          } else if (state is PackageDeleteFailed) {
            package.entityStatus = EntityStatus.ENTIRY_STATUS_ERROR;
            return Text('Error: $state');
          } else {
            return LoadingWidget();
          }
        },
      );
    } else {
      return BlocProvider.value(
        value: BlocProvider.of<BookingBloc>(context),
        child: BlocListener<BookingBloc, BookingState>(
          listenWhen: (previousState, state) {
            if (state is BookingAdding) {
              return true;
            } else if (state is BookingAddFailed) {
              return true;
            } else if (state is BookingAdded) {
              return true;
            }
            return false;
          },
          listener: (context, state) {
            if (state is BookingAdding) {
              _dialogService.showStatusDialog(
                title: 'Place Bid',
                message: 'Sending...',
              );
            } else if (state is BookingAddFailed) {
              Navigator.of(context).pop();
              _dialogService.showSuccessfulStatusDialog(
                  message: 'Sending failed!!');
            } else if (state is BookingAdded) {
              Navigator.of(context).pop();
              _dialogService.showSuccessfulStatusDialog(
                  message: 'Sent successfully!');
            }
          },
          child: createPackageCard(package),
        ),
      );
    }
  }

  Widget createPackageCard(Package package) {
    return PackageCard(
      package: package,
      onPackageCallback: (packageCallbackType, package) async {
        if (package == null) return;
        if (packageCallbackType == PackageCallbackType.ON_PACKAGE_REMOVE) {
          setState(() {
            int start = widget.packages.indexOf(package);
            package.entityStatus = EntityStatus.ENTIRY_STATUS_REMOVING;
            widget.packages.removeAt(start);
            widget.packages.insert(start, package);
          });
        } else if (packageCallbackType ==
            PackageCallbackType.ON_PACKAGE_CREATE) {
          //DialogService _dialogService = sl<DialogService>();
          PackageCreateResponse response =
              await _dialogService.showCreatePackageDialog(
                  traderId: package.traderId, packageName: package.name);
          if (response != null && response.package != null) {
            setState(() {
              int start = widget.packages.indexOf(package);
              widget.packages.removeAt(start);

              response.package.entityStatus =
                  EntityStatus.ENTIRY_STATUS_CREATING;
              widget.packages.insert(start, response.package);
            });
          }
          Navigator.of(context).pop();
        } else if (packageCallbackType ==
            PackageCallbackType.ON_PACKAGE_BOOKING) {
          //DialogService _dialogService = sl<DialogService>();
          BookPackageResponse response =
              await _dialogService.showBookPackageDialog(
            package: package,
          );
          if (response != null && response.booking != null) {
            response.booking.entityStatus = EntityStatus.ENTIRY_STATUS_CREATING;
            BlocProvider.of<BookingBloc>(context)
                .add(BookingAddEvent(booking: response.booking));
          }
          Navigator.of(context).pop();
        } else {
          print('Unhandled $packageCallbackType');
        }
      },
    );
  }
}

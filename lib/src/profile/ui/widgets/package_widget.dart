import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:local_people_core/jobs.dart';
import 'package_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_people_core/core.dart';
import '../blocs/profile_bloc.dart';
import '../blocs/profile_event.dart';
import '../blocs/profile_state.dart';

typedef OnPackageAdded = void Function(Package, int);
typedef OnPackageRemoved = void Function(Package, int);

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

  void _showPackageRemoveProgressDialog(DialogService dialogService) async {
    StatusDialogResponse dialogResult = await dialogService.showStatusDialog(
      title: 'Package',
      message: 'Romoving...',
    );
    Navigator.of(context).pop();
    if (dialogResult.status == StatusDialogStatus.SUCCESSFUL) {
      await dialogService.showSuccessfulStatusDialog(
          message: 'Package Removed Successfully!');
      Navigator.of(context).pop();
    } else {
      await dialogService.showErrorStatusDialog(
          message: 'Package Remove Failed!');
      Navigator.of(context).pop();
    }
  }

  void _showPackageAddProgressDialog(DialogService dialogService) async {
    StatusDialogResponse dialogResult = await dialogService.showStatusDialog(
      title: 'Package',
      message: 'Saving...',
    );
    if (dialogResult.status == StatusDialogStatus.SUCCESSFUL) {
      await _dialogService.showSuccessfulStatusDialog(
          message: 'Package Saved Successfully!');
      Navigator.of(context).pop();
    } else {
      await _dialogService.showErrorStatusDialog(
          message: 'Package Saving Failed!');
      Navigator.of(context).pop();
    }
  }

  Widget createPackage(Package package) {
    if (package == null) return Container();
    DialogService _dialogService = sl<DialogService>();
    if (package.optionType == PackageOptionType.REMOVE) {
      return BlocProvider.value(
          value: BlocProvider.of<PackageBloc>(context),
          child: BlocListener<PackageBloc, PackageState>(
              listener: (BuildContext context, PackageState state) async {
                if (state is PackageDeleted) {
                  setState(() {
                    if (widget.packages == null)
                      widget.packages = [];

                    if (widget.packages != null && widget.packages.length > 0) {
                      Package findPackage(int id) => widget.packages
                          .firstWhere((package) => package.id == id);
                      Package package = findPackage(state.id);
                      int index = widget.packages.indexOf(package);
                      if (index >= 0) {
                        widget.packages.removeAt(index);

                        if (widget.onPackageRemoved != null) {
                          widget.onPackageRemoved(package, index);
                        }
                      }
                    }
                  });

                  _dialogService.statusDialogComplete(
                      StatusDialogResponse(
                          status: StatusDialogStatus.SUCCESSFUL
                      )
                  );

                  //BlocProvider.of<ProfileBloc>(context).add(ProfileGetEvent());
                } else if (state is PackageDeleteFailed) {
                  _dialogService.statusDialogComplete(
                      StatusDialogResponse(
                          status: StatusDialogStatus.FAILED
                      )
                  );
                } else if (state is PackageDeleting) {
                  _showPackageRemoveProgressDialog(_dialogService);
                }
              },
              child: createPackageCard(package),
          ),
      );
    } else if (package.optionType == PackageOptionType.ADD_NEW) {
      return BlocProvider.value(
        value: BlocProvider.of<PackageBloc>(context),
        child: BlocListener<PackageBloc, PackageState>(
            listener: (BuildContext context, PackageState state) async {
              if (state is PackageAdded) {
                setState(() {
                  if (widget.packages == null)
                    widget.packages = [];
                  int index = widget.packages.length - 1;
                  if (index >= 0) {
                    Package addNew = widget.packages.elementAt(index);
                    addNew.name =
                        'Pavkage ' + (widget.packages.length + 1).toString();
                    widget.packages.insert(index, state.package);
                  } else {
                    widget.packages.add(state.package);
                  }
                  if (widget.onPackageAdded != null) {
                    widget.onPackageAdded(state.package, index - 1);
                  }
                });
                //BlocProvider.of<ProfileBloc>(context).add(ProfileGetEvent());
                _dialogService.statusDialogComplete(
                    StatusDialogResponse(
                        status: StatusDialogStatus.SUCCESSFUL
                    )
                );
              } else if (state is PackageAddFailed) {
                _dialogService.statusDialogComplete(
                    StatusDialogResponse(
                        status: StatusDialogStatus.FAILED
                    )
                );
              } else if (state is PackageAdding) {
                Navigator.of(context).pop();
                _showPackageAddProgressDialog(_dialogService);
              }
            },
            child: createPackageCard(package),
        ),
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
          int index = widget.packages.indexOf(package);
          package.entityStatus = EntityStatus.ENTIRY_STATUS_COMPLETED;
          // if (widget.onPackageRemoved != null) {
          //   widget.onPackageRemoved(package, index);
          // }
          BlocProvider.of<PackageBloc>(context)
              .add(PackageDeleteEvent(id: package.id));
        } else if (packageCallbackType ==
            PackageCallbackType.ON_PACKAGE_CREATE) {
          PackageBloc packageBloc = BlocProvider.of<PackageBloc>(context);
          //DialogService _dialogService = sl<DialogService>();
          PackageCreateResponse response =
              await _dialogService.showCreatePackageDialog(
                  traderId: package.traderId, packageName: package.name);
          if (response != null && response.package != null) {
            int index = widget.packages.length - 1;
            response.package.entityStatus =
                EntityStatus.ENTIRY_STATUS_CREATING;
            packageBloc.add(PackageAddEvent(package: response.package,));
            // if (widget.onPackageAdded != null) {
            //   widget.onPackageAdded(response.package, index);
            // }
          }
          //Navigator.of(context).pop();
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

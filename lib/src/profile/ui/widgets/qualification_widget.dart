import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:local_people_core/profile.dart';
import '../../domain/entities/qualification.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:local_people_core/jobs.dart';
import 'qualification_card.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:local_people_core/jobs.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/auth.dart';
import '../../domain/repositories/qualification_repository.dart';
import '../blocs/qualification_bloc.dart';

typedef OnQualificationAdded = void Function(Qualification, int);
typedef OnQualificationRemoved = void Function(Qualification, int);

class QualificationWidget extends StatefulWidget {
  List<Qualification> qualifications;
  final List<String> sugesstions;
  final OnQualificationAdded onQualificationAdded;
  final OnQualificationRemoved onQualificationRemoved;

  QualificationWidget(
      {@required this.qualifications,
      this.sugesstions = const [],
        this.onQualificationAdded,
        this.onQualificationRemoved,
    });

  @override
  _QualificationWidgetState createState() => _QualificationWidgetState();
}

class _QualificationWidgetState extends State<QualificationWidget> {
  void _showQualificationAddProgressDialog(DialogService _dialogService) async {
    StatusDialogResponse dialogResult = await _dialogService.showStatusDialog(
      title: 'Qualification',
      message: 'Adding ...',
    );
    if (dialogResult.status == StatusDialogStatus.SUCCESSFUL) {
      await _dialogService.showSuccessfulStatusDialog(message: 'Added Successfully!');
      Navigator.of(context).pop();
    } else {
      await _dialogService.showErrorStatusDialog(message: 'Add Failed!');
      Navigator.of(context).pop();
    }
  }


  void _showQualificationDeleteProgressDialog(DialogService _dialogService) async {
    StatusDialogResponse dialogResult = await _dialogService.showStatusDialog(
      title: 'Qualification',
      message: 'Deleting ...',
    );
    if (dialogResult.status == StatusDialogStatus.SUCCESSFUL) {
      await _dialogService.showSuccessfulStatusDialog(message: 'Deleted Successfully!');
      Navigator.of(context).pop();
    } else {
      await _dialogService.showErrorStatusDialog(message: 'Delete Failed!');
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    //return buildBody();
    DialogService _dialogService = sl<DialogService>();
    return BlocProvider.value(
      value: BlocProvider.of<QualificationBloc>(context),
      child: BlocListener<QualificationBloc, QualificationState>(
        listener: (context, state) {
          // do stuff here based on BlocA's state
          if (state is QualificationAdded) {
            _dialogService.statusDialogComplete(
                StatusDialogResponse(
                    status: StatusDialogStatus.SUCCESSFUL
                )
            );
            if (widget.qualifications == null)
              widget.qualifications = [];

            setState(() {
              if (widget.onQualificationAdded != null) {
                int index = widget.qualifications.indexOf(state.qualification);
                widget.onQualificationAdded(state.qualification, index);
              }
            });
          } else if (state is QualificationAddFailed){
            _dialogService.statusDialogComplete(
                StatusDialogResponse(
                    status: StatusDialogStatus.FAILED
                )
            );
          } else if (state is QualificationAdding){
            _showQualificationAddProgressDialog(_dialogService);
          } else if (state is QualificationDeleted) {
            _dialogService.statusDialogComplete(
                StatusDialogResponse(
                    status: StatusDialogStatus.SUCCESSFUL
                )
            );
            setState(() {
              if (widget.onQualificationRemoved != null) {
                widget.onQualificationRemoved(null, state.id);
              }
            });
          } else if (state is QualificationDeleteFailed){
            _dialogService.statusDialogComplete(
                StatusDialogResponse(
                    status: StatusDialogStatus.FAILED
                )
            );
          } else if (state is QualificationDeleting){
            _showQualificationDeleteProgressDialog(_dialogService);
          }
        },
        child: buildBody(context),
      ),
    );


  }

  Widget buildBody(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container (
            padding: EdgeInsets.only(left: 12.0),
            child: Text(
              "Qualifications",
              style: theme.textTheme.subtitle1,
            ),
          ),
          ListView.builder(
            primary: false,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                  child: createQualification(widget.qualifications[index]),
                  onTap: () {
                    // TODO 15: Call Add To Cart
                  }
              );
            },
            itemCount: widget.qualifications == null ? 0 : widget.qualifications.length,
          ),
        ],
      ),
    );
  }

  Widget createQualification(Qualification qualification) {
    return QualificationCard(
      qualification: qualification,
      sugesstions: widget.sugesstions,
    );
  }

}

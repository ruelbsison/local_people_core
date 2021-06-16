import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/qualification.dart';
import '../blocs/qualification_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:local_people_core/core.dart';

class QualificationCard extends StatefulWidget {
  QualificationCard({
    Key key,
    @required this.qualification,
    this.sugesstions = const [],
  }) : super(key: key);

  Qualification qualification;
  final List<String> sugesstions;

  @override
  _QualificationCardState createState() => _QualificationCardState();
}

class _QualificationCardState extends State<QualificationCard> {

  FocusNode _focusNode = new FocusNode();
  final TextEditingController _qualificationextController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _qualificationextController.dispose();
  }

  void _showProgressDialog(DialogService _dialogService) async {
    StatusDialogResponse dialogResult = await _dialogService.showStatusDialog(
      title: 'Qualification',
      message: 'Adding ...',
    );
    if (dialogResult.status == StatusDialogStatus.SUCCESSFUL) {
      Future
          .delayed(Duration(seconds: 5))
          .then((_) => _dialogService.successfulStatusDialogComplete());
      await _dialogService.showSuccessfulStatusDialog(message: 'Added Successfully!');
      Navigator.of(context).popUntil(ModalRoute.withName('/'));
    } else {
      Future
          .delayed(Duration(seconds: 5))
          .then((_) => _dialogService.errorStatusDialogComplete());
      await _dialogService.showErrorStatusDialog(message: 'Add Failed!');
    }
  }

  @override
  Widget build(BuildContext context) {
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
          } else if (state is QualificationAddFailed){
            _dialogService.statusDialogComplete(
                StatusDialogResponse(
                    status: StatusDialogStatus.FAILED
                )
            );
          } else if (state is QualificationAdding){
            _showProgressDialog(_dialogService);
          }
        },
        child: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    if (widget.qualification == null)
      return Container();
    if (widget.qualification.optionType == QualificationOptionType.ADD_DEFAULT) {
      return build_qualification_add_default(context);
    } else if (widget.qualification.optionType == QualificationOptionType.ADD_NEW) {
      //return build_qualification_add_new(context);
    } else if (widget.qualification.optionType == QualificationOptionType.REMOVE) {
      return build_qualification_remove(context);
    } else if (widget.qualification.optionType == QualificationOptionType.VIEW_ONLY) {
      return build_qualification_view(context);
    }
  }

  Widget build_qualification_add_default(BuildContext context) {
    final theme = Theme.of(context);
    //Size size = MediaQuery.of(context).size;
    //AppType appType = AppConfig.of(context).appType;
    return Flex(
      direction: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: CircleAvatar(
            radius: 12,
            child: Center(
              child: SvgPicture.asset(
                'packages/local_people_core/assets/images/verified.svg',
                fit: BoxFit.contain,
                height: 15,
                width: 15,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            widget.qualification.title != null ? widget.qualification.title : '',
            textAlign: TextAlign.left,
            style: theme.textTheme.subtitle1,
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              icon: SvgPicture.asset(
                'packages/local_people_core/assets/images/plus.svg',
                height: 24,
                width: 24,
              ),
              iconSize: 24,
              onPressed: () {
                BlocProvider.of<QualificationBloc>(context)
                    .add(QualificationAddEvent(qualification: widget.qualification));
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget build_qualification_add_new(BuildContext context) {
    final theme = Theme.of(context);
    //Size size = MediaQuery.of(context).size;
    //AppType appType = AppConfig.of(context).appType;
    return Flex(
      direction: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: CircleAvatar(
            radius: 12,
            child: Center(
              child: SvgPicture.asset(
                'packages/local_people_core/assets/images/verified.svg',
                fit: BoxFit.contain,
                height: 15,
                width: 15,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
                focusNode: _focusNode,
                controller: _qualificationextController,
                style: DefaultTextStyle.of(context).style.copyWith(
                    fontStyle: FontStyle.italic
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder()
                )
            ),
            suggestionsCallback: (pattern) async {
              return widget.sugesstions;
            },
            itemBuilder: (context, suggestion) {
              return ListTile(
                //leading: Icon(Icons.cat),
                title: Text(suggestion),
                //subtitle: Text('£'),
              );
            },
            onSuggestionSelected: (suggestion) {
              widget.qualification.title = suggestion.toString();
              // TODO: Ruel
              BlocProvider.of<QualificationBloc>(context)
                  .add(QualificationAddEvent(qualification: widget.qualification));
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              icon: SvgPicture.asset(
                'packages/local_people_core/assets/images/plus.svg',
                height: 24,
                width: 24,
              ),
              iconSize: 24,
              onPressed: () {
                setState(() {
                  _qualificationextController.clear();
                  _focusNode.requestFocus();
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget build_qualification_remove(BuildContext context) {
    final theme = Theme.of(context);
    //Size size = MediaQuery.of(context).size;
    //AppType appType = AppConfig.of(context).appType;
    return Flex(
      direction: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: CircleAvatar(
            radius: 12,
            child: Center(
              child: SvgPicture.asset(
                'packages/local_people_core/assets/images/verified.svg',
                fit: BoxFit.contain,
                height: 15,
                width: 15,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            widget.qualification.title != null ? widget.qualification.title : '',
            textAlign: TextAlign.left,
            style: theme.textTheme.subtitle1,
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              icon: SvgPicture.asset(
                'packages/local_people_core/assets/images/minus.svg',
                height: 24,
                width: 24,
              ),
              iconSize: 24,
              onPressed: () {
                // TODO: Ruel
                BlocProvider.of<QualificationBloc>(context)
                    .add(QualificationDeleteEvent(id: widget.qualification.id));
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget build_qualification_view(BuildContext context) {
    final theme = Theme.of(context);
    //Size size = MediaQuery.of(context).size;
    //AppType appType = AppConfig.of(context).appType;
    return Flex(
      direction: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: CircleAvatar(
            radius: 12,
            child: Center(
              child: SvgPicture.asset(
                'packages/local_people_core/assets/images/verified.svg',
                fit: BoxFit.contain,
                height: 15,
                width: 15,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            widget.qualification.title != null ? widget.qualification.title : '',
            textAlign: TextAlign.left,
            style: theme.textTheme.subtitle1,
          ),
        ),
      ],
    );
  }
}



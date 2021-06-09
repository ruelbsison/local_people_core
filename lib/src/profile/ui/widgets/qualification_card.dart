import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/qualification.dart';
import '../blocs/qualification_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

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

  @override
  Widget build(BuildContext context) {
    if (widget.qualification == null)
      return Container();
    if (widget.qualification.optionType == QualificationOptionType.ADD_DEFAULT) {
      return build_qualification_add_default(context);
    } else if (widget.qualification.optionType == QualificationOptionType.ADD_NEW) {
      return build_qualification_add_new(context);
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
                child: Image.asset(
                  'packages/local_people_core/assets/images/verified-icon.png',
                  fit: BoxFit.contain,
                  height: 23,
                  width: 23,
                )),
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
                child: Image.asset(
                  'packages/local_people_core/assets/images/verified-icon.png',
                  fit: BoxFit.contain,
                  height: 23,
                  width: 23,
                )),
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
                //subtitle: Text('\$}'),
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
                child: Image.asset(
                  'packages/local_people_core/assets/images/verified-icon.png',
                  fit: BoxFit.contain,
                  height: 23,
                  width: 23,
                )),
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
                child: Image.asset(
                  'packages/local_people_core/assets/images/verified-icon.png',
                  fit: BoxFit.contain,
                  height: 23,
                  width: 23,
                )),
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



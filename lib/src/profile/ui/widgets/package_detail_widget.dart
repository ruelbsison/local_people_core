import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/jobs.dart';

class PackageDetailWidget extends StatefulWidget {
  final String name;
  final int traderId;
  PackageDetailWidget({
    Key key,
    @required this.name,
    @required this.traderId,
  }) : super(key: key);

  @override
  _PackageDetailWidgetState createState() => _PackageDetailWidgetState();
}



class _PackageDetailWidgetState extends State<PackageDetailWidget> {
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _descTextController = TextEditingController();
  final TextEditingController _durationTextController = TextEditingController();
  final TextEditingController _costTextController = TextEditingController();
  //final TextEditingController _depositTextController = TextEditingController();
  FocusNode _focusNodeDesc = new FocusNode();
  FocusNode _focusNodeName = new FocusNode();
  FocusNode _focusNodeDuration = new FocusNode();
  FocusNode _focusNodeCost = new FocusNode();

  @override
  void initState() {
    super.initState();

    _nameTextController.text = widget.name;

    _descTextController.addListener(() {
    if (_descTextController.text.length != _descTextController.text.trim().length) {
      _descTextController.text = _descTextController.text.trim();
    }
    _descTextController.selection =
      TextSelection.collapsed(offset: _descTextController.text.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20),
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(left: 12.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Name',
                          textAlign: TextAlign.left,
                          style: theme.textTheme.bodyText1,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      //padding: EdgeInsets.only(right: 10),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextField(
                          style: theme.textTheme.bodyText2,
                          controller: _nameTextController,
                          focusNode: _focusNodeName,
                          decoration: InputDecoration(
                            labelText: 'Package Name',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            // border: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(30),
                            //     borderSide: BorderSide.none),
                            border: InputBorder.none,
                            hintText: 'Package Name',
                            hintStyle: theme.textTheme.bodyText2,
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.grey.shade300, width: 2),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5),
                                topLeft: Radius.circular(5),
                              ),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.grey.shade300, width: 2),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5),
                                topLeft: Radius.circular(5),
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          onSubmitted: (val) {
                            _focusNodeDesc.requestFocus();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.only(left: 12.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Description',
                textAlign: TextAlign.left,
                style: theme.textTheme.bodyText1,
              ),
            ),
          ),
          SizedBox(height: 10),
          Container (
            child: TextField (
              autofocus: true,
              focusNode: _focusNodeDesc,
              controller: _descTextController,
              keyboardType: TextInputType.multiline,
              minLines: 5,//Normal textInputField will be displayed
              maxLines: 9,// when user presses enter it will adapt to it
               decoration: InputDecoration(
                //labelText: 'Describe this package',
                floatingLabelBehavior: FloatingLabelBehavior.never,
                // enabledBorder: OutlineInputBorder(
                //   borderSide: BorderSide.none,
                // ),
                // border: OutlineInputBorder(
                //   borderSide: BorderSide.none,
                // ),
                // border: OutlineInputBorder(
                //     borderRadius: BorderRadius.circular(30),
                //     borderSide: BorderSide.none),
                 border: InputBorder.none,
                 hintText: 'Describe this package',
                 hintStyle: theme.textTheme.bodyText2,
                 focusedBorder: OutlineInputBorder(
                   borderSide:
                   BorderSide(color: Colors.grey.shade300, width: 2),
                   borderRadius: BorderRadius.only(
                     topRight: Radius.circular(5),
                     topLeft: Radius.circular(5),
                   ),
                 ),
                 fillColor: Colors.white,
                 filled: true,
                 enabledBorder: OutlineInputBorder(
                   borderSide:
                   BorderSide(color: Colors.grey.shade300, width: 2),
                   borderRadius: BorderRadius.only(
                     topRight: Radius.circular(5),
                     topLeft: Radius.circular(5),
                   ),
                 ),
               ),
              onChanged: (value) {
                //this._keyword = value;
              },
              onSubmitted: (val) {
                _focusNodeDuration.requestFocus();
              },
              textInputAction: TextInputAction.next,
            ),
          ),
          SizedBox(height: 10),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(left: 12.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Duration',
                          textAlign: TextAlign.right,
                          style: theme.textTheme.bodyText1,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Card(
                      //padding: EdgeInsets.only(right: 10),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextField(
                          style: theme.textTheme.bodyText2,
                          controller: _durationTextController,
                          focusNode: _focusNodeDuration,
                          decoration: InputDecoration(
                            labelText: 'Hours',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            // border: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(30),
                            //     borderSide: BorderSide.none),
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          onSubmitted: (val) {
                            _focusNodeCost.requestFocus();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(left: 12.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Cost',
                          textAlign: TextAlign.right,
                          style: theme.textTheme.bodyText1,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Card(
                      //padding: EdgeInsets.only(right: 10),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextField(
                          style: theme.textTheme.bodyText2,
                          focusNode: _focusNodeCost,
                          controller: _costTextController,
                          decoration: InputDecoration(
                            labelText: '£ Amount',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            // border: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(30),
                            //     borderSide: BorderSide.none),
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Column(
          //   mainAxisSize: MainAxisSize.min,
          //   children: <Widget>[
          //     Container(
          //       height: 1.0,
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         border: Border(
          //           bottom: BorderSide(
          //             color: Color.fromRGBO(186, 207, 216, 1),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          SizedBox(height: 20),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flex(
                direction: Axis.horizontal,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(left: 12.0, right: 12.0),
                      child: ElevatedButton(
                        onPressed: () {
                          DialogService _dialogService = sl<DialogService>();
                          _dialogService.createPackageDialogComplete(
                              PackageCreateResponse(),
                          );
                        },
                        child: Text(
                          'Cancel',
                          style: theme.textTheme.button
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(left: 12.0, right: 12.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(255, 99, 95, 1),
                          onPrimary: Color.fromRGBO(170, 186, 205, 1),
                        ),
                        onPressed: () {
                          if (_nameTextController.text.isEmpty) {
                            _focusNodeName.requestFocus();
                            return;
                          }
                          if (_descTextController.text.isEmpty) {
                            _focusNodeDesc.requestFocus();
                            return;
                          }
                          if (_durationTextController.text.isEmpty) {
                            _focusNodeDuration.requestFocus();
                            return;
                          }
                          if (_costTextController.text.isEmpty) {
                            _focusNodeCost.requestFocus();
                            return;
                          }
                          Package package = Package(
                            name: _nameTextController.text,
                            description: _descTextController.text,
                            durationInHours: int.parse(_durationTextController.text),
                            cost: double.parse(_costTextController.text),
                            traderId: widget.traderId,
                            optionType: PackageOptionType.REMOVE,
                            entityStatus: EntityStatus.ENTIRY_STATUS_CREATING,
                          );
                          DialogService _dialogService = sl<DialogService>();
                          _dialogService.createPackageDialogComplete(
                              PackageCreateResponse(
                                  package: package
                              )
                          );
                        },
                        child: Text(
                          'Create Package',
                          style: theme.textTheme.button
                              .copyWith(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
    );
  }
}
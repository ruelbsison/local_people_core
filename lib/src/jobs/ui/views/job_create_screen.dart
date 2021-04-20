import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:local_people_core/core.dart';
import '../../domain/entities/job.dart';
import '../../domain/entities/profile.dart';
import '../widgets/tags_view_widget.dart';
import 'job_preview_screen.dart';
import 'package:google_place/google_place.dart';
import '../widgets/images_view_widget.dart';
import 'package:material_segmented_control/material_segmented_control.dart';

class JobCreateScreen extends StatefulWidget {
  @override
  _JobCreateScreenState createState() => _JobCreateScreenState();
}

class _JobCreateScreenState extends State<JobCreateScreen>
    with WidgetsBindingObserver {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Job job;
  GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  final TextEditingController _locationTextController = TextEditingController();

  int _requestedTimeframeCurrentSelection = 0;
  int _timeToRespondCurrentSelection = 0;

  FocusNode _focusNodeLocation = new FocusNode();
  FocusNode _focusNodeJobGategory= new FocusNode();
  FocusNode _focusNodeJobInfo = new FocusNode();
  FocusNode _focusNodeJobDesc = new FocusNode();
  FocusNode _focusNodeBudget = new FocusNode();
  FocusNode _focusNodeTimeframeDay = new FocusNode();
  FocusNode _focusNodeTimeframeMonth = new FocusNode();
  FocusNode _focusNodeTimeframeYear = new FocusNode();

  String morningAfternoon = 'Morning';


  @override
  void initState() {
    String apiKey =
        'AIzaSyDas3RPqegAcudGgkX4xlykHztH1nZCfvo'; //DotEnv().env['API_KEY'];
    googlePlace = GooglePlace(apiKey);

    super.initState();
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        appBarPreferredSize: Size.fromHeight(60.0),
        title: Text(
          AppLocalizations.of(context).appTitle,
        ),
        appBar: AppBar(),
        subTitle: LocalPeopleLocalizations.of(context).menuTitlePostJob,
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 14.0),
            child: ElevatedButton(
              child: Text(
                LocalPeopleLocalizations.of(context).btnTitleCancel,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
              onPressed: () {
                //AppRouter.pushPage(context, JobCreateScreen());
                Navigator.pop(context);
              },
            ),
            alignment: Alignment.center,
          )
        ],
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    Map<int, Widget> _timeToRespondChildren = {
      0: Container(
        padding: EdgeInsets.only(left: 12.0, right: 12.0),
        margin: EdgeInsets.only(left: 6.0, right: 6.0),
        child: Text(
          LocalPeopleLocalizations.of(context).subTitle24Hrs,
          style: theme.textTheme.bodyText2,
        ),
      ),
      1: Container(
        padding: EdgeInsets.only(left: 12.0, right: 12.0),
        margin: EdgeInsets.only(left: 6.0, right: 6.0),
        child: Text(
          LocalPeopleLocalizations.of(context).subTitle48Hrs,
          style: theme.textTheme.bodyText2,
        ),
      ),
      2: Container(
        padding: EdgeInsets.only(left: 12.0, right: 12.0),
        margin: EdgeInsets.only(left: 6.0, right: 6.0),
        child: Text(
          LocalPeopleLocalizations.of(context).subTitleThisWeek,
          style: theme.textTheme.bodyText2,
        ),
      )
    };
    Map<int, Widget> _requestedTimeframeChildren = {
      0: Container(
        padding: EdgeInsets.only(left: 12.0, right: 12.0),
        margin: EdgeInsets.only(left: 6.0, right: 6.0),
        child: Text(
          LocalPeopleLocalizations.of(context).subTitleASAP,
          style: theme.textTheme.bodyText2,
        ),
      ),
      1: Container(
        padding: EdgeInsets.only(left: 12.0, right: 12.0),
        margin: EdgeInsets.only(left: 6.0, right: 6.0),
        child: Text(
          LocalPeopleLocalizations.of(context).subTitleThisWeek,
          style: theme.textTheme.bodyText2,
        ),
      ),
      2: Container(
        padding: EdgeInsets.only(left: 12.0, right: 12.0),
        margin: EdgeInsets.only(left: 6.0, right: 6.0),
        child: Text(
          LocalPeopleLocalizations.of(context).subTitleSpecific,
          style: theme.textTheme.bodyText2,
        ),
      )
    };
    return SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Flex(
            direction: Axis.vertical,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(12.0),
                margin: EdgeInsets.only(left: 12, right: 12.0),
                //margin: EdgeInsets.all(12.0),
                child: Flex(
                  direction: Axis.vertical,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      LocalPeopleLocalizations.of(context).titleLocation,
                      textAlign: TextAlign.left,
                      style: theme.textTheme.bodyText1,
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      color: Colors.white,
                      //padding: EdgeInsets.only(left: 12.0, right: 12.0),
                      child: EnsureVisibleWhenFocused(
                        focusNode: _focusNodeLocation,
                        child: TextFormField(
                          controller: _locationTextController,
                          decoration: InputDecoration(
                            labelText: LocalPeopleLocalizations.of(context)
                                .titleAreaName,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                          keyboardType: TextInputType.streetAddress,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              autoCompleteSearch(value);
                            } else {
                              if (predictions.length > 0 && mounted) {
                                setState(() {
                                  predictions = [];
                                });
                              }
                            }
                          },
                          onFieldSubmitted: (value) {
                            setState(() {
                              job.location = value;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return LocalPeopleLocalizations.of(context)
                                      .titleLocation +
                                  '!';
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: predictions.length > 0 ? 200 : 0,
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListView.builder(
                          itemCount: predictions.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: CircleAvatar(
                                child: Icon(
                                  Icons.pin_drop,
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(predictions[index].description),
                              onTap: () {
                                debugPrint(predictions[index].placeId);
                                job.location = predictions[index].description;
                                setState(() {
                                  _locationTextController.text = job.location;
                                  predictions = [];
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Text(
                      LocalPeopleLocalizations.of(context).titleJobCategory,
                      textAlign: TextAlign.left,
                      style: theme.textTheme.bodyText1,
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      color: Colors.white,
                      //padding: EdgeInsets.only(left: 12.0, right: 12.0),
                      child: EnsureVisibleWhenFocused(
                        focusNode: _focusNodeJobGategory,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: '',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Invalid ' +
                                  LocalPeopleLocalizations.of(context)
                                      .titleJobCategory +
                                  '!';
                            }
                          },
                          onFieldSubmitted: (value) {
                            setState(() {
                              job.description = value;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      LocalPeopleLocalizations.of(context).titleSuggestions,
                      textAlign: TextAlign.left,
                      style: theme.textTheme.subtitle2,
                    ),
                    SizedBox(height: 10.0),
                    TagsViewWidget(
                      tags: [
                        'Window Cleaner',
                        'Handy Man',
                        'Window Cleaner',
                        'Handy Man',
                        'Window Cleaner',
                        'Handy Man',
                        'Window Cleaner',
                        'Handy Man',
                        'Window Cleaner',
                        'Handy Man'
                      ],
                    ),
                    SizedBox(height: 30.0),
                    Text(
                      LocalPeopleLocalizations.of(context).titleJobDescription,
                      textAlign: TextAlign.left,
                      style: theme.textTheme.bodyText1,
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      color: Colors.white,
                      //padding: EdgeInsets.only(left: 12.0, right: 12.0),
                      child: EnsureVisibleWhenFocused(
                        focusNode: _focusNodeJobDesc,
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: '',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Invalid ' +
                                  LocalPeopleLocalizations.of(context)
                                      .titleJobDescription +
                                  '!';
                            }
                          },
                          onFieldSubmitted: (value) {
                            setState(() {
                              job.description = value;
                            });
                          },
                        ),
                      ),
                    ),
                    // Container (
                    //   child: ImagesViewWidget(images: ['https://media-exp1.licdn.com/dms/image/C4E0BAQGCMeC6rK_H0g/company-logo_200_200/0/1594223715044?e=1626912000&v=beta&t=S4tF6F2mgbv_Zt8nd-TaGql7dhWc4xFJbKmDy8oc9uY',
                    //     'https://media-exp1.licdn.com/dms/image/C4E0BAQGCMeC6rK_H0g/company-logo_200_200/0/1594223715044?e=1626912000&v=beta&t=S4tF6F2mgbv_Zt8nd-TaGql7dhWc4xFJbKmDy8oc9uY',
                    //     'https://media-exp1.licdn.com/dms/image/C4E0BAQGCMeC6rK_H0g/company-logo_200_200/0/1594223715044?e=1626912000&v=beta&t=S4tF6F2mgbv_Zt8nd-TaGql7dhWc4xFJbKmDy8oc9uY']),
                    // ),
                    SizedBox(height: 30.0),
                    Flex(
                        direction: Axis.vertical,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            LocalPeopleLocalizations.of(context).titleBudget,
                            textAlign: TextAlign.left,
                            style: theme.textTheme.bodyText1,
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            color: Colors.white,
                            //padding: EdgeInsets.only(left: 12.0, right: 12.0),
                            width: size.width / 2,
                            child: EnsureVisibleWhenFocused(
                              focusNode: _focusNodeBudget,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: '',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Invalid ' +
                                        LocalPeopleLocalizations.of(context)
                                            .titleBudget +
                                        '!';
                                  }
                                },
                                onFieldSubmitted: (value) {
                                  setState(() {
                                    job.budget = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ]),
                    SizedBox(height: 30.0),
                    Text(
                      LocalPeopleLocalizations.of(context)
                          .titleRequestedTimeframe,
                      textAlign: TextAlign.left,
                      style: theme.textTheme.bodyText1,
                    ),
                    SizedBox(height: 10.0),
                    MaterialSegmentedControl(
                      children: _requestedTimeframeChildren,
                      selectionIndex: _requestedTimeframeCurrentSelection,
                      borderColor: Colors.white,
                      selectedColor: Color.fromRGBO(170, 186, 205, 1),
                      unselectedColor: Colors.white,
                      borderRadius: 5.0,
                      horizontalPadding: EdgeInsets.only(left: 2.0, right: 2.0),
                      onSegmentChosen: (index) {
                        setState(() {
                          _requestedTimeframeCurrentSelection = index;
                        });
                      },
                    ),
                    SizedBox(height: 30.0),
                    Container(
                      color: Colors.white,
                      width: size.width,
                      //padding: EdgeInsets.only(left: 12.0, right: 12.0),
                      height: _requestedTimeframeCurrentSelection == 0 ? 50 : 0,
                    ),
                    Container(
                      color: Colors.white,
                      width: size.width,
                      //padding: EdgeInsets.only(left: 12.0, right: 12.0),
                      height: _requestedTimeframeCurrentSelection == 1 ? 50 : 0,
                    ),
                    Container(
                      color: Colors.white,
                      width: size.width,
                      //padding: EdgeInsets.only(left: 12.0, right: 12.0),
                      height: _requestedTimeframeCurrentSelection == 2 ? 50 : 0,
                      child: Flex(
                        direction: Axis.horizontal,
                        mainAxisSize: MainAxisSize.max,
                  		  mainAxisAlignment: MainAxisAlignment.start,
                  		  crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: EnsureVisibleWhenFocused(
                              focusNode: _focusNodeTimeframeDay,
                              child: TextFormField(
                                maxLength: 2,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.numberWithOptions(),
                                decoration: InputDecoration(
                                  hintText: 'DD',
                                  counterText: '',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                inputFormatters: [
                                  WhitelistingTextInputFormatter(
                                      RegExp("[0-9/]")),
                                  LengthLimitingTextInputFormatter(10),
                                  DateTextInputFormatter(),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: EnsureVisibleWhenFocused(
                              focusNode: _focusNodeTimeframeMonth,
                              child: TextFormField(
                                maxLength: 2,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.numberWithOptions(),
                                decoration: InputDecoration(
                                  hintText: 'MM',
                                  counterText: '',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                inputFormatters: [
                                  WhitelistingTextInputFormatter(
                                      RegExp("[0-9/]")),
                                  LengthLimitingTextInputFormatter(2),
                                  DateTextInputFormatter(),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: EnsureVisibleWhenFocused(
                              focusNode: _focusNodeTimeframeYear,
                              child: TextFormField(
                                maxLength: 2,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.numberWithOptions(),
                                decoration: InputDecoration(
                                  hintText: 'YY',
                                  counterText: '',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                inputFormatters: [
                                  WhitelistingTextInputFormatter(
                                      RegExp("[0-9/]")),
                                  LengthLimitingTextInputFormatter(2),
                                  DateTextInputFormatter(),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: DropdownButtonFormField<String>(
                              value: morningAfternoon,
                              /*decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),*/
                              items: <String>[
                                'Morning',
                                'Afternoon',
                              ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<
                                        String>(
                                      value: value,
                                      child: Center (
                                        child: Text(
                                          value,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                              onChanged: (String newValue) {
                                setState(() {
                                  morningAfternoon = newValue;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      LocalPeopleLocalizations.of(context).titleTimeToRespond,
                      textAlign: TextAlign.left,
                      style: theme.textTheme.bodyText1,
                    ),
                    SizedBox(height: 30.0),
                    MaterialSegmentedControl(
                      children: _timeToRespondChildren,
                      selectionIndex: _timeToRespondCurrentSelection,
                      borderColor: Colors.white,
                      selectedColor: Color.fromRGBO(170, 186, 205, 1),
                      unselectedColor: Colors.white,
                      borderRadius: 5.0,
                      horizontalPadding: EdgeInsets.only(left: 2.0, right: 2.0),
                      onSegmentChosen: (index) {
                        setState(() {
                          _timeToRespondCurrentSelection = index;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.0),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(12.0),
                margin: EdgeInsets.only(left: 12, right: 12.0),
                //margin: EdgeInsets.all(12.0),
                child: Flex(
                  direction: Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      //padding: EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Text(
                        LocalPeopleLocalizations.of(context).titlePostEdits,
                        textAlign: TextAlign.left,
                        style: theme.textTheme.bodyText1,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Container(
                        color: Colors.white,
                        child: Flex(
                          direction: Axis.horizontal,
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding:
                                    EdgeInsets.only(left: 12.0, right: 12.0),
                                child: ElevatedButton(
                                  onPressed: _cancelJob,
                                  child: Text(
                                      LocalPeopleLocalizations.of(context)
                                          .btnTitleCancel),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding:
                                    EdgeInsets.only(left: 12.0, right: 12.0),
                                child: ElevatedButton(
                                  onPressed: _postJob,
                                  child: Text(
                                      LocalPeopleLocalizations.of(context)
                                          .btnTitlePost),
                                ),
                              ),
                            ),
                          ],
                        )),
                    SizedBox(height: 30.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _cancelJob() {
    Navigator.pop(context);
  }

  void _postJob() {
    if (_formKey.currentState.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Processing Data')));

      AppRouter.pushPage(
          context,
          JobPreviewScreen(
            //job: demeJobs[0],
            job: job,
            profile: Profile.demo,
          ));
    }

  }
}

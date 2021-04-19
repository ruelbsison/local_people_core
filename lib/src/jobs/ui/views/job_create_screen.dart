import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:local_people_core/core.dart';
import '../../domain/entities/job.dart';
import '../../domain/entities/profile.dart';
import '../widgets/tags_view_widget.dart';
import 'job_preview_screen.dart';

class JobCreateScreen extends StatefulWidget {
  @override
  _JobCreateScreenState createState() => _JobCreateScreenState();
}

class _JobCreateScreenState extends State<JobCreateScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Job job;

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
                margin: EdgeInsets.all(12.0),
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
                      padding: EdgeInsets.only(left: 12.0, right: 12.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: LocalPeopleLocalizations.of(context)
                                .titleAreaName),
                        keyboardType: TextInputType.streetAddress,
                        onFieldSubmitted: (value) {
                          setState(() {
                            job.title = value;
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
                    SizedBox(height: 10.0),
                    Text(
                      LocalPeopleLocalizations.of(context).titleJobCategory,
                      textAlign: TextAlign.left,
                      style: theme.textTheme.bodyText1,
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(left: 12.0, right: 12.0),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: ''),
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
                    SizedBox(height: 10.0),
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
                    SizedBox(height: 10.0),
                    Text(
                      LocalPeopleLocalizations.of(context).titleJobDescription,
                      textAlign: TextAlign.left,
                      style: theme.textTheme.bodyText1,
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(left: 12.0, right: 12.0),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: ''),
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
                    SizedBox(height: 10.0),
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
                            padding: EdgeInsets.only(left: 12.0, right: 12.0),
                            width: size.width / 2,
                            child: TextFormField(
                              decoration: InputDecoration(labelText: ''),
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
                        ]),
                    SizedBox(height: 10.0),
                    Text(
                      LocalPeopleLocalizations.of(context)
                          .titleRequestedTimeframe,
                      textAlign: TextAlign.left,
                      style: theme.textTheme.bodyText1,
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(left: 12.0, right: 12.0),
                      height: 50,
                    ),
                    SizedBox(height: 30.0),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(left: 12.0, right: 12.0),
                      height: 50,
                    ),
                    SizedBox(height: 30.0),
                    Text(
                      LocalPeopleLocalizations.of(context).titleTimeToRespond,
                      textAlign: TextAlign.left,
                      style: theme.textTheme.bodyText1,
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(left: 12.0, right: 12.0),
                      height: 50,
                    ),
                    SizedBox(height: 30.0),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(12.0),
                //margin: EdgeInsets.all(12.0),
                child: Flex(
                  direction: Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 12.0, right: 12.0),
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
                    SizedBox(height: 10.0),
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
    // you can write your

    // own code according to

    // whatever you want to submit;
  }

  void _postJob() {
    AppRouter.pushPage(context, JobPreviewScreen(job: demeJobs[0], profile: Profile.demo,));
  }
}

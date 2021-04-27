import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
//import 'package:flutter_icons/flutter_icons.dart';
import 'package:local_people_core/core.dart';
import '../../domain/entities/job.dart';
import '../../domain/entities/profile.dart';
import '../widgets/tags_view_widget.dart';
import 'job_preview_screen.dart';
import 'package:google_place/google_place.dart';
import '../widgets/images_view_widget.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
//import 'package:form_builder_image_picker/form_builder_image_picker.dart';
//import 'package:flutter_typeahead/flutter_typeahead.dart';
//import 'package:numberpicker/numberpicker.dart';
import 'package:flutter_tags/flutter_tags.dart';
import '../widgets/form_builder_image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/tag.dart';
import '../../domain/entities/location.dart' as loc;
//import '../view_models/tag_provider.dart';
//import 'package:provider/provider.dart';

class JobCreateScreen extends StatefulWidget {
  @override
  _JobCreateScreenState createState() => _JobCreateScreenState();
}

class _JobCreateScreenState extends State<JobCreateScreen>
    with WidgetsBindingObserver, AutomaticKeepAliveClientMixin {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey();
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
  FocusNode _focusNodeImages = new FocusNode();

  String morningAfternoon = 'Morning';
  int currentDayIntValue = 1; //DateTime.now().day;
  int currentMonthIntValue = 1; //DateTime.now().month;
  int currentYearIntValue = 21; //DateTime.now().year;
  bool stopGooglePlaceSearch = false;
  int maxImages = 1;

  List<Tag> objTags = [];
  List<String> currentTags = [];

  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
// Allows you to get a list of all the ItemTags
  _getAllItem(){
    List<Item> lst = _tagStateKey.currentState?.getAllItem;
    if(lst!=null)
      lst.where((a) => a.active==true).forEach( ( a) => print(a.title));
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    //SchedulerBinding.instance.addPostFrameCallback(
    //      (_) => Provider.of<TagProvider>(context, listen: false).getTags(),
    //);

    String apiKey =
        'AIzaSyDas3RPqegAcudGgkX4xlykHztH1nZCfvo'; //DotEnv().env['API_KEY'];
    googlePlace = GooglePlace(apiKey);
    job = Job.empty();

    objTags.add(Tag(id: 0, name: 'Handy Man'));
    objTags.add(Tag(id: 1, name: 'Window Cleaner'));
    currentTags.add('Handy Man');
    currentTags.add('Window Cleaner');

    super.initState();
  }

  void autoCompleteGooglePlaceSearch(String value) async {
    if (stopGooglePlaceSearch) {
      return;
    }
    try {
      var result = await googlePlace.autocomplete.get(value);
      if (result != null && result.predictions != null && mounted) {
        setState(() {
          predictions = result.predictions;
        });
      }
    } catch (error) {
      setState(() {
        predictions = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
      body: _buildBody(context),
    );
  }

  Widget _buildSegmentedTab(String title) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Container(
      //padding: EdgeInsets.only(left: 12.0, right: 12.0),
      width: size.width / 3,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: theme.textTheme.bodyText2.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  /*Widget _buildBody(TagProvider tagProvider) {
    return BodyBuilder(
      apiRequestStatus: tagProvider.apiRequestStatus,
      child: _buildBodyList(tagProvider),
      reload: () => tagProvider.getTags(),
    );
  }*/

  Widget _buildBody(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery
        .of(context)
        .size;
    List<String> _timeToRespondOptions = [
      LocalPeopleLocalizations
          .of(context)
          .subTitle24Hrs,
      LocalPeopleLocalizations
          .of(context)
          .subTitle48Hrs,
      LocalPeopleLocalizations
          .of(context)
          .subTitleThisWeek,
    ];
    Map<int, Widget> _timeToRespondChildren = {
      0: _buildSegmentedTab(LocalPeopleLocalizations
          .of(context)
          .subTitle24Hrs),
      1: _buildSegmentedTab(LocalPeopleLocalizations
          .of(context)
          .subTitle48Hrs),
      2: _buildSegmentedTab(LocalPeopleLocalizations
          .of(context)
          .subTitleThisWeek),
    };
    Map<int, Widget> _requestedTimeframeChildren = {
      0: _buildSegmentedTab(LocalPeopleLocalizations
          .of(context)
          .subTitleASAP),
      1: _buildSegmentedTab(LocalPeopleLocalizations
          .of(context)
          .subTitleThisWeek),
      2: _buildSegmentedTab(LocalPeopleLocalizations
          .of(context)
          .subTitleSpecific),
    };

    _focusNodeLocation.addListener(() {
      if (_focusNodeLocation.hasFocus) {
        setState(() {
          _locationTextController.clear();
          stopGooglePlaceSearch = false;
        });
      }
    });


    final locationFormEntry = Container(
      padding: EdgeInsets.only(left: 20, right: 20.0),
      child: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        ],
      ),
    );

    final jobCategoryFormEntry = Container(
      padding: EdgeInsets.only(left: 20, right: 20.0),
      child: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        ],
      ),
    );

    final jobDescriptionFormEntry = Container(
      padding: EdgeInsets.only(left: 20, right: 20.0),
      child: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        ],
      ),
    );

    final budgetFormEntry = Container(
      padding: EdgeInsets.only(left: 20, right: 20.0),
      child: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        ],
      ),
    );

    final requestedTimeFrameFormEntry = Container(
      padding: EdgeInsets.only(left: 20, right: 20.0),
      child: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        ],
      ),
    );

    final timeToRespondFormEntry = Container(
      padding: EdgeInsets.only(left: 20, right: 20.0),
      child: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        ],
      ),
    );

    final postEditsFormEntry = Container(
      padding: EdgeInsets.only(left: 20, right: 20.0),
      child: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        ],
      ),
    );


    return SafeArea(
      child: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: Flex(
            direction: Axis.vertical,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 20, right: 20.0),
                //margin: EdgeInsets.only(left: 12, right: 12.0),
                //margin: EdgeInsets.all(12.0),
                child: Flex(
                  direction: Axis.vertical,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    Text(
                      LocalPeopleLocalizations
                          .of(context)
                          .titleLocation,
                      textAlign: TextAlign.left,
                      style: theme.textTheme.subtitle1,
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      color: Colors.white,
                      //padding: EdgeInsets.only(left: 12.0, right: 12.0),
                      child: EnsureVisibleWhenFocused(
                        focusNode: _focusNodeLocation,
                        child: FormBuilderTextField(
                          autovalidateMode: AutovalidateMode.disabled,
                          name: 'location',
                          autofocus: true,
                          focusNode: _focusNodeLocation,
                          style: theme.textTheme.bodyText2,
                          controller: _locationTextController,
                          decoration: InputDecoration(
                            labelText: LocalPeopleLocalizations
                                .of(context)
                                .titleAreaName,
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              autoCompleteGooglePlaceSearch(value);
                              setState(() {
                                bool _locationHasError = !(_formKey
                                    .currentState?.fields['location']
                                    ?.validate() ??
                                    false);
                              });
                            } else {
                              if (predictions.length > 0 && mounted) {
                                setState(() {
                                  predictions = [];
                                });
                              }
                            }
                          },
                          // valueTransformer: (text) => num.tryParse(text),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
                          keyboardType: TextInputType.streetAddress,
                          textInputAction: TextInputAction.next,
                          onSubmitted: (val) {
                            setState(() {
                              bool _locationHasError = !(_formKey
                                  .currentState?.fields['location']
                                  ?.validate() ??
                                  false);
                            });
                          },
                          //onEditingComplete: (() => _focusNodeJobGategory.requestFocus())
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: predictions.length > 0 ? 200 : 0,
                      width: predictions.length > 0 ? size.width : 0,
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
                              title: Text(
                                predictions[index].description,
                                style: theme.textTheme.bodyText2,
                              ),
                              onTap: () {
                                setState(() {
                                  stopGooglePlaceSearch = true;
                                  _locationTextController.text =
                                      predictions[index].description;
                                  predictions = [];

                                  FocusScopeNode currentFocus = FocusScope.of(
                                      context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  _focusNodeJobGategory.requestFocus();
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Text(
                      LocalPeopleLocalizations
                          .of(context)
                          .titleJobCategory,
                      textAlign: TextAlign.left,
                      style: theme.textTheme.subtitle1,
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      color: Colors.white,
                      //padding: EdgeInsets.only(left: 12.0, right: 12.0),
                      child: EnsureVisibleWhenFocused(
                        focusNode: _focusNodeJobGategory,
                        child: Tags(
                          key: _tagStateKey,
                          //symmetry: false,
                          //columns: 0,
                          //horizontalScroll: true,
                          alignment: WrapAlignment.start,
                          textField: TagsTextField(
                              textStyle: theme.textTheme.bodyText2,
                              width: size.width,
                              inputDecoration: InputDecoration(
                                labelText: 'Add Job Category',
                              ),
                              hintText: '',
                              constraintSuggestion: true,
                              suggestions: currentTags,
                              keyboardType: TextInputType.text,
                              //textInputAction: TextInputAction.next,
                              //width: double.infinity, padding: EdgeInsets.symmetric(horizontal: 10),
                              onSubmitted: (val) {
                                // Add item to the data source.
                                setState(() {
                                  // required
                                  var result = objTags
                                      .where((tag) =>
                                      tag.name.toLowerCase().contains(
                                          val.toLowerCase()));
                                  if (result.length > 0)
                                    job.tags.add(result.first);
                                });
                              },
                              onChanged: (val) {

                              }
                            // validator: FormBuilderValidators.compose([
                            //   FormBuilderValidators.required(context),
                            // ]),
                          ),
                          itemCount: job.tags.length,
                          // required
                          itemBuilder: (int index) {
                            final item = job.tags[index];
                            return ItemTags(
                              // Each ItemTags must contain a Key. Keys allow Flutter to
                              // uniquely identify widgets.
                              key: Key(index.toString()),
                              index: index,
                              // required
                              title: item.name,
                              //active: item.active,
                              //customData: item.customData,
                              pressEnabled: true,
                              color: Color.fromRGBO(196, 196, 196, 1),
                              activeColor: Colors.blueGrey[600],
                              singleItem: true,
                              splashColor: Colors.green,
                              textStyle: theme.inputDecorationTheme
                                  .labelStyle,
                              combine: ItemTagsCombine.withTextAfter,
                              /*image: ItemTagsImage(
                                  image: AssetImage("img.jpg") // OR NetworkImage("https://...image.png")
                              ), // OR null,
                              icon: ItemTagsIcon(
                                icon: Icons.add,
                              ),*/
                              // OR null,
                              removeButton: ItemTagsRemoveButton(
                                onRemoved: () {
                                  // Remove the item from the data source.
                                  setState(() {
                                    // required
                                    job.tags.removeAt(index);
                                  });
                                  //required
                                  return true;
                                },
                              ),
                              // OR null,
                              onPressed: (item) => print(item),
                              onLongPressed: (item) => print(item),
                            );
                          },
                        ),
                        /*child: FormBuilderTextField(
                            autovalidateMode: AutovalidateMode.disabled,
                            name: 'category',
                            focusNode: _focusNodeJobGategory,
                            style: theme.textTheme.bodyText2,
                            decoration: InputDecoration(
                              labelText: 'Job Category',
                            ),
                            onChanged: (val) {
                              if (val.isNotEmpty) {
                                setState(() {
                                  bool _jobCategoryHasError = !(_formKey
                                      .currentState?.fields['category']
                                      ?.validate() ??
                                      false);
                                });
                              }
                            },
                            onSubmitted: (val) {
                              setState(() {
                                bool _jobCategoryHasError = !(_formKey
                                    .currentState?.fields['category']
                                    ?.validate() ??
                                    false);
                              });
                            },
                            // valueTransformer: (text) => num.tryParse(text),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                            ]),
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.next,
                          ),*/
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      LocalPeopleLocalizations
                          .of(context)
                          .titleSuggestions,
                      textAlign: TextAlign.left,
                      style: theme.textTheme.caption,
                    ),
                    SizedBox(height: 10.0),
                    TagsViewWidget(
                      tags: [
                        'Window Cleaner',
                        'Handy Man',
                      ],
                    ),
                    SizedBox(height: 30.0),
                    Text(
                      LocalPeopleLocalizations
                          .of(context)
                          .titleJobDescription,
                      textAlign: TextAlign.left,
                      style: theme.textTheme.subtitle1,
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      color: Colors.white,
                      height: 200,
                      //padding: EdgeInsets.only(left: 12.0, right: 12.0),
                      child: EnsureVisibleWhenFocused(
                        focusNode: _focusNodeJobDesc,
                        child: FormBuilderTextField(
                          autovalidateMode: AutovalidateMode.disabled,
                          name: 'description',
                          focusNode: _focusNodeJobDesc,
                          expands: true,
                          minLines: null,
                          maxLines: null,
                          style: theme.textTheme.bodyText2,
                          decoration: InputDecoration(
                            labelText: 'Job Description',
                          ),
                          onChanged: (val) {
                            if (val.isNotEmpty) {
                              setState(() {
                                bool _jobDescriptionHasError = !(_formKey
                                    .currentState?.fields['description']
                                    ?.validate() ??
                                    false);
                              });
                            }
                          },
                          onSubmitted: (val) {
                            setState(() {
                              bool _jobDescriptionHasError = !(_formKey
                                  .currentState?.fields['description']
                                  ?.validate() ??
                                  false);
                            });
                          },
                          // valueTransformer: (text) => num.tryParse(text),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: FormBuilderImagePicker(
                        name: 'images',
                        initialValue: [],
                        //job.images,
                        focusNode: _focusNodeImages,
                        maxHeight: 90,
                        maxWidth: size.width / 4,
                        imageQuality: 85,
                        previewMargin: EdgeInsets.only(right: 8.0),
                        decoration: InputDecoration(
                          //labelText: 'Attach Photos'
                        ),
                        maxImages: maxImages,
                        validator: FormBuilderValidators.compose([
                          //FormBuilderValidators.required(context),
                        ]),
                        //valueTransformer: (val) => val.toString(),
                        onChanged: (val) {
                          print('onChanged');
                          print(val);
                          setState(() {
                            maxImages = val.length + 1;
                          });
                        },
                        onSaved: (val) {
                          print('onSaved');
                          print(val);
                          //job.images = val != null ? val.cast<File>() : [];
                          //print(job.images);
                        },
                        onReset: () {},
                        onImage: (image) {
                          print('onImage');
                        },
                        placeholderImage: Image
                            .asset(
                            'packages/local_people_core/assets/images/local-people-logo.png')
                            .image,
                      ),
                    ),
                    /*FormBuilderImagePicker (
                          Future<CloudStorageResult> uploadImage(
                          {@required BuildContext context,
                          @required File imageToUpload,
                          @required String title,
                          @required String requestId}) async {
                      final metadata = SettableMetadata(
                      contentType: lookupMimeType(title),
                      customMetadata: {'requestId': requestId});

                      String url;

                      var imageFileName = title;

                      final Reference firebaseStorageRef =
                      FirebaseStorage.instance.ref().child("images/${title}");

                      UploadTask uploadTask = firebaseStorageRef.putFile(imageToUpload, metadata);

                      return uploadTask.whenComplete(() async {
                      var downloadUrl = await firebaseStorageRef.getDownloadURL();

                      return CloudStorageResult(
                      imageUrl: downloadUrl,
                      imageFileName: imageFileName,
                      );
                      }).catchError((onError) {
                      print(onError);
                      return null;
                      });
                      }
                      )*/
                    // Container (
                    //   child: ImagesViewWidget(images: ['https://media-exp1.licdn.com/dms/image/C4E0BAQGCMeC6rK_H0g/company-logo_200_200/0/1594223715044?e=1626912000&v=beta&t=S4tF6F2mgbv_Zt8nd-TaGql7dhWc4xFJbKmDy8oc9uY',
                    //     'https://media-exp1.licdn.com/dms/image/C4E0BAQGCMeC6rK_H0g/company-logo_200_200/0/1594223715044?e=1626912000&v=beta&t=S4tF6F2mgbv_Zt8nd-TaGql7dhWc4xFJbKmDy8oc9uY',
                    //     'https://media-exp1.licdn.com/dms/image/C4E0BAQGCMeC6rK_H0g/company-logo_200_200/0/1594223715044?e=1626912000&v=beta&t=S4tF6F2mgbv_Zt8nd-TaGql7dhWc4xFJbKmDy8oc9uY']),
                    // ),
                    // FormBuilderImagePicker(
                    //   name: 'photos',
                    //   decoration: const InputDecoration(labelText: 'Pick Photos'),
                    //   maxImages: 1,
                    // ),
                    SizedBox(height: 30.0),
                    Flex(
                        direction: Axis.vertical,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            LocalPeopleLocalizations
                                .of(context)
                                .titleBudget,
                            textAlign: TextAlign.left,
                            style: theme.textTheme.subtitle1,
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            color: Colors.white,
                            //padding: EdgeInsets.only(left: 12.0, right: 12.0),
                            width: size.width / 2,
                            child: EnsureVisibleWhenFocused(
                              focusNode: _focusNodeBudget,
                              child: FormBuilderTextField(
                                autovalidateMode: AutovalidateMode.disabled,
                                focusNode: _focusNodeBudget,
                                name: 'budget',
                                style: theme.textTheme.bodyText2,
                                decoration: InputDecoration(
                                  labelText: 'Amount',
                                ),
                                onChanged: (val) {
                                  if (val.isNotEmpty) {
                                    setState(() {
                                      bool _budgetHasError = !(_formKey
                                          .currentState?.fields['budget']
                                          ?.validate() ??
                                          false);
                                    });
                                  }
                                },
                                onSubmitted: (val) {
                                  setState(() {
                                    bool _budgetHasError = !(_formKey
                                        .currentState?.fields['budget']
                                        ?.validate() ??
                                        false);
                                  });
                                },
                                // valueTransformer: (text) => num.tryParse(text),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context),
                                  FormBuilderValidators.numeric(context),
                                ]),
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                          ),
                        ]
                    ),
                    SizedBox(height: 30.0),
                    Text(
                      LocalPeopleLocalizations
                          .of(context)
                          .titleRequestedTimeframe,
                      textAlign: TextAlign.left,
                      style: theme.textTheme.subtitle1,
                    ),
                    SizedBox(height: 10.0),
                    MaterialSegmentedControl(
                      children: _requestedTimeframeChildren,
                      selectionIndex: _requestedTimeframeCurrentSelection,
                      borderColor: Colors.white,
                      selectedColor: Color.fromRGBO(131, 131, 131, 1),
                      unselectedColor: Colors.white,
                      borderRadius: 5.0,
                      horizontalPadding: EdgeInsets.only(
                          left: 2.0, right: 2.0),
                      onSegmentChosen: (index) {
                        setState(() {
                          _requestedTimeframeCurrentSelection = index;
                        });
                      },
                    ),
                    SizedBox(height: 30.0),
                    /*Container(
                        color: Colors.white,
                        width: _requestedTimeframeCurrentSelection == 0 ? size.width : 0,
                        //padding: EdgeInsets.only(left: 12.0, right: 12.0),
                        height: _requestedTimeframeCurrentSelection == 0 ? 50 : 0,
                      ),
                      Container(
                        color: Colors.white,
                        width: _requestedTimeframeCurrentSelection == 1 ? size.width : 0,
                        //padding: EdgeInsets.only(left: 12.0, right: 12.0),
                        height: _requestedTimeframeCurrentSelection == 1 ? 50 : 0,
                      ),*/
                    Container(
                      color: _requestedTimeframeCurrentSelection == 2 ? Colors
                          .white : theme.backgroundColor,
                      width: _requestedTimeframeCurrentSelection == 2 ? size
                          .width : 0,
                      //padding: EdgeInsets.only(left: 12.0, right: 12.0),
                      //height: _requestedTimeframeCurrentSelection == 2 ? 50 : 0,
                      height: 60,
                      child: _requestedTimeframeCurrentSelection != 2
                          ? Container()
                          : Flex(
                        direction: Axis.horizontal,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: EnsureVisibleWhenFocused(
                              focusNode: _focusNodeTimeframeDay,
                              child: FormBuilderTextField(
                                autovalidateMode: AutovalidateMode.disabled,
                                focusNode: _focusNodeTimeframeDay,
                                name: 'timeFrameDay',
                                style: theme.textTheme.bodyText2,
                                textAlign: TextAlign.center,
                                //decoration: InputDecoration(
                                //labelText: 'DD',
                                //),
                                onChanged: (val) {
                                  setState(() {
                                    bool _timeFrameDayHasError = !(_formKey
                                        .currentState?.fields['timeFrameDay']
                                        ?.validate() ??
                                        false);
                                  });
                                },
                                // valueTransformer: (text) => num.tryParse(text),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context),
                                  FormBuilderValidators.numeric(context),
                                  FormBuilderValidators.min(context, 1),
                                  FormBuilderValidators.max(context, 31),
                                ]),
                                initialValue: DateFormat('dd').format(
                                    DateTime.now()),
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: EnsureVisibleWhenFocused(
                              focusNode: _focusNodeTimeframeMonth,
                              child: FormBuilderTextField(
                                autovalidateMode: AutovalidateMode.disabled,
                                focusNode: _focusNodeTimeframeMonth,
                                name: 'timeFrameMonth',
                                style: theme.textTheme.bodyText2,
                                textAlign: TextAlign.center,
                                //decoration: InputDecoration(
                                //    labelText: 'MM',
                                //),
                                onChanged: (val) {
                                  setState(() {
                                    bool _timeFrameMonthHasError = !(_formKey
                                        .currentState
                                        ?.fields['timeFrameMonth']
                                        ?.validate() ??
                                        false);
                                  });
                                },
                                // valueTransformer: (text) => num.tryParse(text),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context),
                                  FormBuilderValidators.numeric(context),
                                  FormBuilderValidators.min(context, 1),
                                  FormBuilderValidators.max(context, 12),
                                ]),
                                initialValue: DateFormat('MM').format(
                                    DateTime.now()),
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: EnsureVisibleWhenFocused(
                              focusNode: _focusNodeTimeframeYear,
                              child: FormBuilderTextField(
                                autovalidateMode: AutovalidateMode.disabled,
                                focusNode: _focusNodeTimeframeYear,
                                name: 'timeFrameYear',
                                style: theme.textTheme.bodyText2,
                                textAlign: TextAlign.center,
                                //decoration: InputDecoration(
                                //    labelText: 'YY',
                                //),
                                onChanged: (val) {
                                  setState(() {
                                    bool _timeFrameYearHasError = !(_formKey
                                        .currentState?.fields['timeFrameYear']
                                        ?.validate() ??
                                        false);
                                  });
                                },
                                // valueTransformer: (text) => num.tryParse(text),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context),
                                  FormBuilderValidators.numeric(context),
                                  FormBuilderValidators.min(context, 21),
                                  FormBuilderValidators.max(context, 99),
                                ]),
                                initialValue: DateFormat('yy').format(
                                    DateTime.now()),
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: FormBuilderDropdown<String>(
                              name: 'morningAfternoon',
                              style: theme.textTheme.bodyText2,
                              allowClear: false,
                              initialValue: 'Morning',
                              validator: FormBuilderValidators.compose(
                                  [FormBuilderValidators.required(context)]),
                              items: <String>[
                                'Morning',
                                'Afternoon',
                              ]
                                  .map((morningAfternoon) =>
                                  DropdownMenuItem(
                                    value: morningAfternoon,
                                    child: Center(
                                      child: Text(
                                        morningAfternoon,
                                        style: theme.textTheme.caption,
                                      ),
                                    ),
                                  ))
                                  .toList(),
                              onChanged: (val) {
                                print(val);
                                setState(() {
                                  bool _morningAfternoonHasError = !(_formKey
                                      .currentState
                                      ?.fields['morningAfternoon']
                                      ?.validate() ??
                                      false);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Text(
                      LocalPeopleLocalizations
                          .of(context)
                          .titleTimeToRespond,
                      textAlign: TextAlign.left,
                      style: theme.textTheme.subtitle1,
                    ),
                    SizedBox(height: 10.0),
                    MaterialSegmentedControl(
                      children: _timeToRespondChildren,
                      selectionIndex: _timeToRespondCurrentSelection,
                      borderColor: Colors.white,
                      selectedColor: Color.fromRGBO(131, 131, 131, 1),
                      unselectedColor: Colors.white,
                      borderRadius: 5.0,
                      horizontalPadding: EdgeInsets.only(
                          left: 2.0, right: 2.0),
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
                //color: Colors.white,
                padding: EdgeInsets.all(12.0),
                margin: EdgeInsets.only(left: 12, right: 12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3.0),
                ),
                //margin: EdgeInsets.all(12.0),
                child: Flex(
                  direction: Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      //padding: EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Text(
                        LocalPeopleLocalizations
                            .of(context)
                            .titlePostEdits,
                        textAlign: TextAlign.left,
                        style: theme.textTheme.subtitle1,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    LocalPeopleLocalizations
                                        .of(context)
                                        .btnTitleCancel,
                                    style: theme.textTheme.button,
                                  ),
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
                                    LocalPeopleLocalizations
                                        .of(context)
                                        .btnTitlePost,
                                    style: theme.textTheme.button,
                                  ),
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
    _formKey.currentState.save();
    if (_formKey.currentState.validate()) {
      print(_formKey.currentState.value);
      job.location = loc.Location(
          id: 0,
          name: _formKey.currentState.value['location'],
      );
      job.description = _formKey.currentState.value['description'];
      job.title = _formKey.currentState.value['description'];
      //job.tags = [_formKey.currentState.value['category']];
      job.budget = _formKey.currentState.value['budget'];
      job.date = DateTime.now();
      job.minutesLeft = 120;
      job.preview = _formKey.currentState.value['description'];
      job.images = _formKey.currentState.value['images'].cast<File>();
      job.client_id = 1;

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Processing Data')));

      AppRouter.pushPage(
          context,
          JobPreviewScreen(
            //job: demeJobs[0],
            job: job,
            profile: Profile.demo,
          ));
    } else {
      print(_formKey.currentState.value);
    }
  }
}

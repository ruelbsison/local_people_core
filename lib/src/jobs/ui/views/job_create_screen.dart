import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/jobs.dart';
import '../../domain/entities/job.dart';
import '../../domain/entities/profile.dart';
import '../widgets/tags_view_widget.dart';
import 'job_preview_screen.dart';
import 'package:google_place/google_place.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_tags/flutter_tags.dart';
import '../widgets/form_builder_image_picker.dart';
import '../../domain/entities/tag.dart';
import '../../domain/entities/location.dart' as loc;
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import '../blocs/tag_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:local_people_core/profile.dart';

class JobCreateScreen extends StatefulWidget {
  @override
  _JobCreateScreenState createState() => _JobCreateScreenState();
}

class _JobCreateScreenState extends State<JobCreateScreen>{
    //with WidgetsBindingObserver, AutomaticKeepAliveClientMixin {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey();

  Job job;
  //AutocompletePrediction selectedLocation;
  List<Tag> objTags;
  List<String> currentTags = [];

  GooglePlace googlePlace;
  //List<AutocompletePrediction> predictions = [];
  List<SearchResult> googlePlaceSearchResults = [];
  SearchResult selectedLocation;
  //final TextEditingController _locationTextController = TextEditingController();

  int _requestedTimeframeCurrentSelection = 0;
  int _timeToRespondCurrentSelection = 0;

  FocusNode _focusNodeLocation = new FocusNode();
  FocusNode _focusNodeJobGategory = new FocusNode();
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

  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
// Allows you to get a list of all the ItemTags
  _getAllItem() {
    List<Item> lst = _tagStateKey.currentState?.getAllItem;
    if (lst != null)
      lst.where((a) => a.active == true).forEach((a) => print(a.title));
  }

  //@override
  //bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    //SchedulerBinding.instance.addPostFrameCallback(
    //      (_) => Provider.of<TagProvider>(context, listen: false).getTags(),
    //);

    String apiKey =
        'AIzaSyDas3RPqegAcudGgkX4xlykHztH1nZCfvo'; //DotEnv().env['API_KEY'];
    googlePlace = GooglePlace(apiKey);
    job = Job.empty();

    // objTags.add(Tag(id: 0, name: 'Handy Man'));
    // objTags.add(Tag(id: 1, name: 'Window Cleaner'));
    // currentTags.add('Handy Man');
    // currentTags.add('Window Cleaner');

    _focusNodeLocation.addListener(() {
      if (!_focusNodeLocation.hasFocus) {
        //context.read<MyFormBloc>().add(EmailUnfocused());
        //FocusScope.of(context).requestFocus(_focusNodeJobGategory);
      } else {
        setState(() {
          //_locationTextController.clear();
          stopGooglePlaceSearch = false;
        });
      }
    });
    /*_focusNodeJobGategory.addListener(() {
      if (!_focusNodeJobGategory.hasFocus) {
        FocusScope.of(context).requestFocus(_focusNodeJobInfo);
      }
    });
    _focusNodeJobInfo.addListener(() {
      if (!_focusNodeJobInfo.hasFocus) {
        FocusScope.of(context).requestFocus(_focusNodeJobDesc);
      }
    });
    _focusNodeJobDesc.addListener(() {
      if (!_focusNodeJobDesc.hasFocus) {
        FocusScope.of(context).requestFocus(_focusNodeBudget);
      }
    });
    _focusNodeBudget.addListener(() {
      if (!_focusNodeBudget.hasFocus) {
        FocusScope.of(context).requestFocus(_focusNodeTimeframeDay);
      }
    });
    _focusNodeTimeframeDay.addListener(() {
      if (!_focusNodeTimeframeDay.hasFocus) {
        FocusScope.of(context).requestFocus(_focusNodeTimeframeMonth);
      }
    });
    _focusNodeTimeframeMonth.addListener(() {
      if (!_focusNodeTimeframeMonth.hasFocus) {
        FocusScope.of(context).requestFocus(_focusNodeTimeframeYear);
      }
    });
    _focusNodeTimeframeYear.addListener(() {
      if (!_focusNodeTimeframeYear.hasFocus) {
        FocusScope.of(context).requestFocus(_focusNodeTimeframeYear);
      }
    });*/
    /*_focusNodeLocation.addListener(() {
      if (_focusNodeLocation.hasFocus) {
        setState(() {
          _locationTextController.clear();
          stopGooglePlaceSearch = false;
        });
      }
    });*/
    //requestPermission();
  }

  @override
  void dispose() {
    _focusNodeLocation.dispose();
    _focusNodeJobGategory.dispose();
    _focusNodeJobInfo.dispose();
    _focusNodeJobDesc.dispose();
    _focusNodeBudget.dispose();
    _focusNodeTimeframeDay.dispose();
    _focusNodeTimeframeMonth.dispose();
    _focusNodeTimeframeYear.dispose();
    _focusNodeImages.dispose();
    super.dispose();
  }

  void googlePlaceTextSearch(String query) async {
    if (stopGooglePlaceSearch) {
      return;
    }
    try {
      var result = await googlePlace.search.getTextSearch(query);
      if (result != null && result.results != null && mounted) {
        setState(() {
          googlePlaceSearchResults = result.results;
        });
      }
    } catch (error) {
      setState(() {
        googlePlaceSearchResults = [];
      });
    }
  }

  /*void autoCompleteGooglePlaceSearch(String value) async {
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

  Future<Geometry> agetGooglePlaceGeometry(String placeId) async {
    try {
      DetailsResponse result = await googlePlace.details.get(placeId);
      if  (result != null)
        return result.result.geometry;
      else
        return null;
    } catch (error) {

    }
  }

  Future<Uint8List> getGooglePlacePhoto(String placeId) async {
    Uint8List result;
    try {
      result = await googlePlace.photos.get(placeId, 220, 220);
    } catch (error) {
      print(error);
    }
    return result;
  }*/

  @override
  Widget build(BuildContext context) {
    //super.build(context);
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
      // body: BlocProvider.value(
      //   value: BlocProvider.of<TagBloc>(context),
      //   child: buildLBody(context),
      // ),
    );
  }

  AppBarWidget buildAppBar(BuildContext context) {
    final theme = Theme.of(context);
    return AppBarWidget(
      appBarPreferredSize: Size.fromHeight(150.0),
      title: LocalPeopleLocalizations.of(context).menuTitlePostJob,
      appBar: AppBar(),
      actions: <Widget>[
        OutlinedButton(
          child: Text(
            LocalPeopleLocalizations.of(context).btnTitleCancel,
            style: theme.textTheme.button,
            textAlign: TextAlign.center,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
      // actions: <Widget>[
      //   Container(
      //     padding: EdgeInsets.only(right: 14.0),
      //     child: ElevatedButton(
      //       child: Text(
      //         LocalPeopleLocalizations.of(context).btnTitleCancel,
      //         style: TextStyle(
      //           fontSize: 14,
      //           fontWeight: FontWeight.normal,
      //         ),
      //       ),
      //       onPressed: () {
      //         //AppRouter.pushPage(context, JobCreateScreen());
      //         Navigator.pop(context);
      //       },
      //     ),
      //     alignment: Alignment.center,
      //   )
      // ],
    );
  }

  Widget buildJobCategoryFormEntry(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(left: 20, right: 20.0),
      color: Color.fromRGBO(239, 244, 246, 1),
      child: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 30.0),
          Text(
            LocalPeopleLocalizations.of(context).titleJobCategory,
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
                    textCapitalization: TextCapitalization.words,
                    inputDecoration: InputDecoration(
                      labelText: 'Add Job Category',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    hintText: '',
                    constraintSuggestion: true,
                    suggestions: currentTags, //currentTags,
                    keyboardType: TextInputType.text,
                    suggestionTextColor: theme.textTheme.bodyText1.color,
                    //textInputAction: TextInputAction.next,
                    //width: double.infinity, padding: EdgeInsets.symmetric(horizontal: 10),
                    onSubmitted: (val) {
                      // Add item to the data source.
                      setState(() {
                        int index = objTags.indexWhere((tag) =>
                          tag.compareTo(val.toLowerCase()) == 0 ? true : false);
                        // required
                         //var result = objTags.where((tag) =>
                         //tag.compareTo(val.toLowerCase()) == 0 ? true : false);
                         //var result = List.generate(objTags.length, (index) => objTags[index].compareTo(val.toLowerCase()) == 0 ? objTags[index] : null);
                        // if (result.length > 0) job.tags.add(result.first);
                        bool exists = job.tags.contains(val);
                        if (exists == false && index >= 0) {
                          job.tags.add(objTags.elementAt(index));
                        }
                      });
                    },
                    onChanged: (val) {}
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
                    active: true,
                    //customData: item.customData,
                    pressEnabled: true,
                    color: Color.fromRGBO(196, 196, 196, 1),
                    activeColor: Colors.blueGrey[600],
                    singleItem: true,
                    splashColor: Colors.green,
                    textStyle: theme.inputDecorationTheme.labelStyle,
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
            ),
          ),
        ],
      ),
    );
  }

  Widget buildJobCategorySuggestionFormEntry(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(left: 20, right: 20.0),
      color: Color.fromRGBO(239, 244, 246, 1),
      child: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 30.0),
          Container(
            color: Color.fromRGBO(239, 244, 246, 1),
            child: Text(
              LocalPeopleLocalizations.of(context).titleSuggestions,
              textAlign: TextAlign.left,
              style: theme.textTheme.overline,
            ),
          ),
          SizedBox(height: 10.0),
          TagsViewWidget(
            //tagBackgroundColor: Color.fromRGBO(239, 244, 246, 1),
            tags: objTags,
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentedTab(BuildContext context, String title) {
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

  Widget buildBody(BuildContext context) {
    try {
      List<Tag> tags = sl<List<Tag>>();
      if (tags == null || tags.length == 0) {
        context.read<TagBloc>().add(LoadTagsEvent());
      }
      else {
        objTags = tags;
        currentTags = List.generate(objTags.length, (index) => objTags[index].name);
        return buildFormBody(context);
      }
    } catch(e) {
      print(e.toString());
      context.read<TagBloc>().add(LoadTagsEvent());
    }

    context.read<TagBloc>().add(LoadTagsEvent());
    return BlocProvider.value(
      value: BlocProvider.of<TagBloc>(context),
      child: BlocConsumer<TagBloc, TagState>(
          listenWhen: (previous, current) {
            // return true/false to determine whether or not
            // to invoke listener with state
            // List<Tag> tags = sl<List<Tag>>();
            return false;
          },
          listener: (context, state) {
            // do stuff here based on BlocA's state
          },
          buildWhen: (previous, current) {
            // return true/false to determine whether or not
            // to rebuild the widget with state
            if (objTags != null && objTags.length > 0)
              return false;

            try {
              List<Tag> tags = sl<List<Tag>>();
              if (tags != null && tags.length > 0)
                return false;
            } catch(e) {
            }

            if (previous is TagsLoading &&
                current is TagsLoaded) {
              return true;
            } else if (previous is TagInitial &&
                current is TagsLoading) {
              return true;
            }
            return false;
          },
          builder: (context, state) {
            // return widget here based on BlocA's state
            if (state is TagsLoaded) {
              if (state.tags != null && state.tags.length > 0) {
                //locatorAddListTag(state.tags);
                List<Tag> tags = sl<List<Tag>>();
                tags.clear();
                tags.addAll(state.tags);

                objTags = state.tags;
              } else {
                objTags = Tag.defaultTags;
              }
              currentTags = List.generate(objTags.length, (index) => objTags[index].name);
              return buildFormBody(context);
            } else if (state is LoadTagsFailed) {
              return ErrorWidget('Error $state');
            } else if (state is TagsLoading) {
              return LoadingWidget();
            }
            return LoadingWidget();
          }
      ),
    );
  }

  Widget buildFormBody(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    List<String> _timeToRespondOptions = [
      LocalPeopleLocalizations.of(context).subTitle24Hrs,
      LocalPeopleLocalizations.of(context).subTitle48Hrs,
      LocalPeopleLocalizations.of(context).subTitleThisWeek,
    ];
    Map<int, Widget> _timeToRespondChildren = {
      0: _buildSegmentedTab(context, LocalPeopleLocalizations.of(context).subTitle24Hrs),
      1: _buildSegmentedTab(context, LocalPeopleLocalizations.of(context).subTitle48Hrs),
      2: _buildSegmentedTab(context,
          LocalPeopleLocalizations.of(context).subTitleThisWeek),
    };
    Map<int, Widget> _requestedTimeframeChildren = {
      0: _buildSegmentedTab(context, LocalPeopleLocalizations.of(context).subTitleASAP),
      1: _buildSegmentedTab(context,
          LocalPeopleLocalizations.of(context).subTitleThisWeek),
      2: _buildSegmentedTab(context,
          LocalPeopleLocalizations.of(context).subTitleSpecific),
    };

    final locationFormEntry = Container(
      padding: EdgeInsets.only(left: 20, right: 20.0),
      color: Color.fromRGBO(239, 244, 246, 1),
      child: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10.0),
          Text(
            LocalPeopleLocalizations.of(context).titleLocation,
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
                //controller: _locationTextController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  labelText: LocalPeopleLocalizations.of(context).titleAreaName,
                  //hasFloatingPlaceholder: false,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    //autoCompleteGooglePlaceSearch(value);
                    googlePlaceTextSearch(value);
                    setState(() {
                      bool _locationHasError = !(_formKey
                              .currentState?.fields['location']
                              ?.validate() ??
                          false);
                    });
                  } else {
                    // if (predictions.length > 0 && mounted) {
                    //   setState(() {
                    //     predictions = [];
                    //   });
                    // }
                    if (googlePlaceSearchResults.length > 0 && mounted) {
                      setState(() {
                        googlePlaceSearchResults = [];
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
            //height: predictions.length > 0 ? 200 : 0,
            //width: predictions.length > 0 ? size.width : 0,
            height: googlePlaceSearchResults.length > 0 ? 200 : 0,
            width: googlePlaceSearchResults.length > 0 ? size.width : 0,
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListView.builder(
                //itemCount: predictions.length,
                itemCount: googlePlaceSearchResults.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Icon(
                        Icons.pin_drop,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      //predictions[index].structuredFormatting.mainText,
                      googlePlaceSearchResults[index].name,
                      style: theme.textTheme.bodyText2,
                    ),
                    onTap: () {
                      setState(() {
                        stopGooglePlaceSearch = true;
                        selectedLocation = googlePlaceSearchResults[index];
                        //_locationTextController.text =
                        //    googlePlaceSearchResults[index].name;
                        _formKey.currentState.fields['location'].didChange(selectedLocation.name);
                        googlePlaceSearchResults = [];

                        //FocusScope.of(context).requestFocus(_focusNodeJobGategory);
                        //FocusScopeNode currentFocus = FocusScope.of(context);
                        //if (!currentFocus.hasPrimaryFocus) {
                        //  currentFocus.unfocus();
                        //}
                        //_focusNodeJobGategory.requestFocus();
                      });
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );

    //final jobCategoryFormEntry = buildJobCategory(context);
    final jobCategoryFormEntry = buildJobCategoryFormEntry(context);
    final jobCategorySuggestionFormEntry = buildJobCategorySuggestionFormEntry(context);
    final jobDescriptionFormEntry = Container(
      padding: EdgeInsets.only(left: 20, right: 20.0),
      color: Color.fromRGBO(239, 244, 246, 1),
      child: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 30.0),
          Text(
            LocalPeopleLocalizations.of(context).titleJobDescription,
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
                textAlignVertical: TextAlignVertical.top,
                focusNode: _focusNodeJobDesc,
                expands: true,
                minLines: null,
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
                style: theme.textTheme.bodyText2,
                decoration: InputDecoration(
                  labelText: 'Job Description',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
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
              maxWidth: size.width,
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
              placeholderImage: Svg(
                'packages/local_people_core/assets/images/add-photo-icon.svg',
                size: Size(70, 70),
              ),
              /*placeholderImage: Image
                  .asset(
                  'packages/local_people_core/assets/images/local-people-logo.png')
                  .image,*/
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
        ],
      ),
    );

    final budgetFormEntry = Container(
      padding: EdgeInsets.only(left: 20, right: 20.0),
      color: Color.fromRGBO(239, 244, 246, 1),
      child: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 30.0),
          Flex(
              direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  LocalPeopleLocalizations.of(context).titleBudget,
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
                        floatingLabelBehavior: FloatingLabelBehavior.never,
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
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ),
              ]),
          //SizedBox(height: 30.0),
        ],
      ),
    );

    final requestedTimeFrameFormEntry = Container(
      padding: EdgeInsets.only(left: 20, right: 20.0),
      color: Colors.white,
      child: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 30.0),
          Text(
            LocalPeopleLocalizations.of(context).titleRequestedTimeframe,
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
            horizontalPadding: EdgeInsets.only(left: 2.0, right: 2.0),
            onSegmentChosen: (index) {
              setState(() {
                _requestedTimeframeCurrentSelection = index;
              });
            },
          ),
          SizedBox(height: 20.0),
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
            color: _requestedTimeframeCurrentSelection == 2
                ? Colors.white
                : theme.backgroundColor,
            width: _requestedTimeframeCurrentSelection == 2 ? size.width : 0,
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
                            initialValue:
                                DateFormat('dd').format(DateTime.now()),
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
                                        .currentState?.fields['timeFrameMonth']
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
                            initialValue:
                                DateFormat('MM').format(DateTime.now()),
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
                            initialValue:
                                DateFormat('yy').format(DateTime.now()),
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
                              .map((morningAfternoon) => DropdownMenuItem(
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
                                      .currentState?.fields['morningAfternoon']
                                      ?.validate() ??
                                  false);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );

    final timeToRespondFormEntry = Container(
      padding: EdgeInsets.only(left: 20, right: 20.0),
      color: Colors.white,
      child: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 30.0),
          Text(
            LocalPeopleLocalizations.of(context).titleTimeToRespond,
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
            horizontalPadding: EdgeInsets.only(left: 2.0, right: 2.0),
            onSegmentChosen: (index) {
              setState(() {
                _timeToRespondCurrentSelection = index;
              });
            },
          ),
        ],
      ),
    );

    final postEditsFormEntry = Container(
      //padding: EdgeInsets.only(left: 20, right: 20.0),
      //color: Colors.white,
      decoration: BoxDecoration(
          border: Border.all(color: Color.fromRGBO(239, 244, 246, 1), width: 5),
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,),
      child: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10.0),
          Container(
            //color: Colors.white,
            padding: EdgeInsets.all(12.0),
            //margin: EdgeInsets.only(left: 12, right: 12.0),
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
                    LocalPeopleLocalizations.of(context).titlePostEdits,
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
                            padding: EdgeInsets.only(left: 12.0, right: 12.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromRGBO(239, 244, 246, 1),
                                onPrimary: Color.fromRGBO(170, 186, 205, 1),
                              ),
                              onPressed: () => _cancelJob(context),
                              child: Text(
                                LocalPeopleLocalizations.of(context)
                                    .btnTitleCancel,
                                style: theme.textTheme.button,
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
                                primary: Color.fromRGBO(239, 244, 246, 1),
                                onPrimary: Color.fromRGBO(170, 186, 205, 1),
                              ),
                              onPressed: () => _postJob(context),
                              child: Text(
                                LocalPeopleLocalizations.of(context)
                                    .btnTitlePost,
                                style: theme.textTheme.button,
                              ),
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
    );

    return SafeArea(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: FormBuilder(
          key: _formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: Flex(
            direction: Axis.vertical,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              locationFormEntry,
              SizedBox(height: 30.0),
              jobCategoryFormEntry,
              SizedBox(height: 30.0),
              jobCategorySuggestionFormEntry,
              SizedBox(height: 30.0),
              jobDescriptionFormEntry,
              SizedBox(height: 30.0),
              budgetFormEntry,
              SizedBox(height: 30.0),
              requestedTimeFrameFormEntry,
              SizedBox(height: 30.0),
              timeToRespondFormEntry,
              SizedBox(height: 30.0),
              postEditsFormEntry,
            ],
          ),
        ),
      ),
    );
  }

  void _cancelJob(BuildContext context) {
    Navigator.pop(context);
  }

  void _postJob(BuildContext context) async {
    _formKey.currentState.save();
    if (_formKey.currentState.validate()) {
      print(_formKey.currentState.value);

      job.images = List<String>();
      final appDir = await getTemporaryDirectory(); //getApplicationDocumentsDirectory();
      await _formKey.currentState.value['images'].forEach((imageFile) async {
        final fileName = basename(imageFile.path);
        final attachFileName = '${appDir.path}/$fileName';
        job.images.add(attachFileName);
        //if (await io.File(attachFileName).exists() == false) {
          try {
            final savedImage = await imageFile.copy(attachFileName);
          } on Exception catch( e, s ) {
            print('imageFile.copy error $e, $s');
          }
        //}

      });

      String url = '';
      if (selectedLocation != null && selectedLocation.photos != null) {
        try {
          var urls = selectedLocation.photos[0].htmlAttributions.where((attr) => attr.toLowerCase().contains('http'.toLowerCase()));
          if (urls.length > 0) {
            url = urls.first.replaceAll('<a href=\"', '');
            int last = url.indexOf('"');
            url = url.substring(0, last);
          }
        } catch(e) {
        }
      }

      if (selectedLocation != null) {
        job.location = loc.Location(
          id: 0,
          name: _formKey.currentState.value['location'],
          lat: selectedLocation.geometry.location.lat,
          long: selectedLocation.geometry.location.lng,
          address: selectedLocation.formattedAddress,
          photoUrl: url.length > 0 ? url : '',
        );
      }

      if (job.tags != null && job.tags.length > 0) {
        job.title = job.tags[0].name;
      }
      if (job.location != null && job.location.name != null) {
        if (job.title!= null && job.title.length > 0 ) {
          job.title = job.title + ' - ' + job.location.name;
        } else {
          job.title = 'Job - ' + job.location.name;
        }
      }
      job.description = _formKey.currentState.value['description'];
      if (job.title== null || job.title.length == 0 ) {
        job.title = _formKey.currentState.value['description'];
      }
      //job.tags = [_formKey.currentState.value['category']];
      job.budget = _formKey.currentState.value['budget'];
      if (_requestedTimeframeCurrentSelection == 0) {
        job.date = DateTime.now();
      } else if (_requestedTimeframeCurrentSelection == 1) {

      } else if (_requestedTimeframeCurrentSelection == 2) {
        String formattedString = '20' +  _formKey.currentState.value['timeFrameYear'] + '-'
            + _formKey.currentState.value['timeFrameMonth'] + '-' +
            _formKey.currentState.value['timeFrameDay'];
        job.date = DateTime.parse(formattedString);
      }
      job.minutesLeft = 120;
      job.preview = _formKey.currentState.value['description'];
      //job.images = _formKey.currentState.value['images'].cast<File>();
      try {
        ClientProfile clientProfile = sl<ClientProfile>();
        if (clientProfile != null) {
          job.clientId = clientProfile.id;
          job.location.clientId = clientProfile.id;
        }
      } catch (e) {
        print(e.toString());
      }

      //print(job);
      //ScaffoldMessenger.of(context)
      //    .showSnackBar(SnackBar(content: Text('Processing Data')));

      //Geometry geometry = await agetGooglePlaceGeometry(selectedLocation.placeId);
      //Uint8List locationImageData = await getGooglePlacePhoto(selectedLocation.placeId);
      AppRouter.pushPage(
          context,
          DialogManager(
            child: JobPreviewScreen(
              job: job,
            ),
          ),
      );
    } else {
      print(_formKey.currentState.value);
    }
  }
}



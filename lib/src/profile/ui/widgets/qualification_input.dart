import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_people_core/jobs.dart';
import 'package:local_people_core/core.dart';
import 'package:flutter_tags/flutter_tags.dart';

class QualificationInput extends StatelessWidget {
  List<Tag> objTags = [];
  List<String> currentTags = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    currentTags.add('Handy Man');
    currentTags.add('Window Cleaner');
    return Card(
      elevation: 2,
      color: Color.fromRGBO(255, 255, 255, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
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
              //focusNode: _focusNodeJobGategory,
              child: Tags(
                //key: _tagStateKey,
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
                    ),
                    hintText: '',
                    constraintSuggestion: true,
                    suggestions: currentTags,
                    keyboardType: TextInputType.text,
                    suggestionTextColor: theme.textTheme.bodyText1.color,
                    //textInputAction: TextInputAction.next,
                    //width: double.infinity, padding: EdgeInsets.symmetric(horizontal: 10),
                    // onSubmitted: (val) {
                    //   // Add item to the data source.
                    //   setState(() {
                    //     // required
                    //     var result = objTags.where((tag) =>
                    //         tag.name.toLowerCase().contains(val.toLowerCase()));
                    //     if (result.length > 0) job.tags.add(result.first);
                    //   });
                    // },
                    onChanged: (val) {}
                    // validator: FormBuilderValidators.compose([
                    //   FormBuilderValidators.required(context),
                    // ]),
                    ),
                // itemCount: job.tags.length,
                // // required
                // itemBuilder: (int index) {
                //   final item = job.tags[index];
                //   return ItemTags(
                //     // Each ItemTags must contain a Key. Keys allow Flutter to
                //     // uniquely identify widgets.
                //     key: Key(index.toString()),
                //     index: index,
                //     // required
                //     title: item.name,
                //     //active: item.active,
                //     //customData: item.customData,
                //     pressEnabled: true,
                //     color: Color.fromRGBO(196, 196, 196, 1),
                //     activeColor: Colors.blueGrey[600],
                //     singleItem: true,
                //     splashColor: Colors.green,
                //     textStyle: theme.inputDecorationTheme.labelStyle,
                //     combine: ItemTagsCombine.withTextAfter,
                //     /*image: ItemTagsImage(
                //                   image: AssetImage("img.jpg") // OR NetworkImage("https://...image.png")
                //               ), // OR null,
                //               icon: ItemTagsIcon(
                //                 icon: Icons.add,
                //               ),*/
                //     // OR null,
                //     removeButton: ItemTagsRemoveButton(
                //       onRemoved: () {
                //         // Remove the item from the data source.
                //         // setState(() {
                //         //   // required
                //         //   job.tags.removeAt(index);
                //         // });
                //         //required
                //         return true;
                //       },
                //     ),
                //     // OR null,
                //     onPressed: (item) => print(item),
                //     onLongPressed: (item) => print(item),
                //   );
                // },
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            LocalPeopleLocalizations.of(context).titleSuggestions,
            textAlign: TextAlign.left,
            style: theme.textTheme.caption,
          ),
          SizedBox(height: 10.0),
          buildTagWidget(context),
        ],
      ),
    );
  }

  Widget buildTagWidget(BuildContext context) {
    //List<Tag> objTags = [];
    objTags.add(Tag(id: 0, name: 'Handy Man'));
    objTags.add(Tag(id: 1, name: 'Window Cleaner'));

    currentTags = List.generate(
        objTags.length, (index) => objTags[index].name);
    //});
    return TagsViewWidget(
      tags: objTags,
    );
  }
}

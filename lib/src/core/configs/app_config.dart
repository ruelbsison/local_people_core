import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import '../enum/app_type.dart';

class AppConfig extends InheritedWidget {
  const AppConfig({
    Key key,
    @required this.appName,
    @required this.appType,
    @required this.debugTag,
    @required this.flavorName,
    @required this.initialRoute,
    //@required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  final String appName;
  final AppType appType;
  final String flavorName;
  final String initialRoute;
  final bool debugTag;
  //final int userId;

  // final AppConfigInheritedWidgetState data;
  //
  // @override
  // bool updateShouldNotify(AppConfig oldWidget) { //Data update
  //   return data != oldWidget.data;
  // }
  //
  // static AppConfig of(BuildContext context) {
  //   return (context.dependOnInheritedWidgetOfExactType() as AppConfig);
  // }
  //static AppConfig of(BuildContext context) {
  //  return context.inheritFromWidgetOfExactType();
  //}

  //@override
  //bool updateShouldNotify(AppConfig old) => userId != old.userId;

  // @override
  // bool updateShouldNotifyDependent(AppConfig old, Set<NUMBER_TYPE> aspects) {
  //   return (aspects.contains(NUMBER_TYPE.FIRST) && old.firstValue != firstValue) ||
  //       (aspects.contains(NUMBER_TYPE.SECOND) && old.secondValue != secondValue) ||
  //       (aspects.contains(NUMBER_TYPE.THIRD) && old.thirdValue != thirdValue);
  // }
  //
  // static NumberModel of(BuildContext context, {NUMBER_TYPE aspect}) {
  //   return InheritedModel.inheritFrom<NumberModel>(context, aspect: aspect);
  // }

  // static AppConfig of(BuildContext context) {
  //   _ModelBindingScope scope = context.inheritFromWidgetOfExactType(_ModelBindingScope);
  //   return scope.modelBindingState.currentModel;
  // }
  //
  // static void update(BuildContext context, AppConfig newModel) {
  //   _ModelBindingScope scope = context.inheritFromWidgetOfExactType(_ModelBindingScope);
  //   scope.modelBindingState.updateModel(newModel);
  // }
  //
  static AppConfig of(BuildContext context) {
   return context.dependOnInheritedWidgetOfExactType();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

  // static AppConfig of(BuildContext context, String aspect) {
  //   return InheritedModel.inheritFrom<AppConfig>(context, aspect: aspect);
  // }

  // @override
  // bool updateShouldNotify(AppConfig oldWidget) {
  //   return userId != oldWidget.userId;
  // }
  //
  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties.add(IntProperty('userId', userId));
  // }
}

// class AppConfigInheritedWidget extends StatefulWidget {
//   AppConfigInheritedWidget({
//     Key key,
//     this.child,
//   }) : super(key: key);
//
//   final Widget child;
//
//   @override
//   AppConfigInheritedWidgetState createState() =>
//       new AppConfigInheritedWidgetState();
//
//   static AppConfigInheritedWidgetState of(BuildContext context) {
//     return (context.dependOnInheritedWidgetOfExactType() as AppConfig).data;
//   }
// }
//
// class AppConfigInheritedWidgetState extends State<AppConfigInheritedWidget> {
//   int _userId = 0;
//
//   void setUserId(int newVal) {
//     setState(() {
//       _userId = newVal;
//     });
//   }
//
//   int getUserId() {
//     return _userId;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AppConfig(child: widget.child, data: this);
//   }
// }

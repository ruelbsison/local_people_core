import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../enum/app_type.dart';

class AppConfig extends InheritedWidget {
  AppConfig({
    @required this.appName,
    @required this.appType,
    @required this.debugTag,
    @required this.flavorName,
    @required this.initialRoute,
    @required Widget child,
  }) : super(child: child);

  final String appName;
  final AppType appType;
  final String flavorName;
  final String initialRoute;
  final bool debugTag;

  static AppConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}

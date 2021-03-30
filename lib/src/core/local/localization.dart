import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'messages_all.dart';

class AppLocalizations {
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String get appTitle => 'Local People';
  String get clientAppTitle => 'Local People For Client';
  String get traderAppTitle => 'Local People For Trader';
}

class AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  @override
  Future<AppLocalizations> load(Locale locale) =>
      Future(() => AppLocalizations());

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;

  @override
  bool isSupported(Locale locale) =>
      locale.languageCode.toLowerCase().contains('en');
}

class LocalPeopleLocalizations {
  LocalPeopleLocalizations(this.locale);

  final Locale locale;

  static Future<LocalPeopleLocalizations> load(Locale locale) {
    return initializeMessages(locale.toString()).then((_) {
      return LocalPeopleLocalizations(locale);
    });
  }

  static LocalPeopleLocalizations of(BuildContext context) {
    return Localizations.of<LocalPeopleLocalizations>(
        context, LocalPeopleLocalizations);
  }

  String get menuTitleHome => Intl.message(
    'Home',
    name: 'menuTitleHome',
    args: [],
    locale: locale.toString(),
  );

  String get menuTitleYourJobs => Intl.message(
    'Your Jobs',
    name: 'menuTitleYourJobs',
    args: [],
    locale: locale.toString(),
  );

  String get menuTitleSearch => Intl.message(
    'Search',
    name: 'menuTitleSearch',
    args: [],
    locale: locale.toString(),
  );

  String get menuTitleMessages => Intl.message(
    'Messages',
    name: 'menuTitleMessages',
    args: [],
    locale: locale.toString(),
  );

  String get menuTitleMore => Intl.message(
    'More',
    name: 'menuTitleMore',
    args: [],
    locale: locale.toString(),
  );

  String get menuTitleSchedule => Intl.message(
    'Schedule',
    name: 'menuTitleSchedule',
    args: [],
    locale: locale.toString(),
  );

  String get menuTitleOpportunities => Intl.message(
    'Opportunities',
    name: 'menuTitleOpportunities',
    args: [],
    locale: locale.toString(),
  );

  String get btnTitlePostJob => Intl.message(
    'POST JOB',
    name: 'btnTitlePostJob',
    args: [],
    locale: locale.toString(),
  );

  String get clearCompleted => Intl.message(
    'Clear completed',
    name: 'clearCompleted',
    args: [],
    locale: locale.toString(),
  );

  String get addTodo => Intl.message(
    'Add Todo',
    name: 'addTodo',
    args: [],
    locale: locale.toString(),
  );

  String get editTodo => Intl.message(
    'Edit Todo',
    name: 'editTodo',
    args: [],
    locale: locale.toString(),
  );

  String get saveChanges => Intl.message(
    'Save changes',
    name: 'saveChanges',
    args: [],
    locale: locale.toString(),
  );

  String get filterTodos => Intl.message(
    'Filter Todos',
    name: 'filterTodos',
    args: [],
    locale: locale.toString(),
  );

  String get deleteTodo => Intl.message(
    'Delete Todo',
    name: 'deleteTodo',
    args: [],
    locale: locale.toString(),
  );

  String get todoDetails => Intl.message(
    'Todo Details',
    name: 'todoDetails',
    args: [],
    locale: locale.toString(),
  );

  String get emptyTodoError => Intl.message(
    'Please enter some text',
    name: 'emptyTodoError',
    args: [],
    locale: locale.toString(),
  );

  String get notesHint => Intl.message(
    'Additional Notes...',
    name: 'notesHint',
    args: [],
    locale: locale.toString(),
  );

  String get completedTodos => Intl.message(
    'Completed Todos',
    name: 'completedTodos',
    args: [],
    locale: locale.toString(),
  );

  String get activeTodos => Intl.message(
    'Active Todos',
    name: 'activeTodos',
    args: [],
    locale: locale.toString(),
  );

  String todoDeleted(String task) => Intl.message(
    'Deleted "$task"',
    name: 'todoDeleted',
    args: [task],
    locale: locale.toString(),
  );

  String get undo => Intl.message(
    'Undo',
    name: 'undo',
    args: [],
    locale: locale.toString(),
  );

  String get deleteTodoConfirmation => Intl.message(
    'Delete this todo?',
    name: 'deleteTodoConfirmation',
    args: [],
    locale: locale.toString(),
  );

  String get delete => Intl.message(
    'Delete',
    name: 'delete',
    args: [],
    locale: locale.toString(),
  );

  String get cancel => Intl.message(
    'Cancel',
    name: 'cancel',
    args: [],
    locale: locale.toString(),
  );
}

class LocalPeopleLocalizationsDelegate
    extends LocalizationsDelegate<LocalPeopleLocalizations> {
  @override
  Future<LocalPeopleLocalizations> load(Locale locale) =>
      LocalPeopleLocalizations.load(locale);

  @override
  bool shouldReload(LocalPeopleLocalizationsDelegate old) => false;

  @override
  bool isSupported(Locale locale) =>
      locale.languageCode.toLowerCase().contains('en');
}
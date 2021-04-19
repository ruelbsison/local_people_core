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

  String get titleLocation => Intl.message(
    'Location',
    name: 'titleLocation',
    args: [],
    locale: locale.toString(),
  );

  String get titleHome => Intl.message(
    'Home',
    name: 'titleHome',
    args: [],
    locale: locale.toString(),
  );

  String get titleAreaName => Intl.message(
    'Area Name',
    name: 'titleAreaName',
    args: [],
    locale: locale.toString(),
  );

  String get menuTitlePostJob => Intl.message(
    'Post Job',
    name: 'menuTitlePostJob',
    args: [],
    locale: locale.toString(),
  );

  String get titleJobCategory => Intl.message(
    'Job Category',
    name: 'titleJobCategory',
    args: [],
    locale: locale.toString(),
  );

  String get titleJobDescription => Intl.message(
    'Job Description',
    name: 'titleJobDescription',
    args: [],
    locale: locale.toString(),
  );

  String get titleSuggestions => Intl.message(
    'Suggestions',
    name: 'titleSuggestions',
    args: [],
    locale: locale.toString(),
  );

  String get titleBudget => Intl.message(
    'Budget',
    name: 'titleBudget',
    args: [],
    locale: locale.toString(),
  );

  String get titleRequestedTimeframe => Intl.message(
    'Requested timeframe',
    name: 'titleRequestedTimeframe',
    args: [],
    locale: locale.toString(),
  );

  String get subTitleASAP => Intl.message(
    'ASAP',
    name: 'subTitleASAP',
    args: [],
    locale: locale.toString(),
  );

  String get subTitleThisWeek => Intl.message(
    'THIS WEEK',
    name: 'subTitleThisWeek',
    args: [],
    locale: locale.toString(),
  );

  String get subTitleSpecific => Intl.message(
    'SPECIFIC',
    name: 'subTitleSpecific',
    args: [],
    locale: locale.toString(),
  );

  /*String todoDeleted(String task) => Intl.message(
    'Deleted "$task"',
    name: 'todoDeleted',
    args: [task],
    locale: locale.toString(),
  );*/

  String get titleTimeToRespond => Intl.message(
    'Time to respond',
    name: 'titleTimeToRespond',
    args: [],
    locale: locale.toString(),
  );

  String get subTitle24Hrs => Intl.message(
    '24Hrs',
    name: 'subTitle24Hrs',
    args: [],
    locale: locale.toString(),
  );

  String get subTitle48Hrs => Intl.message(
    '48Hrs',
    name: 'subTitle48Hrs',
    args: [],
    locale: locale.toString(),
  );

  String get titlePostEdits => Intl.message(
    'Post Edits',
    name: 'titlePostEdits',
    args: [],
    locale: locale.toString(),
  );

  String get titleDeleteJob => Intl.message(
    'Delete Job',
    name: 'titleDeleteJob',
    args: [],
    locale: locale.toString(),
  );

  String get titleJobInfo => Intl.message(
    'Job Information',
    name: 'titleJobInfo',
    args: [],
    locale: locale.toString(),
  );

  String get titleDate => Intl.message(
    'Date',
    name: 'titleDate',
    args: [],
    locale: locale.toString(),
  );

  String get titleTime => Intl.message(
    'Time',
    name: 'titleTime',
    args: [],
    locale: locale.toString(),
  );

  String get btnTitleCancel => Intl.message(
    'Cancel',
    name: 'btnTitleCancel',
    args: [],
    locale: locale.toString(),
  );

  String get btnTitlePost => Intl.message(
    'Post',
    name: 'btnTitlePost',
    args: [],
    locale: locale.toString(),
  );

  String get btnTitleSave => Intl.message(
    'Save',
    name: 'btnTitleSave',
    args: [],
    locale: locale.toString(),
  );

  String get btnTitleSendMesssage => Intl.message(
    'Send Messsage',
    name: 'btnTitleSendMesssage',
    args: [],
    locale: locale.toString(),
  );

  String get titleJobBid => Intl.message(
    'Job Bid',
    name: 'titleJobBid',
    args: [],
    locale: locale.toString(),
  );

  String get btnTitleAwardJob => Intl.message(
    'Award Job',
    name: 'btnTitleAwardJob',
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
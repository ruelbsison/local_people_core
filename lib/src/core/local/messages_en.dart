import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

// ignore: unused_element
final _keepAnalysisHappy = Intl.defaultLocale;

// ignore: non_constant_identifier_names
typedef MessageIfAbsent = void Function(String message_str, List args);

class MessageLookup extends MessageLookupByLibrary {
  @override
  String get localeName => 'en';

  //static String m0(task) => 'Deleted "${task}"';

  @override
  final messages = _notInlinedMessages(_notInlinedMessages);

  static Map<String, dynamic> _notInlinedMessages(_) => {
    'menuTitleHome': MessageLookupByLibrary.simpleMessage('Home'),
    'menuTitleYourJobs': MessageLookupByLibrary.simpleMessage('Your Jobs'),
    'menuTitleJobs': MessageLookupByLibrary.simpleMessage('Jobs'),
    'menuTitleSearch': MessageLookupByLibrary.simpleMessage('Search'),
    'menuTitleMessages':
    MessageLookupByLibrary.simpleMessage('Messages'),
    'menuTitleMore':
    MessageLookupByLibrary.simpleMessage('More'),
    'menuTitleSchedule': MessageLookupByLibrary.simpleMessage('Schedule'),
    'menuTitleOpportunities': MessageLookupByLibrary.simpleMessage('Opportunities'),
    'btnTitlePostJob': MessageLookupByLibrary.simpleMessage('POST JOB'),
    'menuTitlePostJob': MessageLookupByLibrary.simpleMessage('Post Job'),
    'titleLocation': MessageLookupByLibrary.simpleMessage('Location'),
    'titleHome': MessageLookupByLibrary.simpleMessage('Home'),
    'titleAreaName': MessageLookupByLibrary.simpleMessage('Area Name'),
    'titleJobCategory': MessageLookupByLibrary.simpleMessage('Job Category'),
    'titleJobDescription': MessageLookupByLibrary.simpleMessage('Job Description'),
    'titleSuggestions': MessageLookupByLibrary.simpleMessage('Suggestions'),
    'titleBudget': MessageLookupByLibrary.simpleMessage('Budget'),
    'titleRequestedTimeframe': MessageLookupByLibrary.simpleMessage('Requested timeframe'),
    'subTitleASAP': MessageLookupByLibrary.simpleMessage('ASAP'),
    'subTitleThisWeek': MessageLookupByLibrary.simpleMessage('THIS WEEK'),
    'subTitleSpecific': MessageLookupByLibrary.simpleMessage('SPECIFIC'),
    'titleTimeToRespond': MessageLookupByLibrary.simpleMessage('Time to respond'),
    //'todoDeleted': m0,
    'subTitle24Hrs': MessageLookupByLibrary.simpleMessage('24Hrs'),
    'subTitle48Hrs': MessageLookupByLibrary.simpleMessage('48Hrs'),
    'titlePostEdits': MessageLookupByLibrary.simpleMessage('Post Edits'),
    'titleDeleteJob': MessageLookupByLibrary.simpleMessage('Delete Job'),
    'titleDeleteBid': MessageLookupByLibrary.simpleMessage('Delete Bid'),
    'titleJobInfo': MessageLookupByLibrary.simpleMessage('Job Information'),
    'titleDate': MessageLookupByLibrary.simpleMessage('Date'),
    'titleTime': MessageLookupByLibrary.simpleMessage('Time'),
    'titleJobBid': MessageLookupByLibrary.simpleMessage('Job Bid'),
    'titlePlaceBid': MessageLookupByLibrary.simpleMessage('Place Bid'),
    'titleRequestVisit': MessageLookupByLibrary.simpleMessage('Request Visit'),
    'titleBidPlaced': MessageLookupByLibrary.simpleMessage('Bid Placed'),
    'titleJobConfirmed': MessageLookupByLibrary.simpleMessage('Job Confirmed'),
    'titleStart': MessageLookupByLibrary.simpleMessage('Start'),
    'titleDuration': MessageLookupByLibrary.simpleMessage('Duration'),
    'titleDepositRequired': MessageLookupByLibrary.simpleMessage('Deposit Required'),
    'titlePostedBy': MessageLookupByLibrary.simpleMessage('Posted By'),
    'titleAcceptedBid': MessageLookupByLibrary.simpleMessage('Accepted Bid'),
    'btnTitleCancel': MessageLookupByLibrary.simpleMessage('Cancel'),
    'btnTitlePost': MessageLookupByLibrary.simpleMessage('Post'),
    'btnTitleSave': MessageLookupByLibrary.simpleMessage('Save'),
    'btnTitleSendMesssage': MessageLookupByLibrary.simpleMessage('Send Messsage'),
    'btnTitleAwardJob': MessageLookupByLibrary.simpleMessage('Award Job'),
    'btnTitleCancelBid': MessageLookupByLibrary.simpleMessage('Cancel Bid'),
    'btnTitleResponsePending': MessageLookupByLibrary.simpleMessage('Response Pending'),
    'btnTitleJobAwarded': MessageLookupByLibrary.simpleMessage('Job Awarded'),
    'btnTitleAwaitingDeposit': MessageLookupByLibrary.simpleMessage('Awaiting Deposit'),
    'btnTitleEditJob': MessageLookupByLibrary.simpleMessage('Edit Job'),
    'btnTitleCancelJob': MessageLookupByLibrary.simpleMessage('Cancel Job'),
  };
}
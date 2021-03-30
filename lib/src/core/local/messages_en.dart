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

  static String m0(task) => 'Deleted "${task}"';

  @override
  final messages = _notInlinedMessages(_notInlinedMessages);

  static Map<String, dynamic> _notInlinedMessages(_) => {
    'menuTitleHome': MessageLookupByLibrary.simpleMessage('Home'),
    'menuTitleYourJobs': MessageLookupByLibrary.simpleMessage('Your Jobs'),
    'menuTitleSearch': MessageLookupByLibrary.simpleMessage('Search'),
    'menuTitleMessages':
    MessageLookupByLibrary.simpleMessage('Messages'),
    'menuTitleMore':
    MessageLookupByLibrary.simpleMessage('More'),
    'menuTitleSchedule': MessageLookupByLibrary.simpleMessage('Schedule'),
    'menuTitleOpportunities': MessageLookupByLibrary.simpleMessage('Opportunities'),
    'btnTitlePostJob':
    MessageLookupByLibrary.simpleMessage('POST JOB'),
    'editTodo': MessageLookupByLibrary.simpleMessage('Edit Todo'),
    'emptyTodoError':
    MessageLookupByLibrary.simpleMessage('Please enter some text'),
    'filterTodos': MessageLookupByLibrary.simpleMessage('Filter Todos'),
    'markAllComplete':
    MessageLookupByLibrary.simpleMessage('Mark all complete'),
    'markAllIncomplete':
    MessageLookupByLibrary.simpleMessage('Mark all incomplete'),
    'newTodoHint':
    MessageLookupByLibrary.simpleMessage('What needs to be done?'),
    'notesHint':
    MessageLookupByLibrary.simpleMessage('Additional Notes...'),
    'saveChanges': MessageLookupByLibrary.simpleMessage('Save changes'),
    'showActive': MessageLookupByLibrary.simpleMessage('Show Active'),
    'showAll': MessageLookupByLibrary.simpleMessage('Show All'),
    'showCompleted': MessageLookupByLibrary.simpleMessage('Show Completed'),
    'stats': MessageLookupByLibrary.simpleMessage('Stats'),
    'todoDeleted': m0,
    'todoDetails': MessageLookupByLibrary.simpleMessage('Todo Details'),
    'todos': MessageLookupByLibrary.simpleMessage('Todos'),
    'undo': MessageLookupByLibrary.simpleMessage('Undo')
  };
}
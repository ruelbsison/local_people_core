
import 'dart:collection';

import 'package:flutter/foundation.dart';
import './entities/job.dart';
import 'package:local_people_core/quote.dart';

class JobProvider extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<Job> _jobs = [];

  List<Job> _filteredJobs = [];

  String _filterValue = '';

  /// An unmodifiable view of the job in the list.
  UnmodifiableListView<Job> get jobs => UnmodifiableListView(_jobs);

  UnmodifiableListView<Job> get filteredJobs => UnmodifiableListView(_filteredJobs);

  Job findJob(int id) => _jobs.firstWhere((job) => job.id == id);

  void updateQuote(List<Quote> quotes) {
    if (quotes != null && quotes.length > 0) {
      Quote quote = quotes.elementAt(0);
      Job job = findJob(quote.jobId);
      if (job != null) {
        if (job.bids == null)
          job.bids = [];
        else if (job.bids.length > 0)
          job.bids.clear();

        job.bids.addAll(quotes);
        notifyListeners();
      }
    }
  }
  /// Adds [job] to job list.
  void add(Job job) {
    _jobs.add(job);

    final String prevFilterValue = _filterValue;
    if (_filterValue.length > 0) {
      _filterValue = '';
      filterJobs(prevFilterValue);
    }

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void addAll(List<Job> jobs) {
    _jobs.addAll(jobs);

    final String prevFilterValue = _filterValue;
    if (_filterValue.length > 0) {
      _filterValue = '';
      filterJobs(prevFilterValue);
    }
    // This call tells the widgets that are listening to this model to rebuild.
    //notifyListeners();
  }

  /// Removes all job from the list.
  void removeAll() {
    _jobs.clear();
    _filteredJobs.clear();

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void filterJobs(String filterValue) {
    if (_filterValue.compareTo(filterValue) != 0) {
      _filterValue = filterValue;

      _filteredJobs = _jobs.where((job) {
        if (_filterValue.startsWith('Expiry') == true) {
          DateTime tom = job.date.add(Duration(days: 1));
          if (job.date != null && tom.isAtSameMomentAs(DateTime.now())) {
            return true;
          }
          return false;
        } else if (_filterValue.startsWith('Value') == true) {
          return false;
        } else if (_filterValue.startsWith('Bids') == true) {
          if (job.bids != null && (job.bids.length > 0) == true) {
            return true;
          }
          return false;
        } else if (_filterValue.startsWith('Packages') == true) {
          if (job.private != null && job.private == true) {
            return true;
          }
          return false;
        } else if (_filterValue.startsWith('Clients') == true) {
          return false;
        } else if (_filterValue.startsWith('Posted') == true) {
          if (job.isPosted != null && job.isPosted == true) {
            return true;
          }
          return false;
        } else if (_filterValue.startsWith('Awarded') == true) {
          if (job.awarded != null && job.awarded == true) {
            return true;
          }
          return false;
        } else if (_filterValue.startsWith('Confirmed') == true) {
          if (job.isConfirmed != null && job.isConfirmed == true) {
            return true;
          }
          return false;
        } else if (_filterValue.startsWith('Completed') == true) {
          if (job.isCompleted != null && job.isCompleted == true) {
            return true;
          }
          return false;
        }
        return true;
      }).toList();

      //notifyListeners();
    }
  }
}
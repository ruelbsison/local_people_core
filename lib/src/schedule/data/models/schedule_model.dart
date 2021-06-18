import 'package:meta/meta.dart';

class ScheduleModel {
  final int id;
  final int job_id;
  final int start_date_time;
  final int end_date_time;
  final int interval;
  final String type;

  ScheduleModel({
    @required this.id,
    @required this.job_id,
    @required this.start_date_time,
    @required this.end_date_time,
    @required this.interval,
    @required this.type,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'job_id': job_id,
      'start_date_time': start_date_time,
      'end_date_time': end_date_time,
      'interval': interval,
      'type': type,
    };
  }

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
      id: json['id'] ?? 0,
      job_id: json['job_id'] ?? '',
      start_date_time: json['start_date_time'] ?? '',
      end_date_time: json['end_date_time'] ?? '',
    interval: json['interval'] ?? '',
    type: json['type'] ?? '',
  );


  Map<String, dynamic> toJson() {
    var map = {
      'id': this.id ?? '',
      'job_id': this.job_id ?? '',
      'start_date_time': this.start_date_time ?? '',
      'end_date_time': this.end_date_time ?? '',
      'interval': this.interval ?? '',
      'type': this.type ?? ''
    };

    if (map['id'] != null) map['id'] = this.id ?? '';

    return map;
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Dog{id: $id, job_id: $job_id, start_date_time: $start_date_time'
        ', end_date_time: $end_date_time, interval: $interval'
        ', type: $type}';
  }
}
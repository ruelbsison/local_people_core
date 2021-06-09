import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'location_model.dart';
import 'tag_model.dart';
import '../../domain/entities/job.dart';
import '../../domain/entities/tag.dart';
import '../../domain/entities/location.dart';

part 'job_model.g.dart';

/// {@template JobModel}
/// JobModel model
///
/// [JobModel.empty] represents an unauthenticated JobModel.
/// {@endtemplate}
@JsonSerializable()
class JobModel extends Equatable {
  /// {@macro JobModel}
  JobModel({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.date,
    @required this.budget,
    @required this.awarded,
    this.private = false,
    this.created_at,
    this.updated_at,
    this.client_id,
    this.trader_id,
    this.location_id,
    this.tag_ids,
  })  : assert(id != null);

  /// The current JobModel's email address.
  String title;

  /// The current JobModel's id.
  int id;

  /// The current JobModel's name (display name).
  String description;

  /// The current JobModel's name (display name).
  String date;

  String budget;

  bool awarded;

  String created_at;

  String updated_at;

  int client_id;

  int trader_id;

  bool private;

  //LocationModel location;
  int location_id;

  List<int> tag_ids;

  /// Empty JobModel which represents an unauthenticated JobModel.
  static empty() {
    new JobModel(id: -1,
        title: '',
        description: '',
        date: '',
        budget: '',
        awarded: false,
        created_at: '',
        updated_at: '',
        client_id: 0,
        trader_id: 0,
      tag_ids: [],
      location_id: 0,
    );
  }

  static JobModel fromJob(Job job) {
    JobModel model = JobModel(
      id: job.id,
      title: job.title,
      description: job.description,
      date:  DateFormat("yyyy-MM-dd'T'HH:mm:ss.ms'Z'").format(job.date), //DateFormat('yyyyy-MM-ddThh:mm.sssZ').format(DateTime.now()), //job.date),
      budget: job.budget,
      awarded: false,
      client_id: job.clientId, //authLocalModel.userId,
      trader_id: job.traderId,
        private: job.private,
    );
    model.tag_ids = [];
    if (job.tags != null && job.tags.length > 0) {
      Iterator tagIter = job.tags.iterator;
      while(tagIter.moveNext()) {
        Tag tag = tagIter.current;
        model.tag_ids.add(tag.id);
      }
    }
    if (job.location != null) {
      model.location_id = job.location.id;
    }
    
    return model;
  }

  @override
  List<Object> get props => [id, title, description, date, budget, created_at, updated_at, client_id, trader_id, location_id, tag_ids, private];

  factory JobModel.fromJson(Map<String, dynamic> json) => _$JobModelFromJson(json);
  Map<String, dynamic> toJson() => _$JobModelToJson(this);
}

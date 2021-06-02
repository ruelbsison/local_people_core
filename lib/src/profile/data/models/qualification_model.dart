import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/qualification.dart';
import 'package:local_people_core/auth.dart';

part 'qualification_model.g.dart';

/// {@template QualificationModel}
/// QualificationModel model
///
/// [QualificationModel.empty] represents an unauthenticated QualificationModel.
/// {@endtemplate}
@JsonSerializable()
class QualificationModel extends Equatable {
  int    id;
  String title;
  int   trader_id;
  String created_at;
  String updated_at;

  QualificationModel(
      {this.id,
        this.title,
        this.trader_id,
        this.created_at,
        this.updated_at});

  static QualificationModel fromClientProfile(Qualification qualification) {
    return QualificationModel(
      id: qualification.id,
      trader_id: qualification.traderId,
      title: qualification.title,
    );
  }

  /// Empty QualificationModel which represents an unauthenticated QualificationModel.
  static empty() {
    new QualificationModel(
      id: -1,
      trader_id: -1,
      title: '',
      created_at: '',
      updated_at: '',
    );
  }

  @override
  List<Object> get props => [id, title, trader_id, created_at, updated_at];

  factory QualificationModel.fromJson(Map<String, dynamic> json) => _$QualificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$QualificationModelToJson(this);
}

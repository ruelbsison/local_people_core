import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

enum QualificationOptionType {
  VIEW_ONLY,
  ADD_DEFAULT,
  REMOVE,
  ADD_NEW,
}
class Qualification extends Equatable implements Comparable {
  final int id;
  int traderId;
  String title;
  QualificationOptionType optionType;
  Qualification({
    this.id,
    this.traderId,
    @required this.title,
    this.optionType = QualificationOptionType.VIEW_ONLY,
  });

  @override
  List<Object> get props => [id, traderId, title, optionType];

  @override
  int compareTo(other) {
    // if (this.id != null && other.id != null
    //     && this.id > 0 && other.id > 0) {
    //   if (this.id < other.id) {
    //     return 1;
    //   } else if (this.id > other.id) {
    //     return -1;
    //   }
    //   return 0;
    // }

    if (this.title != null && other.title != null) {
      return this.title.toLowerCase().compareTo(other.title.toLowerCase());
    }

    return 0;
  }
}
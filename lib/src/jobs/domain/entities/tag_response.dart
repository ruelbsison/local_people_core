import 'tag.dart';
import '../../data/models/tag_model.dart';

class TagResponse {
  Exception exception;
  Tag tag;

  void fromModel(TagModel model) {
    tag = Tag(
        id: model.id,
        name: model.name,
      );
  }

  static TagModel fromTag(Tag tag) {
    return TagModel (
      id: tag.id,
      name: tag.name,
    );
  }
}
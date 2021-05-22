
import '../../data/models/tag_model.dart';
import 'tag.dart';

class TagListResponse {
  Exception exception;
  List<Tag> tags;

  void fromModel(List<TagModel> list) {
    tags = List<Tag>();

    var listIter = list.iterator;
    while(listIter.moveNext() ) {
      TagModel model = listIter.current;
      Tag tag = Tag(
        id: model.id,
        name: model.name,
      );

      tags.add(tag);
    }
  }
}


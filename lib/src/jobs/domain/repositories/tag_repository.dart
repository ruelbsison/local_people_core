
import '../entities/tag.dart';
import '../entities/tag_response.dart';
import '../entities/tag_list_response.dart';

abstract class TagRepository {
  Future<TagListResponse> listTags();

  Future<TagListResponse> listJobTags(int job_id);

  Future<TagResponse> createTag(Tag tag);

  Future<TagResponse> showTag(int id);

  Future<TagResponse> updateTag(Tag tag);

  Future<Exception> deleteTag(int id);
}
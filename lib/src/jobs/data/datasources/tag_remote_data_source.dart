import 'dart:io';
import '../models/tag_model.dart';

abstract class TagRemoteDataSource {
  Future<List<TagModel>> listTags();

  Future<List<TagModel>> listJobTags(int job_id);

  Future<TagModel> createTag(TagModel job);

  Future<TagModel> showTag(int id);

  Future<TagModel> updateTag(TagModel job);

  Future<void> deleteTag(int id);
}
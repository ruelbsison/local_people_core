import 'dart:io';
import '../models/tag_model.dart';
import '../../domain/entities/tag_response.dart';
import '../../domain/entities/tag_list_response.dart';

abstract class TagRemoteDataSource {
  Future<TagListResponse> listTags();

  Future<TagListResponse> listJobTags(int job_id);

  Future<TagResponse> createTag(TagModel job);

  Future<TagResponse> showTag(int id);

  Future<TagResponse> updateTag(TagModel job);

  Future<Exception> deleteTag(int id);
}
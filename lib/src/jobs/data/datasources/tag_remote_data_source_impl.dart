import 'package:local_people_core/src/jobs/domain/entities/tag_list_response.dart';
import 'package:local_people_core/src/jobs/domain/entities/tag_response.dart';
import 'package:meta/meta.dart';
import 'package:logging/logging.dart';
import '../models/tag_model.dart';
import 'tag_rest_api_client.dart';
import 'tag_remote_data_source.dart';

class TagRemoteDataSourceImpl implements TagRemoteDataSource {
  final logger = Logger("TagRemoteDataSourceImpl");
  final TagRestApiClient tagRestApiClient;

  TagRemoteDataSourceImpl({@required this.tagRestApiClient})
      : assert(tagRestApiClient != null);

  @override
  Future<TagResponse> createTag(TagModel model) async {
    TagResponse reponse = TagResponse();

    try {
      TagModel data = await tagRestApiClient.createTag(model);
      if (data != null) {
        reponse.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe(
          "Exception occured in createTag $error $stacktrace", error, stacktrace);
      reponse.exception = Exception(error.toString());
    }

    return reponse;
  }

  @override
  Future<Exception> deleteTag(int id) async {
    Exception reponse = Exception();

    try {
      await tagRestApiClient.deleteTag(id);
    } catch (error, stacktrace) {
      logger.severe(
          "Exception occured in deleteTag $error $stacktrace", error, stacktrace);
      reponse = Exception(error.toString());
    }

    return reponse;
  }

  @override
  Future<TagListResponse> listJobTags(int job_id) async {
    TagListResponse reponse = TagListResponse();

    try {
      List<TagModel> data = await tagRestApiClient.listJobTags(job_id);
      if (data != null) {
        reponse.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe(
          "Exception occured in listJobTags $error $stacktrace", error, stacktrace);
      reponse.exception = Exception(error.toString());
    }

    return reponse;
  }

  @override
  Future<TagListResponse> listTags() async {
    TagListResponse reponse = TagListResponse();

    try {
      List<TagModel> data = await tagRestApiClient.listTags();
      if (data != null) {
        reponse.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe(
          "Exception occured in listTags $error $stacktrace", error, stacktrace);
      reponse.exception = Exception(error.toString());
    }

    return reponse;
  }

  @override
  Future<TagResponse> showTag(int id) async {
    TagResponse reponse = TagResponse();

    try {
      TagModel data = await tagRestApiClient.showTag(id);
      if (data != null) {
        reponse.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe(
          "Exception occured in showTag $error $stacktrace", error, stacktrace);
      reponse.exception = Exception(error.toString());
    }

    return reponse;
  }

  @override
  Future<TagResponse> updateTag(TagModel tag) async {
    TagResponse reponse = TagResponse();

    try {
      TagModel data = await tagRestApiClient.updateTag(tag.id, tag);
      if (data != null) {
        reponse.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe(
          "Exception occured in updateTag $error $stacktrace", error, stacktrace);
      reponse.exception = Exception(error.toString());
    }

    return reponse;
  }

  

}
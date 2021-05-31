import 'package:local_people_core/src/jobs/domain/entities/tag.dart';
import 'package:local_people_core/src/jobs/data/models/tag_model.dart';
import 'package:local_people_core/src/jobs/domain/entities/tag_list_response.dart';

import 'package:local_people_core/src/jobs/domain/entities/tag_response.dart';

import '../../domain/repositories/tag_repository.dart';
import '../datasources/tag_remote_data_source.dart';
import 'package:meta/meta.dart';
import 'package:logging/logging.dart';
import 'package:local_people_core/core.dart';

class TagRepositoryImpl implements TagRepository {
  final logger = Logger("TagRepositoryImpl");
  final NetworkInfo networkInfo;
  final TagRemoteDataSource tagRemoteDataSource;

  TagRepositoryImpl(
      {@required this.networkInfo, @required this.tagRemoteDataSource})
      : assert(networkInfo != null),
        assert(tagRemoteDataSource != null);

  @override
  Future<TagResponse> createTag(Tag tag) async {
    TagResponse response = TagResponse();
    if (await networkInfo.isConnected) {
      try {
        TagModel model = TagResponse.fromTag(tag);
        response = await tagRemoteDataSource.createTag(model);
        if (response.exception != null) {
          logger.severe("Exception occured in createQuote", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in createQuote", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<Exception> deleteTag(int id) async {
    Exception response;
    if (await networkInfo.isConnected) {
      try {
        await tagRemoteDataSource.deleteTag(id);
      } catch (error, stacktrace) {
        logger.severe("Exception occured in createQuote", error, stacktrace);
        response = Exception(error.toString());
      }
    } else {
      response = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<TagListResponse> listJobTags(int job_id) async {
    TagListResponse response = TagListResponse();
    if (await networkInfo.isConnected) {
      try {
        response = await tagRemoteDataSource.listJobTags(job_id);
        if (response.exception != null) {
          logger.severe("Exception occured in listJobTags", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in listJobTags", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<TagListResponse> listTags() async {
    TagListResponse response = TagListResponse();
    if (await networkInfo.isConnected) {
      try {
        response = await tagRemoteDataSource.listTags();
        if (response != null && response.exception != null) {
          logger.severe("Exception occured in listTags", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in listTags", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<TagResponse> showTag(int id) async {
    TagResponse response = TagResponse();
    if (await networkInfo.isConnected) {
      try {
        response = await tagRemoteDataSource.showTag(id);
        if (response.exception != null) {
          logger.severe("Exception occured in showTag", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in showTag", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<TagResponse> updateTag(Tag tag) async {
    TagResponse response = TagResponse();
    if (await networkInfo.isConnected) {
      try {
        TagModel model = TagResponse.fromTag(tag);
        response = await tagRemoteDataSource.updateTag(model);
        if (response.exception != null) {
          logger.severe("Exception occured in updateTag", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in updateTag", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }
}

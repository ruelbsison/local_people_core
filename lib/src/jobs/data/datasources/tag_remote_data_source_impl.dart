import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:logging/logging.dart';
import '../models/tag_model.dart';
import 'tag_rest_api_client.dart';
import 'tag_remote_data_source.dart';
import '../../../../core.dart';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:mime/mime.dart';

class TagRemoteDataSourceImpl implements TagRemoteDataSource {
  final logger = Logger("TraderRemoteDataSourceImpl");
  final String baseUrl;
  TagRestApiClient tagRestApiClient;

  TagRemoteDataSourceImpl(
      @required this.baseUrl
      )  : assert(baseUrl != null) {
    tagRestApiClient = TagRestApiClient(RestAPIConfig.getDioOptions(),
        baseUrl: baseUrl);
  }

  @override
  Future<List<TagModel>> listTags() async {
    List<TagModel> result;
    try {
      result = await tagRestApiClient.listTags();
    } catch (error, stacktrace) {
      logger.severe("Exception occured in listTags", error, stacktrace);
      throw ServerException.withError(error: error);
    }

    return result;
  }

  @override
  Future<List<TagModel>> listJobTags(int job_id) async {
    List<TagModel> data;
    try {
      data = await tagRestApiClient.listJobTags(job_id);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in listJobTags", error, stacktrace);
      throw ServerException.withError(error: error);
    }

    return data;
  }

  @override
  Future<TagModel> createTag(TagModel job) async {
    TagModel ressult;
    try {
      ressult = await tagRestApiClient.createTag(job.name);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in createTag", error, stacktrace);
      throw ServerException.withError(error: error);
    }

    return ressult;
  }

  @override
  Future<void> deleteTag(int id) async {
    try {
      await tagRestApiClient.deleteTag(id);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in deleteTag", error, stacktrace);
      throw ServerException.withError(error: error);
    }
  }

  @override
  Future<TagModel> showTag(int id) async {
    TagModel ressult;
    try {
      ressult = await tagRestApiClient.showTag(id);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in showTag", error, stacktrace);
      throw ServerException.withError(error: error);
    }

    return ressult;
  }

  @override
  Future<TagModel> updateTag(TagModel job) async {
    TagModel ressult;
    try {
      ressult = await tagRestApiClient.updateTag(job.id, job);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in updateTag", error, stacktrace);
      throw ServerException.withError(error: error);
    }

    return ressult;
  }

}
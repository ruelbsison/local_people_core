import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../core/enum/api_request_status.dart';
import '../../data/datasources/tag_rest_api_client.dart';
import '../../domain/entities/tag.dart';
import '../../data/datasources/tag_remote_data_source.dart';
import '../../data/datasources/tag_remote_data_source_impl.dart';
import '../../../core/configs/rest_api_config.dart';
import '../../domain/entities/tag_list_response.dart';

class TagProvider with ChangeNotifier {
  List<Tag> _objTags = [];
  List<String> _currentTags = [];
  List<Tag> _objJobTags = [];
  List<String> _currentJobTags = [];
  APIRequestStatus apiRequestStatus = APIRequestStatus.loading;
  final TagRestApiClient tagRestApiClient = TagRestApiClient(
      RestAPIConfig.getDioOptions(),
    baseUrl: RestAPIConfig().baseURL,
  );

  bool loading = true;

  getTags() async {
    TagRemoteDataSource api = TagRemoteDataSourceImpl(tagRestApiClient: tagRestApiClient);
    setLoading(true);
    setApiRequestStatus(APIRequestStatus.loading);
    try {
      List<Tag> objTags = [];
      List<String> currentTags = [];
      TagListResponse response = await api.listTags();
      List<Tag> allTags = response.tags;
      // var tagsListIter = allTags.iterator;
      // while( tagsListIter.moveNext() ) {
      //   TagModel model = tagsListIter.current;
      //   currentTags.add(model.name);
      //   objTags.add(Tag(
      //       id: model.id,
      //       name: model.name)
      //   );
      // }
      setCurrentTags(allTags);
      setObjTags(allTags);
      setApiRequestStatus(APIRequestStatus.loaded);
      setLoading(false);
    } catch (e) {
      checkError(e);
    }
  }

  getJobTags(int job_id) async {
    TagRemoteDataSource api = TagRemoteDataSourceImpl(tagRestApiClient: tagRestApiClient);
    setLoading(true);
    setApiRequestStatus(APIRequestStatus.loading);
    try {

      List<Tag> objJobTags = [];
      List<String> currentJobTags = [];
      TagListResponse response = await api.listJobTags(job_id);
      List<Tag> allTags = response.tags;
      // var tagsListIter = allTags.iterator;
      // while( tagsListIter.moveNext() ) {
      //   TagModel model = tagsListIter.current;
      //   currentJobTags.add(model.name);
      //   objJobTags.add(Tag(
      //       id: model.id,
      //       name: model.name)
      //   );
      // }
      setCurrentJobTags(allTags);
      setObjJobTags(allTags);
      setApiRequestStatus(APIRequestStatus.loaded);
      setLoading(false);
    } catch (e) {
      checkError(e);
      setLoading(false);
    }
  }

  void checkError(e) {
    /*if (Functions.checkConnectionError(e)) {
      setApiRequestStatus(APIRequestStatus.connectionError);
    } else {
      setApiRequestStatus(APIRequestStatus.error);
    }*/
    setApiRequestStatus(APIRequestStatus.error);
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  void setApiRequestStatus(APIRequestStatus value) {
    apiRequestStatus = value;
    notifyListeners();
  }

  void setObjTags(value) {
    _objTags = value;
    notifyListeners();
  }

  List<Tag> getObjTags() {
    return _objTags;
  }

  void setCurrentTags(value) {
    _currentTags = value;
    notifyListeners();
  }

  List<String> getCurrentTags() {
    return _currentTags;
  }

  void setObjJobTags(value) {
    _objJobTags = value;
    notifyListeners();
  }

  List<Tag> getObjJobTags() {
    return _objJobTags;
  }

  void setCurrentJobTags(value) {
    _currentJobTags = value;
    notifyListeners();
  }

  List<String> getCurrentJobTags() {
    return _currentJobTags;
  }
}

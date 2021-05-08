import 'package:dio/dio.dart' hide MultipartFile;
import 'package:http/http.dart' as http;
import 'package:retrofit/retrofit.dart';
//import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:logging/logging.dart';
import '../models/job_model.dart';
import 'job_rest_api_client.dart';
import 'job_remote_data_source.dart';
import '../../../../core.dart';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'job_remote_data_source.dart';
import 'dart:io';
import 'dart:convert';
import 'package:mime/mime.dart';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import '../models/job_list_response.dart';
import '../models/job_response.dart';

class JobRemoteDataSourceImpl implements JobRemoteDataSource {
  final logger = Logger("TraderRemoteDataSourceImpl");
  final String baseUrl;
  JobRestApiClient jobRestApiClient;

  JobRemoteDataSourceImpl(@required this.baseUrl) : assert(baseUrl != null) {
    jobRestApiClient =
        JobRestApiClient(RestAPIConfig.getDioOptions(), baseUrl: baseUrl);
  }

  @override
  Future<JobListResponse> listJobs() async {
    JobListResponse reponse = JobListResponse();

    List<JobModel> data;
    try {
      data = await jobRestApiClient.listJobs();
      reponse.jobsFromModel(data);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in listJobs $error $stacktrace", error,
          stacktrace);
      reponse.exception = ServerException.withError(error: error);
    }

    return reponse;
  }

  @override
  Future<JobListResponse> listJobsForClient(int client_id) async {
    JobListResponse reponse = JobListResponse();

    List<JobModel> data;
    try {
      data = await jobRestApiClient.listJobsForClient(client_id);
      reponse.jobsFromModel(data);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in listJobsForClient $error $stacktrace",
          error, stacktrace);
      reponse.exception = ServerException.withError(error: error);
    }

    return reponse;
  }

  @override
  Future<JobListResponse> listJobsForTrader(int trader_id) async {
    JobListResponse reponse = JobListResponse();

    List<JobModel> data;
    try {
      data = await jobRestApiClient.listJobsForTrader(trader_id);
      reponse.jobsFromModel(data);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in listJobsForTrader $error $stacktrace",
          error, stacktrace);
      reponse.exception = ServerException.withError(error: error);
    }

    return reponse;
  }

  @override
  Future<JobResponse> createJob(JobModel job, [List<String> files]) async {
    JobResponse reponse = JobResponse();

    JobModel ressult;
    try {
      //List<File> formDataFiles = List<File>();
      //List<Map<String, dynamic>> formDataFiles = List<Map<String, dynamic>>();
      //MapEntry('job', jsonEncode(job));
      //var formData = new FormData();
      //var multipart = MultiPart();
      //List<MultipartFile> multipartBody = List<MultipartFile>();
      //formData.boundary = 'boundary=---------------------------9051914041544843365972754266';
      //MultipartRequest request = MultipartRequest(method, url)
      //Uint8List jsonbBytes;
      //List<File> formDataFiles = List<File>();

      /*if (job != null) {
        job.id = null;
        String json = jsonEncode(job);
        //jsonbBytes = Utf8Encoder().convert(json);

        //job.date = DateFormat('yyyyy-MM-ddThh:mm.sssZ').format(DateTime.now()); //DateTime.now().toString();
        //job.tags.add();
        formData.fields.add(MapEntry('job', jsonEncode(job)));
        //formData.fields.add(job.toJson());

        //formData.files.add( MapEntry('job', MultipartFile.fromBytes(
        //multipartBody.add(MultipartFile.fromString(
        */ /*formData.files.add(MapEntry('job', MultipartFile.fromString(
            jsonEncode(job),
            //base64.encode(Utf8Encoder().convert(jsonEncode(job))),
            //Utf8Encoder().convert(jsonEncode(job)),
            filename: 'job.json',
            contentType: MediaType('application', 'json'))));*/ /*



        */ /*formDataFiles.add(Map<String, dynamic>(
          'job',
          MultipartFile.fr(
            jsonEncode(job),
            filename: 'job.json',
              contentType: MediaType('application', 'json'))));*/ /*
      }*/

      /*formDataFiles.addAll(files?.map((i) => MapEntry(
          'files',
          MultipartFile.fromFileSync(
            i.path,
            filename: i.path.split(Platform.pathSeparator).last,
          ))));*/

      /*if (files != null) {
        //int idx = 0;
        var fileListIter = files.iterator;
        while( fileListIter.moveNext() ) {
          String filePath = fileListIter.current;
          //File file = File(filePath);

          //formDataFiles.add(file);

          //final bytes = await file.readAsBytes();
          //String imgEncoded = base64.encode(bytes);

          //Map<String, String> charset = Map<String, String> ('charset','base64');
          final mimeType = lookupMimeType(filePath);
          List<String> typeSubTypes = mimeType.split('/');
          //var multipartFile = MultipartFile.fromString(imgEncoded,
          //var multipartFile = MultipartFile.fromBytes(bytes,
          var multipartFile = MultipartFile.fromFileSync(filePath,
              filename: filePath.split(Platform.pathSeparator).last,
              contentType: MediaType(typeSubTypes[0], typeSubTypes[1]));

          formData.files.add(MapEntry('images', multipartFile));
          //idx++;
        }
      }*/

      //ressult = await jobRestApiClient.createJob(multipartBody);
      //print('FormData: ' + formData.toString());
      //logger.info('FormData: ' + formData.toString());
      //ressult = await jobRestApiClient.createJob(formData);
      //ressult = await jobRestApiClient.createJob(jsonbBytes, formDataFiles);
      reponse.jobFromModel(ressult);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in createJob $error $stacktrace", error,
          stacktrace);
      reponse.exception = ServerException.withError(error: error);
    }

    return reponse;
  }

  @override
  Future<String> createJob2(JobModel job, [List<String> files]) async {
    String result;
    try {
      String json = jsonEncode(job);
      Uint8List jsonbBytes = Utf8Encoder().convert(json);

      var request =
          http.MultipartRequest('POST', Uri.parse(this.baseUrl + '/jobs'));
          Dio dio = RestAPIConfig.getDioOptions();
          //request.headers.addAll(<String, String>{
          //  "Content-Type" : "multipart/form-data",
          //});
      Map<String, String> headers = Map<String, String>();
      String auhtStr = dio.options.headers['Authorization'].toString();
      headers['Authorization'] = auhtStr;
      request.headers.addAll(headers);

      /*var mp = http.MultipartFile.fromBytes(
          'job', jsonbBytes, //jsonEncode(job),
          filename: 'job.json',
          contentType: MediaType('application', 'json'));*/

          request.files.add(
              http.MultipartFile.fromString(
                  'job', jsonEncode(job),
                  filename: 'job.json',
                  contentType: MediaType('application', 'json'))
          );
      //request.fields['job'] =  jsonEncode(job);

      /*request.files.add(
          http.MultipartFile(
              'picture',
              File(filename).readAsBytes().asStream(),
              File(filename).lengthSync(),
              filename: filename.split("/").last
          )
      );*/
      //ressult = request.headers.toString();
      var res = await request
          .send()
          .then((result) async {
            http.Response.fromStream(result).then((response) {
              if (response.statusCode == 200) {
                print("Uploaded! ");
                print('response.body ' + response.body);
              }
              return response;
              //ressult = JobModel.fromJson(jsonDecode(response.body));
            });
          })
          .catchError((err) => print('error : ' + err.toString()))
          .whenComplete(() {});
      result = res.body;
    } catch (error, stacktrace) {
      logger.severe("Exception occured in createJob $error $stacktrace", error,
          stacktrace);
      throw ServerException.withError(error: error);
    }

    return result;
  }

  @override
  Future<void> deleteJob(int id) async {
    try {
      await jobRestApiClient.deleteJob(id);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in deleteJob $error $stacktrace", error,
          stacktrace);
      throw ServerException.withError(error: error);
    }
  }

  @override
  Future<JobResponse> showJob(int id) async {
    JobResponse reponse = JobResponse();

    JobModel result;
    try {
      result = await jobRestApiClient.showJob(id);
      reponse.jobFromModel(result);
    } catch (error, stacktrace) {
      logger.severe(
          "Exception occured in showJob $error $stacktrace", error, stacktrace);
      reponse.exception = ServerException.withError(error: error);
    }

    return reponse;
  }

  @override
  Future<JobResponse> updateJob(JobModel job) async {
    JobResponse reponse = JobResponse();

    JobModel result;
    try {
      result = await jobRestApiClient.updateJob(job.id, job);
      reponse.jobFromModel(result);
    } catch (error, stacktrace) {
      logger.severe(
          "Exception occured in showJob $error $stacktrace", error, stacktrace);
      reponse.exception = ServerException.withError(error: error);
    }

    return reponse;
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_rest_api_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ClientRestApiClient implements ClientRestApiClient {
  _ClientRestApiClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://localhost:3001/api/v1/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<List<ClientModel>> listClients() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('/clients',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => ClientModel.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<ClientModel> createClient(client) async {
    ArgumentError.checkNotNull(client, 'client');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(client ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('/clients',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ClientModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<ClientModel> showClient(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/clients/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ClientModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<ClientModel> updateClient(id, client) async {
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(client, 'client');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(client ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('/clients/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PATCH',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ClientModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<ClientModel> findClientWithEmail(email) async {
    ArgumentError.checkNotNull(email, 'email');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/client_by_email?email=$email',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ClientModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<void> deleteClient(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    await _dio.request<void>('/clients/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'DELETE',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return null;
  }
}

import 'package:dio/dio.dart';
import 'package:pathfinder_for_webspark/core/errors/app_exception.dart';
import 'package:pathfinder_for_webspark/data/dto/api_response_dto.dart';
import 'package:pathfinder_for_webspark/data/dto/result_dto.dart';
import 'package:pathfinder_for_webspark/data/dto/send_response_dto.dart';
import 'package:pathfinder_for_webspark/data/dto/task_dto.dart';

class PathApiService {
  final Dio _dio;

  PathApiService(this._dio);

  Future<List<TaskDto>> fetchTasks(String url) async {
    try {
      final response = await _dio.get<dynamic>(url);
      final data = _unwrap(response.data);

      if (data is! List) {
        throw const InvalidDataException('Unexpected format of tasks List');
      }
      return data
          .map((e) => TaskDto.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _toAppException(e);
    } on TypeError {
      throw const InvalidDataException('Unexpected format of server response');
    } on FormatException {
      throw const InvalidDataException('Unexpected format of server response');
    }
  }

  Future<List<SendResponseDto>> sendResults(
    String url,
    List<ResultDto> results,
  ) async {
    try {
      final response = await _dio.post<dynamic>(
        url,
        data: results.map((r) => r.toJson()).toList(),
      );
      final data = _unwrap(response.data);

      if (data is! List) {
        throw const InvalidDataException(
          'Unexpected format of server response',
        );
      }
      return data
          .map((e) => SendResponseDto.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _toAppException(e);
    } on TypeError {
      throw const InvalidDataException('Unexpected format of server response');
    } on FormatException {
      throw const InvalidDataException('Unexpected format of server response');
    }
  }

  dynamic _unwrap(dynamic body) {
    if (body is! Map<String, dynamic>) {
      throw const InvalidDataException('Server returned a non-JSON response');
    }
    final envelope = ApiResponseDto.fromJson(body);
    if (envelope.error) {
      throw ServerException(
        envelope.message.isEmpty
            ? 'Server reported an error'
            : envelope.message,
      );
    }
    return envelope.data;
  }

  AppException _toAppException(DioException e) {
    final status = e.response?.statusCode;
    final serverMessage = _extractMessage(e.response?.data);

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkException('The server took too long to respond');
      case DioExceptionType.connectionError:
        return const NetworkException('Cannot connect to the server');
      case DioExceptionType.badResponse:
        if (status == 429) {
          return TooManyRequestsException(
            serverMessage ?? 'Too many requests, try again later',
          );
        }
        return ServerException(
          serverMessage ?? 'Server error ($status)',
          statusCode: status,
        );
      default:
        return const NetworkException('Request failed. Check the URL');
    }
  }

  String? _extractMessage(dynamic body) {
    if (body is Map<String, dynamic>) {
      final message = body['message'];
      if (message is String && message.isNotEmpty) return message;
    }
    return null;
  }
}

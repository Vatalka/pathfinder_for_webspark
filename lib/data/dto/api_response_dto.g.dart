// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponseDto _$ApiResponseDtoFromJson(Map<String, dynamic> json) =>
    ApiResponseDto(
      error: json['error'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      data: json['data'],
    );

Map<String, dynamic> _$ApiResponseDtoToJson(ApiResponseDto instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'data': instance.data,
    };

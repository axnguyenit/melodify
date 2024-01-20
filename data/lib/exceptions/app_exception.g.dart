// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_exception.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppError _$AppErrorFromJson(Map<String, dynamic> json) => AppError(
      key: json['key'] as String,
      code: json['code'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$AppErrorToJson(AppError instance) => <String, dynamic>{
      'key': instance.key,
      'code': instance.code,
      'message': instance.message,
    };

AppException _$AppExceptionFromJson(Map<String, dynamic> json) => AppException(
      message: json['message'] as String,
      errors: (json['errors'] as List<dynamic>?)
              ?.map((e) => AppError.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$AppExceptionToJson(AppException instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
    };

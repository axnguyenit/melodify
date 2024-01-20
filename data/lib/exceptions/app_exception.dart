import 'package:json_annotation/json_annotation.dart';

part 'app_exception.g.dart';

@JsonSerializable(includeIfNull: false)
class AppError {
  @JsonKey(name: 'key')
  final String key;

  @JsonKey(name: 'code')
  final String code;

  @JsonKey(name: 'message')
  final String message;

  AppError({
    required this.key,
    required this.code,
    required this.message,
  });

  factory AppError.fromJson(Map<String, dynamic> json) =>
      _$AppErrorFromJson(json);
}

@JsonSerializable(includeIfNull: false)
class AppException implements Exception {
  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'errors', defaultValue: [])
  final List<AppError> errors;

  AppException({
    required this.message,
    required this.errors,
  });

  factory AppException.fromJson(Map<String, dynamic> json) =>
      _$AppExceptionFromJson(json);

  @override
  String toString() {
    return '──> $message';
  }
}

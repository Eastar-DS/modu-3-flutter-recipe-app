import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@freezed
class Result<T> with _$Result<T>{
  const factory Result.success(T data) = Success;
  const factory Result.error(Exception e) = Errors;
}


import 'package:meta/meta.dart';

@immutable
class ApiResult<T> {
  final T? data;
  final Object? error;


  const ApiResult._({this.data, this.error});
  bool get isSuccess => error == null;

  factory ApiResult.success(T data) => ApiResult._(data: data);
  factory ApiResult.failure(Object error) => ApiResult._(error: error.toString());

}


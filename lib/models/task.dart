import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'task.freezed.dart';

@freezed
class Task with _$Task {
  const factory Task({
    required String id,
    required String title,
    @Default(false) bool isCompleted,
    @Default(false) bool isFavorite,
  }) = _Task;
}

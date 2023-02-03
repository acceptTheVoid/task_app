import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:task_app/models/task_step.dart';

part 'task.freezed.dart';

@freezed
class Task with _$Task {
  const factory Task({
    required String id,
    required String title,
    required DateTime timeOfCreation,
    @Default(false) bool isCompleted,
    @Default(false) bool isFavorite,
    @Default([]) List<TaskStep> taskSteps,
  }) = _Task;
}

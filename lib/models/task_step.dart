import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'task_step.freezed.dart';

@freezed
class TaskStep with _$TaskStep {
  const factory TaskStep({
    required String id,
    required String description,
    @Default(false) bool isCompleted,
  }) = _TaskStep;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Task {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  DateTime get timeOfCreation => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  bool get isFavorite => throw _privateConstructorUsedError;
  List<TaskStep> get taskSteps => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TaskCopyWith<Task> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskCopyWith<$Res> {
  factory $TaskCopyWith(Task value, $Res Function(Task) then) =
      _$TaskCopyWithImpl<$Res, Task>;
  @useResult
  $Res call(
      {String id,
      String title,
      DateTime timeOfCreation,
      bool isCompleted,
      bool isFavorite,
      List<TaskStep> taskSteps});
}

/// @nodoc
class _$TaskCopyWithImpl<$Res, $Val extends Task>
    implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? timeOfCreation = null,
    Object? isCompleted = null,
    Object? isFavorite = null,
    Object? taskSteps = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      timeOfCreation: null == timeOfCreation
          ? _value.timeOfCreation
          : timeOfCreation // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      taskSteps: null == taskSteps
          ? _value.taskSteps
          : taskSteps // ignore: cast_nullable_to_non_nullable
              as List<TaskStep>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TaskCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$$_TaskCopyWith(_$_Task value, $Res Function(_$_Task) then) =
      __$$_TaskCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      DateTime timeOfCreation,
      bool isCompleted,
      bool isFavorite,
      List<TaskStep> taskSteps});
}

/// @nodoc
class __$$_TaskCopyWithImpl<$Res> extends _$TaskCopyWithImpl<$Res, _$_Task>
    implements _$$_TaskCopyWith<$Res> {
  __$$_TaskCopyWithImpl(_$_Task _value, $Res Function(_$_Task) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? timeOfCreation = null,
    Object? isCompleted = null,
    Object? isFavorite = null,
    Object? taskSteps = null,
  }) {
    return _then(_$_Task(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      timeOfCreation: null == timeOfCreation
          ? _value.timeOfCreation
          : timeOfCreation // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      taskSteps: null == taskSteps
          ? _value._taskSteps
          : taskSteps // ignore: cast_nullable_to_non_nullable
              as List<TaskStep>,
    ));
  }
}

/// @nodoc

class _$_Task with DiagnosticableTreeMixin implements _Task {
  const _$_Task(
      {required this.id,
      required this.title,
      required this.timeOfCreation,
      this.isCompleted = false,
      this.isFavorite = false,
      final List<TaskStep> taskSteps = const []})
      : _taskSteps = taskSteps;

  @override
  final String id;
  @override
  final String title;
  @override
  final DateTime timeOfCreation;
  @override
  @JsonKey()
  final bool isCompleted;
  @override
  @JsonKey()
  final bool isFavorite;
  final List<TaskStep> _taskSteps;
  @override
  @JsonKey()
  List<TaskStep> get taskSteps {
    if (_taskSteps is EqualUnmodifiableListView) return _taskSteps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_taskSteps);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Task(id: $id, title: $title, timeOfCreation: $timeOfCreation, isCompleted: $isCompleted, isFavorite: $isFavorite, taskSteps: $taskSteps)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Task'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('timeOfCreation', timeOfCreation))
      ..add(DiagnosticsProperty('isCompleted', isCompleted))
      ..add(DiagnosticsProperty('isFavorite', isFavorite))
      ..add(DiagnosticsProperty('taskSteps', taskSteps));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Task &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.timeOfCreation, timeOfCreation) ||
                other.timeOfCreation == timeOfCreation) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            const DeepCollectionEquality()
                .equals(other._taskSteps, _taskSteps));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title, timeOfCreation,
      isCompleted, isFavorite, const DeepCollectionEquality().hash(_taskSteps));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TaskCopyWith<_$_Task> get copyWith =>
      __$$_TaskCopyWithImpl<_$_Task>(this, _$identity);
}

abstract class _Task implements Task {
  const factory _Task(
      {required final String id,
      required final String title,
      required final DateTime timeOfCreation,
      final bool isCompleted,
      final bool isFavorite,
      final List<TaskStep> taskSteps}) = _$_Task;

  @override
  String get id;
  @override
  String get title;
  @override
  DateTime get timeOfCreation;
  @override
  bool get isCompleted;
  @override
  bool get isFavorite;
  @override
  List<TaskStep> get taskSteps;
  @override
  @JsonKey(ignore: true)
  _$$_TaskCopyWith<_$_Task> get copyWith => throw _privateConstructorUsedError;
}

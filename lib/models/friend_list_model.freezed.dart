// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friend_list_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FriendListModel _$FriendListModelFromJson(Map<String, dynamic> json) {
  return _FriendListModel.fromJson(json);
}

/// @nodoc
mixin _$FriendListModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FriendListModelCopyWith<FriendListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FriendListModelCopyWith<$Res> {
  factory $FriendListModelCopyWith(
          FriendListModel value, $Res Function(FriendListModel) then) =
      _$FriendListModelCopyWithImpl<$Res, FriendListModel>;
  @useResult
  $Res call({String id, String name, String status});
}

/// @nodoc
class _$FriendListModelCopyWithImpl<$Res, $Val extends FriendListModel>
    implements $FriendListModelCopyWith<$Res> {
  _$FriendListModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FriendListModelCopyWith<$Res>
    implements $FriendListModelCopyWith<$Res> {
  factory _$$_FriendListModelCopyWith(
          _$_FriendListModel value, $Res Function(_$_FriendListModel) then) =
      __$$_FriendListModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String status});
}

/// @nodoc
class __$$_FriendListModelCopyWithImpl<$Res>
    extends _$FriendListModelCopyWithImpl<$Res, _$_FriendListModel>
    implements _$$_FriendListModelCopyWith<$Res> {
  __$$_FriendListModelCopyWithImpl(
      _$_FriendListModel _value, $Res Function(_$_FriendListModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? status = null,
  }) {
    return _then(_$_FriendListModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FriendListModel implements _FriendListModel {
  const _$_FriendListModel(
      {required this.id, required this.name, required this.status});

  factory _$_FriendListModel.fromJson(Map<String, dynamic> json) =>
      _$$_FriendListModelFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String status;

  @override
  String toString() {
    return 'FriendListModel(id: $id, name: $name, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FriendListModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FriendListModelCopyWith<_$_FriendListModel> get copyWith =>
      __$$_FriendListModelCopyWithImpl<_$_FriendListModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FriendListModelToJson(
      this,
    );
  }
}

abstract class _FriendListModel implements FriendListModel {
  const factory _FriendListModel(
      {required final String id,
      required final String name,
      required final String status}) = _$_FriendListModel;

  factory _FriendListModel.fromJson(Map<String, dynamic> json) =
      _$_FriendListModel.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get status;
  @override
  @JsonKey(ignore: true)
  _$$_FriendListModelCopyWith<_$_FriendListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

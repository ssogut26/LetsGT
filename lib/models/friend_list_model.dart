import 'package:freezed_annotation/freezed_annotation.dart';

part 'friend_list_model.freezed.dart';
part 'friend_list_model.g.dart';

@freezed
class FriendListModel with _$FriendListModel {
  const factory FriendListModel({
    required String id,
    required String name,
    required String status,
  }) = _FriendListModel;

  factory FriendListModel.fromJson(Map<String, Object?> json) =>
      _$FriendListModelFromJson(json);
}

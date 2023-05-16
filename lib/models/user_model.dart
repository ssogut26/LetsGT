import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:letsgt/models/friend_list_model.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    String? id,
    String? name,
    String? profilePictureUrl,
    String? status,
    List<FriendListModel>? friends,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, Object?> json) =>
      _$UserModelFromJson(json);
}

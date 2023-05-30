import 'dart:math';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:letsgt/features/create_post/domain/repository/create_post_repository.dart';
import 'package:letsgt/models/PostsModel.dart';

class CreatePostRepositoryImpl implements CreatePostRepository {
  @override
  Future<void> createPost(
    String description,
    String location,
    String imageURL,
  ) async {
    final attributes = await Amplify.Auth.fetchUserAttributes();
    final userName = attributes
        .firstWhere((element) => element.userAttributeKey.key == 'name')
        .value;
    final randomId = Random().nextInt(10000);
    final postModel = PostsModel(
      id: randomId.toString(),
      description: description,
      shortLocation: location,
      createdBy: userName,
      imageURL: imageURL,
    );

    try {
      final request = ModelMutations.create(postModel);
      final response = await Amplify.API.mutate(request: request).response;
      final createdPost = response.data;
      if (createdPost == null) {
        safePrint('errors: ${response.errors}');
        return;
      }
      safePrint('Mutation result: ${createdPost.description}');
    } on ApiException catch (e) {
      safePrint('Error creating post: ${e.message}');
    }
  }
}

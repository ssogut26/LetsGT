import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:letsgt/features/auth/domain/usecases/auth_usecases.dart';
import 'package:letsgt/features/create_post/domain/repository/create_post_repository.dart';
import 'package:letsgt/models/PostsModel.dart';

class CreatePostRepositoryImpl implements CreatePostRepository {
  @override
  Future<void> createPost(
    String description,
    String location,
    String randomId,
  ) async {
    final userName = await AuthUseCases().getUserName();
    ///!TODO Try to implement image url to post model for not making
    // second request for the get image url
    // final image = Amplify.Storage.getUrl(key: randomId);
    // final imageResult = await image.result;
    // final imageUrl = imageResult.url.toString();
    final postModel = PostsModel(
      id: randomId,
      description: description,
      shortLocation: location,
      // imageUrl: imageUrl,
      createdBy: userName,
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

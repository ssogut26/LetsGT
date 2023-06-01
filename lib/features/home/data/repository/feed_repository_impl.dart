import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:letsgt/features/home/domain/repository/feed_repository.dart';
import 'package:letsgt/models/PostsModel.dart';

class FeedRepositoryImpl implements FeedRepository {
  @override
  Future<List<PostsModel>> getPosts() async {
    final request = ModelQueries.list(
      PostsModel.classType,
    );
    final response = await Amplify.API.query(request: request).response;
    final posts = response.data?.items;
    if (posts != null) {
      return posts.map((e) => PostsModel.fromJson(e!.toJson())).toList();
    } else {
      return [];
    }
  }

  @override
  Future<String> getPostImage(String key) async {
    try {
      final image = Amplify.Storage.getUrl(key: key);
      final result = await image.result;
      return result.url.toString();
    } on StorageException catch (e) {
      safePrint('Error getting post image: $e');
      return '';
    }
  }
}

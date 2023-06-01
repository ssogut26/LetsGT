import 'package:letsgt/models/ModelProvider.dart';

abstract class FeedRepository {
  Future<List<PostsModel>> getPosts();
  Future<String> getPostImage(String key);
}

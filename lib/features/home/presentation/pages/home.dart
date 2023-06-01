import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:letsgt/config/routes/routes.dart';
import 'package:letsgt/core/usecases/extensions.dart';
import 'package:letsgt/core/usecases/paddings.dart';
import 'package:letsgt/features/activities/presentation/pages/activities.dart';
import 'package:letsgt/features/home/data/repository/feed_repository_impl.dart';
import 'package:letsgt/features/messages/presentation/pages/messages.dart';
import 'package:letsgt/features/my_profile/presentation/pages/my_profile.dart';
import 'package:letsgt/models/ModelProvider.dart';

class SelectedIndexNotifier extends ChangeNotifier {
  int? selectedPage = 0;
  void changeIndex(int index) {
    selectedPage = index;
    notifyListeners();
  }
}

final selectedIndexProvider = ChangeNotifierProvider(
  (ref) => SelectedIndexNotifier(),
);

@RoutePage()
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider).selectedPage;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () {
          AutoRouter.of(context).push(const CreatePostRoute());
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: [
          const Text('Feed'),
          const Text('Messages'),
          const Text('Activities'),
          const Text('Profile'),
        ][selectedIndex ?? 0],
        actions: [
          if (selectedIndex == 3)
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit),
            )
          else
            Container(),
        ],
      ),
      body: [
        const FeedView(),
        const MessagesPage(),
        const ActivitiesPage(),
        const ProfilePage(),
      ][selectedIndex ?? 0],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.cruelty_free_rounded),
            label: 'Feed',
          ),
          NavigationDestination(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          NavigationDestination(
            icon: Icon(Icons.landscape),
            label: 'Activities',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedIndex: selectedIndex ?? 0,
        onDestinationSelected: (index) {
          ref.read(selectedIndexProvider).changeIndex(index);
        },
      ),
    );
  }
}

final getPostsProvider =
    FutureProvider.autoDispose<List<PostsModel>>((ref) async {
  final posts = await FeedRepositoryImpl().getPosts();

  return posts;
});

class FeedView extends ConsumerStatefulWidget {
  const FeedView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => FeedViewState();
}

class FeedViewState extends ConsumerState<FeedView> {
  @override
  Widget build(BuildContext context) {
    final posts = ref.watch(getPostsProvider);
    return SafeArea(
      child: NestedScrollView(
        physics: const ClampingScrollPhysics(),
        body: RefreshIndicator.adaptive(
          onRefresh: () async {
            return ref.refresh(getPostsProvider);
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: posts.when(
              data: (posts) {
                return ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => const Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return PostCard(
                      post: posts[index],
                    );
                  },
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stackTrace) => const Center(
                child: Text('Error'),
              ),
            ),
          ),
        ),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            const SliverToBoxAdapter(
              child: Padding(
                padding: AppPaddings.pagePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'See what your friends are up to',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
      ),
    );
  }
}

final imageProvider =
    FutureProvider.autoDispose.family<String, String>((ref, key) async {
  final imageUrl = await FeedRepositoryImpl().getPostImage(key);
  return imageUrl;
});

class PostCard extends ConsumerStatefulWidget {
  const PostCard({
    required this.post,
    super.key,
  });

  final PostsModel post;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostCardState();
}

class _PostCardState extends ConsumerState<PostCard> {
  bool isLiked = false;
  final TransformationController _controller = TransformationController();

  void _onInteractionEnd(ScaleEndDetails details) {
    _controller.value = Matrix4.identity();
  }

  @override
  Widget build(BuildContext context) {
    final image = ref.watch(imageProvider(widget.post.id));
    return Expanded(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.55,
        child: Column(
          children: [
            Padding(
              padding: AppPaddings.pagePadding,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 20),
                    child: Text(
                      '${widget.post.createdBy} shared a post \n',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 4 / 3,
                    child: SizedBox(
                      child: image.when(
                        data: (image) {
                          return InkWell(
                            onDoubleTap: () {
                              setState(() {
                                isLiked = true;
                              });
                            },
                            child: InteractiveViewer(
                              transformationController: _controller,
                              onInteractionEnd: _onInteractionEnd,
                              child: CachedNetworkImage(
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                  child: CircularProgressIndicator(
                                    value: downloadProgress.progress,
                                  ),
                                ),
                                imageBuilder: (context, imageProvider) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                                imageUrl: image,
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                        },
                        error: (error, stackTrace) {
                          return const Center(
                            child: Text('Error'),
                          );
                        },
                        loading: () {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: AppPaddings.pagePadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  isLiked = !isLiked;
                                });
                              },
                              icon: isLiked
                                  ? const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                  : const Icon(Icons.favorite_border),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (context) => const CommentView(),
                                    fullscreenDialog: true,
                                  ),
                                );
                              },
                              icon: const Icon(Icons.comment),
                            ),
                          ],
                        ),
                        Padding(
                          padding: AppPaddings.textPadding,
                          child: Text(widget.post.description ?? ''),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CommentView extends StatelessWidget {
  const CommentView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: Layout(context).isKeyboardOpen
                ? MediaQuery.of(context).size.height * 0.30
                : MediaQuery.of(context).size.height * 0.75,
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return const ListTile(
                  leading: CircleAvatar(),
                  title: Text('User'),
                  subtitle: Text(
                    'This is a comment',
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: AppPaddings.textPadding,
            child: TextFormField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Add a comment',
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.send),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

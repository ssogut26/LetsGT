import 'dart:io';
import 'dart:math';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:letsgt/core/usecases/paddings.dart';
import 'package:letsgt/features/auth/presentation/pages/sign_up.dart';
import 'package:letsgt/features/create_post/data/repository/create_post_repository_impl.dart';

final imageProvider = StateNotifierProvider<ImagePickerNotifier, File?>(
  (ref) => ImagePickerNotifier(),
);

class ImagePickerNotifier extends StateNotifier<File?> {
  ImagePickerNotifier() : super(null);
  final picker = ImagePicker();
  AWSFile? image;
  final random = Random().nextInt(99999);

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 15,
      requestFullMetadata: true,
    );

    image = AWSFile.fromPath(
      pickedFile!.path,
    );
    state = File(pickedFile.path);
  }
}

class CreatePostNotifier extends ChangeNotifier {
  String? description;
  String? location;
  File? image;

  void setDescription(String? value) {
    description = value;
    notifyListeners();
  }

  void setLocation(String? value) {
    location = value;
    notifyListeners();
  }

  void setImage(File? value) {
    image = value;
    notifyListeners();
  }

  Future<void> createPost(String id) async {
    try {
      await CreatePostRepositoryImpl().createPost(
        description ?? '',
        location ?? '',
        id,
      );
    } on ApiException catch (e) {
      safePrint('Error creating post: ${e.message}');
    }
  }
}

final createPostNotifierProvider =
    ChangeNotifierProvider<CreatePostNotifier>((ref) => CreatePostNotifier());

@RoutePage()
class CreatePostPage extends ConsumerStatefulWidget {
  const CreatePostPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends ConsumerState<CreatePostPage> {
  @override
  Widget build(BuildContext context) {
    final pickedImage = ref.watch(imageProvider.notifier);
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              const SliverAppBar(
                title: Text('Create Post'),
              ),
            ];
          },
          body: Column(
            mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Consumer(
                builder: (context, ref, _) {
                  final image = ref.watch(imageProvider);
                  return image != null
                      ? Stack(
                          children: [
                            Image.file(
                              image,
                              isAntiAlias: true,
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                onPressed: () {
                                  ref
                                      .read(imageProvider.notifier)
                                      .pickImage(ImageSource.gallery);
                                },
                                icon: const Icon(
                                  Icons.edit,
                                ),
                              ),
                            ),
                          ],
                        )
                      : OutlinedButton.icon(
                          icon: const Icon(Icons.add),
                          label: const Text('Add Image'),
                          onPressed: () => ref
                              .read(imageProvider.notifier)
                              .pickImage(ImageSource.gallery),
                        );
                },
              ),
              Padding(
                padding: AppPaddings.pagePadding,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Add a description',
                      ),
                      onChanged: (value) {
                        ref
                            .read(createPostNotifierProvider.notifier)
                            .setDescription(value);
                      },
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Add a location',
                      ),
                      onChanged: (value) {
                        ref
                            .read(createPostNotifierProvider.notifier)
                            .setLocation(value);
                      },
                    ),
                    const SizedBox(height: 200),
                    AppElevatedButton(
                      text: 'Create a post',
                      onPressed: () {
                        ref
                            .read(createPostNotifierProvider.notifier)
                            .createPost(pickedImage.random.toString())
                            .whenComplete(
                              () => Amplify.Storage.uploadFile(
                                localFile: pickedImage.image!,
                                key: pickedImage.random.toString(),
                              ),
                            )
                            .whenComplete(() {
                          ref.read(imageProvider.notifier).image = null;
                          context.router.pop();
                        });
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

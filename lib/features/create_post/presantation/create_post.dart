import 'dart:io';

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

  bool isPicked = false;
  final picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      isPicked = true;
      state = File(pickedFile.path);
    } else {
      isPicked = false;
    }
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

  Future<void> createPost(
    String imageURL,
  ) async {
    await CreatePostRepositoryImpl().createPost(
      description ?? '',
      location ?? '',
      imageURL,
    );
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
      ),
      body: ListView(
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(height: 20),
                const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Add a description',
                  ),
                ),
                const SizedBox(height: 20),
                const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Add a location',
                  ),
                ),
                const SizedBox(height: 20),
                AppElevatedButton(
                  text: 'Create a post',
                  onPressed: () {
                    ref.read(createPostNotifierProvider.notifier).createPost(
                          'https://th.bing.com/th/id/R.e1707c345d5ac10c80a674030e606643?rik=pOsTg5KBoLuNvw&riu=http%3a%2f%2fwww.snut.fr%2fwp-content%2fuploads%2f2015%2f08%2fimage-de-paysage.jpg&ehk=1O5SWKkGpZ8yU%2b%2fAnLXG1v8k6BKxgyiXgHbOWBW1ir0%3d&risl=1&pid=ImgRaw&r=0',
                        );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
